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
parameter nstages        = 56;
		
input clk;
input 	[31:0] dataa, datab;
output 	[31:0] result;		
		
//Stage 1 => buffer the inputs

wire [31:0] a_buf, b_buf;

reg  [31:0] xfifo[0:nstages-1];
genvar i;
generate
	for (i = 0; i < nstages-1; i=i+1)
	begin:xfifo_gen
		always @(posedge clk) begin
			xfifo[i+1] <= xfifo[i];
		end
	end
endgenerate

`define STAGES 20
`include "../ahfp_pipeline_buffer/ahfp_pipeline_buffer.v"
ahfp_pipeline_buffer buf_a (clk, dataa, a_buf);
ahfp_pipeline_buffer buf_b (clk, datab, b_buf);		
`undef STAGES							
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

//buffer x again, after getting it
`define STAGES 5
`include "../ahfp_pipeline_buffer/ahfp_pipeline_buffer.v"
wire [31:0] x_buf;
`undef STAGES

wire [31:0] mul_cos_res, xcos_res;
wire [31:0] cos_add_half_res;

ahfp_mul_multi mul_cos (clk, float_cos_out_reg, {a_buf[31],a_buf[30:23]+1,a_buf[22:0]}, mul_cos_res);
ahfp_mul_multi mul_xcos(clk, mul_cos_res, xfifo[N-7], xcos_res);
ahfp_add_sub_multi cos_add_half (clk, xcos_res, float_one_half, cos_add_half_res); 

ahfp_mul_multi mulx(clk, cos_add_half_res, xfifo[N-1], result);

endmodule
