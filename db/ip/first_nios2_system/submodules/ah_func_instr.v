module ah_func_instr(	clk,
		dataa, // data
		datab, // sum result
		result,
		reset,
		clk_en
		);
			
parameter thirty_two	 = 32'h42000000;
parameter fixed_one 	 = 32'h20000000;
parameter fixed_zero 	 = 32'h00000000;
parameter float_one_half = 32'h3f000000;
parameter nstages        = 57;
		
input 	clk, clk_en, reset;
input 	[31:0] dataa, datab;
output 	[31:0] result;		
		
//Stage 1 => buffer the inputs

reg  [31:0] xfifo	[0:nstages-1];
reg  [31:0] sumfifo	[0:nstages-1];

always @(posedge clk) begin
		xfifo[0] <= dataa;
		sumfifo[0] <= datab;
end

genvar i;
generate
	for (i = 0; i < nstages-1; i=i+1)
	begin:xfifo_gen
		always @(posedge clk) begin
			xfifo[i+1] 		<= xfifo[i];
			sumfifo[i+1] 	<= sumfifo[i];
		end
	end
endgenerate
						
//Stage 1 => get the floor result

wire 	[31:0] floor_res;
reg 	[31:0] floor_res_reg;

ahfp_floor_divide_four floor (dataa, floor_res);

always @ (posedge clk) begin
	floor_res_reg <= floor_res;
end

//Stage 2 => subtract floor result from 

wire [31:0] floor_sub_res;

ahfp_add_sub_multi sub (floor_res_reg, thirty_two, floor_sub_res);
		
//Stage 3 => cos of the floor sub result

// get modulo of result
wire [31:0] mod_out;
ahfp_mod_pi mod_pi (clk, floor_sub_res, mod_out);
//convert to fixed
wire 	[31:0] fixed_theta_in;
reg 	[31:0] fixed_theta_in_reg;
ahfp_float_2_fixed float_2_fixed (clk, mod_out, fixed_theta_in);
always @ (posedge clk) begin
	fixed_theta_in_reg <= fixed_theta_in;
end

// => Stage 4: calculate cos

//calculate cos
wire	[31:0] cos;
reg	[31:0] cos_reg;
ahfp_cordic_fixed cordic (clk,fixed_one,fixed_zero,fixed_theta_in_reg,cos);
always @ (posedge clk) begin
	cos_reg <= cos;
end

//convert back to float
wire 	[31:0] float_cos_out;
reg 	[31:0] float_cos_out_reg;
ahfp_fixed_2_float fixed_2_float (clk,cos_reg,float_cos_out);

//Stage 5 => multiply with cos and add 1

wire [31:0] xcos_res;
wire [31:0] cos_add_half_res;

//ahfp_mul_multi mul_cos (clk, float_cos_out_reg, {a_buf[31],a_buf[30:23]+1,a_buf[22:0]}, mul_cos_res);
ahfp_mul_multi mul_xcos(clk, float_cos_out, xfifo[38], xcos_res);
ahfp_add_sub_multi cos_add_half (clk, xcos_res, float_one_half, cos_add_half_res); 

wire [31:0] mulx_res;

ahfp_mul_multi mulx(clk, cos_add_half_res, xfifo[51], mulx_res);

ahfp_add_sub_multi add_sum(clk, mulx_res,sumfifo[57],result); 

endmodule
