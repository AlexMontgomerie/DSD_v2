`include "../ahfp_mul_multi/ahfp_mul_multi.v"
`include "../ahfp_mod_pi/ahfp_mod_pi.v"
`include "../ahfp_pipeline_buffer/ahfp_pipeline_buffer.v"
`include "../ahfp_floor_divide_four/ahfp_floor_divide_four.v"
`include "../ahfp_add_sub_multi/ahfp_add_sub_multi.v"
`include "../ahfp_float_2_fixed/ahfp_float_2_fixed.v"
`include "../ahfp_cordic_fixed/ahfp_cordic_fixed.v"
`include "../ahfp_fixed_2_float/ahfp_fixed_2_float.v"

module ah_func(	clk,
				dataa,
				datab,
				result
			);
			
parameter thirty_two	= 32'h00000000;
parameter fixed_one 	= 32'h20000000;
parameter fixed_zero 	= 32'h00000000;
		
input clk;
input 	[31:0] dataa, datab;
output 	[31:0] result;		
		
//Stage 1 => buffer the inputs

wire [31:0] a_buf, b_buf;

`define STAGES 20
ahfp_pipeline_buffer buf_a (clk, dataa, a_buf);
ahfp_pipeline_buffer buf_b (clk, datab, b_buf);		
`undef STAGES							
//Stage 1 => get the floor result

wire 	[31:0] floor_res;
reg		[31:0] floor_res_reg;

ahfp_floor_divide_four floor (dataa, floor_res);
always @(posedge clk) begin
	floor_res_reg <= floor_res;
end

//Stage 2 => subtract floor result from 

wire [31:0] floor_sub_res;

ahfp_add_sub_multi sub (clk,floor_res_reg,thirty_two,floor_sub_res);
		
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

//calculate cos
wire	[31:0] cos;
ahfp_cordic_fixed cordic (fixed_one,fixed_zero,fixed_theta_in_reg,cos);

//convert back to float
wire 	[31:0] float_cos_out;
reg 	[31:0] float_cos_out_reg;
ahfp_fixed_2_float fixed_2_float (cos,float_cos_out);
always @(posedge clk) begin
	float_cos_out_reg <= float_cos_out;
end

//Stage 4 => multiply with cos and add 1

//buffer x again, after getting it
`define STAGES 5
wire [31:0] x_buf;
`undef STAGES

wire [31:0] mul_cos_res;
wire [31:0] cos_add_one_res;
ahfp_mul_multi mul_cos (clk, float_cos_out_reg, {a_buf[31],a_buf[30:23]+1,a_buf[22:0]}, mul_cos_res);
ahfp_add_sub_multi cos_add_one (clk, mul_cos_res, float_one, cos_add_one_res); 

endmodule
