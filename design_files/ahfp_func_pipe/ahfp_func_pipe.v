`include "../ahfp_mul_multi/ahfp_mul_multi.v"
`include "../ahfp_mod_pi/ahfp_mod_pi.v"
`include "../ahfp_floor_divide_four/ahfp_floor_divide_four.v"
`include "../ahfp_add_sub_multi/ahfp_add_sub_multi.v"
`include "../ahfp_float_2_fixed/ahfp_float_2_fixed.v"
`include "../ahfp_cordic_fixed/ahfp_cordic_fixed.v"
`include "../ahfp_fixed_2_float/ahfp_fixed_2_float.v"
`include "../ahfp_mult/ahfp_mult.v"

module ah_func(	clk,
		dataa,
		datab,
		result);
			
parameter thirty_two	 = 32'h42000000;
parameter fixed_one 	 = 32'h20000000;
parameter fixed_zero 	 = 32'h00000000;
parameter float_one_half = 32'h3f000000;
parameter nstages        = 51;
		
input clk;
input 	[31:0] dataa, datab;
output 	[31:0] result;		
		
//Stage 1 => buffer the inputs

reg  [31:0] xfifo[0:nstages-1];

always @(posedge clk) begin
		xfifo[0] <= dataa;
end

genvar i;
generate
	for (i = 0; i < nstages-1; i=i+1)
	begin:xfifo_gen
		always @(posedge clk) begin
			xfifo[i+1] <= xfifo[i];
		end
	end
endgenerate
						
//Stage 1 => get the floor result

wire 	[31:0] floor_res;

ahfp_floor_divide_four floor (dataa, floor_res);

//Stage 2 => subtract floor result from 

wire [31:0] floor_sub_res;

ahfp_add_sub_multi sub (clk,floor_res, thirty_two, floor_sub_res);
		
//Stage 3 => cos of the floor sub result

// get modulo of result
wire [31:0] mod_out;
ahfp_mod_pi mod_pi (clk, floor_sub_res, mod_out);
//convert to fixed
wire 	[31:0] fixed_theta_in;
reg 	[31:0] fixed_theta_in_reg;
ahfp_float_2_fixed float_2_fixed (mod_out, fixed_theta_in);

always @(posedge clk) begin
	fixed_theta_in_reg <= fixed_theta_in;
end

// => Stage 4: calculate cos

//calculate cos
wire	[31:0] cos;
ahfp_cordic_fixed cordic (clk,fixed_one,fixed_zero,fixed_theta_in_reg,cos);

//convert back to float
wire 	[31:0] float_cos_out;
reg 	[31:0] float_cos_out_reg;
ahfp_fixed_2_float fixed_2_float (cos,float_cos_out);
always @(posedge clk) begin
	float_cos_out_reg <= float_cos_out;
end

//Stage 5 => multiply with cos and add 1

wire [31:0] xcos_res;
wire [31:0] cos_add_half_res;

//ahfp_mul_multi mul_cos (clk, float_cos_out_reg, {a_buf[31],a_buf[30:23]+1,a_buf[22:0]}, mul_cos_res);
ahfp_mul_multi mul_xcos(clk, float_cos_out_reg, xfifo[37], xcos_res);
ahfp_add_sub_multi cos_add_half (clk, xcos_res, float_one_half, cos_add_half_res); 

ahfp_mul_multi mulx(clk, cos_add_half_res, xfifo[50], result);

endmodule

module accumulate (
	clk,
	data,
	start,
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
		count = count - 1;
	
	//start signal resets accumulator
	if(start==1) begin
	//send 0 to both dataa and datab
		dataa <= 32'd0;
		datab <= 32'd0;
		count <= 3'd7;
	end
	else begin
		//for valid result
		if(valid == 1 && count == 0) begin
			dataa <= data;
			datab <= res;
		end 
		else if(valid == 1 && count != 0) begin
			dataa <= data;
			datab <= 32'd0;		
		end
	end
end

// deal with accumulating pipeline
reg [2:0] done_count;
reg [2:0] done_acc_count;

reg [31:0] buffer [2:0];

parameter buffer_in  = 2'b01;
parameter buffer_acc = 2'b10;

reg [1:0] done_state;

genvar i;
for(i=0;i<6;i=i+1) begin: done
	done_reg = 1'b0;
	done_count = done_count + 1;
	
	if(finished==1) begin
		done_state = buffer_in;
		done_count = 3'd0;
		done_acc_count = 0;
	end
	else 
		done_state = idle;

	case(done_state)
	idle:
		done_state = idle;
	
	buffer_in:
	begin
		buffer[0] <= res;
		buffer[i+1] <= buffer[i];
		dataa <= 32'd0;
		datab <= 32'd0;
		if (done_count==3'd7)
			done_state = buffer_acc;
	end
	buffer_acc:
	begin
		if(done_count==3'd7) begin
		done_acc_count <= done_acc_count + 1;
		dataa <= res;
		datab <= buffer[6];
		buffer[i+1] <= buffer[i];
		end
		else begin
			dataa <= 32'd0;
			datab <= 32'd0;
		end
		if (done_acc_count == 3'd7) begin
			done_state = idle;
			done_reg = 1'b1;
		end
	end
	endcase
end

assign result = res;
assign done = done_reg;
	
endmodule
