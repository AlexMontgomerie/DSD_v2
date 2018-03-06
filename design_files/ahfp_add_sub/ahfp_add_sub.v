//TODO: 
// - create a testbench

module ahfp_add_sub(
	clk,
	dataa,
	datab,
	result);
	
input clk;
input [31:0] dataa;
input [31:0] datab;

wire [31:0] add_a, add_b, add_res;
wire [31:0] sub_a, sub_b, sub_res;

reg [31:0] res;

output [31:0] result;

wire a_s,b_s;

assign a_s = dataa[31];
assign b_s = datab[31];

wire out_mux;
// 0 - addition
// 1 - subtraction

ahfp_add add (	.dataa(add_a),
				.datab(add_b),
				.result(add_res)
				);

ahfp_sub sub (	.dataa(sub_a),
				.datab(sub_b),
				.result(sub_res)
				);
	
assign sub_a = 	(a_s==1 && b_s==0) ? datab :
				(b_s==1 && a_s==0) ? dataa :
							32'd0 ;
							
assign sub_b = 	(a_s==1 && b_s==0) ? dataa :
				(b_s==1 && a_s==0) ? datab :
							32'd0 ;
							
assign add_a = 	dataa;
assign add_b = 	datab;					
							
assign out_mux = 	(a_s==1 && b_s==0) ? 1'b1 :
					(b_s==1 && a_s==0) ? 1'b1 :
					(b_s==0 && a_s==0) ? 1'b0 :
					(b_s==1 && a_s==1) ? 1'b0 :
										 1'b0 ;
	
/*	
if(a_s>b_s) begin
	assign sub_a = datab;
	assign sub_b = dataa;
	assign out_mux = 1'b1;
	end
	
else if(b_s>a_s) begin
	assign sub_a = dataa;
	assign sub_b = datab;
	assign out_mux = 1'b1;
	end
	
else if(b_s==0 && a_s==0) begin
	assign add_a = dataa;
	assign add_b = datab;
	assign out_mux = 1'b0;
	end

else if(b_s==1 && a_s==1) begin
	assign add_a = dataa;
	assign add_b = datab;
	assign out_mux = 1'b0;
	end	
*/

always @(posedge clk)
	begin
		if (out_mux)
			res <= sub_res;
		else	
			res <= add_res;
	end

assign result = out_mux ? sub_res : add_res;

endmodule