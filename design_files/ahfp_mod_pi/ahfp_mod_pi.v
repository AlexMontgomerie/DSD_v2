`include "../ahfp_mul_multi/ahfp_mul_multi.v"
`include "../ahfp_floor/ahfp_floor.v"
`include "../ahfp_add_sub_multi/ahfp_add_sub_multi.v"
module ahfp_mod_pi (clk,
					data,
					result
					);

parameter pi_inv 	= 32'h3EA2F983;
parameter pi 		= 32'h40490FDB;

input clk;
input 	[31:0] data;
output 	[31:0] result;				
		
wire [31:0] floor_in;
wire [31:0] floor_out;

//TODO: need to buffer data for last sub
wire [31:0] mod_buf_val, mul_b_out;
`define STAGES 12
`include "../ahfp_pipeline_buffer/ahfp_pipeline_buffer.v"
ahfp_pipeline_buffer mod_buf(clk, data, mod_buf_val);
`undef STAGES
ahfp_mul_multi mul_a 	(clk, data, pi_inv, floor_in);
ahfp_floor floor		(floor_in, floor_out);
ahfp_mul_multi mul_b 	(clk, floor_out, pi, mul_b_out);
ahfp_add_sub_multi sub 	(clk, mod_buf_val, {~mul_b_out[31],mul_b_out[30:0]}, result);
endmodule