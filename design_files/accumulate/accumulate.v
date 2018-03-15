`include "../ahfp_add_sub_multi/ahfp_add_sub_multi.v"
module accumulate (
	clk,
	data,
	start,
	valid,
	finished,
	done,
	result
	);

input [31:0] data;
input clk, start, valid, finished;

output [31:0] result;
output done;

//dataa - ah_func result
//datab - res
reg [31:0] dataa,datab;
wire [31:0] res;

reg [2:0] count;

reg done_reg;
//create add_sub block

ahfp_add_sub_multi acc(clk, dataa, datab, res); 

always @(posedge clk) begin
	done_reg = 1'b0;
	//counter for pipeline
	if(count != 0) 
		count <= count - 1;
	
	//start signal resets accumulator
	if(start==1) begin
	//send 0 to both dataa and datab
		dataa <= 32'd0;
		datab <= 32'd0;
		count <= 3'd7;
	end
	else begin
		//for valid result
		if(valid == 1 && count == 3'd0) begin
			dataa <= data;
			datab <= res;
		end 
		else if(valid == 1 && count != 3'd0) begin
			dataa <= data;
			datab <= 32'd0;		
		end
	end
end

// deal with accumulating pipeline
reg [2:0] done_count;
reg [2:0] done_acc_count;

reg [31:0] buffer [6:0];

parameter buffer_in  = 3'b100;
parameter buffer_acc = 3'b010;
parameter idle       = 3'b001;

reg [2:0] done_state;

initial done_state = idle;

genvar i;
generate
for(i=0;i<6;i=i+1) begin: done_loop
always @ (posedge clk) begin
	if (done_count == 3'd6)
		done_count <= 0;
	else
		done_count <= done_count + 1;

	case(done_state)
	idle:
	begin
		if(finished==1) begin
			done_reg <= 1'b0;
			done_state <= buffer_in;
			done_count <= 3'd0;
			done_acc_count <= 0;
		end
		else 
			done_state <= idle;
	end
	buffer_in:
	begin
		buffer[0] <= res;
		buffer[i+1] <= buffer[i];
		dataa <= 32'd0;
		datab <= 32'd0;
		if (done_count==3'd6)
			done_state <= buffer_acc;
	end
	buffer_acc:
	begin
		if(done_count==3'd0) begin
		done_acc_count <= done_acc_count + 1;
		dataa <= res;
		datab <= buffer[6];
		buffer[i+1] <= buffer[i];
		end
		else begin
			dataa <= 32'd0;
			datab <= 32'd0;
		end
		if (done_acc_count == 3'd6) begin
			done_state <= idle;
			done_reg <= 1'b1;
		end
	end
	endcase
end
end
endgenerate

assign result = done_reg ? res : 32'd0;
assign done = done_reg;
	
endmodule