//TODO: 
// - create a testbench
module ahfp_add_sub_multi(
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



parameter STAGES = 7;

reg out_mux_buf [STAGES-1:0];

always @(posedge clk) begin
		out_mux_buf[0] <= out_mux;
end

genvar i;
generate
	for (i = 0; i < STAGES-1; i=i+1)
	begin:mod_buf_gen
		always @(posedge clk) begin
			out_mux_buf[i+1] <= out_mux_buf[i];
		end
	end
endgenerate				

ahfp_add_multi add (.clk(clk),
					.dataa(add_a),
					.datab(add_b),
					.result(add_res)
					);

ahfp_sub_multi sub (.clk(clk),
					.dataa(sub_a),
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

assign result = out_mux_buf[STAGES-1] ? sub_res : add_res;

endmodule