// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_cordic;

reg clk;
reg [31:0] 		x_start,
				y_start,
				theta,
				x_cos_correct,
				y_sin_correct;

wire [31:0] 	x_cos, y_sin;

ahfp_cordic dut (.clk(clk),
				.x_start(x_start),
				.y_start(y_start),
				.theta(theta),
				.x_cos(x_cos),
				.y_sin(y_sin)
				);

initial // Clock generator
  begin
    clk = 1;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
		//test 1 (time 0ns)
		x_start <= #(0) 32'h3F800000;
		y_start <= #0 32'h00000000;
		theta	<= #0 32'hBF800000;
		x_cos_correct <= #360 32'h3F0A29DB;
		y_sin_correct <= #360 32'hBF5783C6;
		
		//test 2 (time 20ns)
		x_start <= #20 32'h3F800000;
		y_start <= #20 32'h00000000;
		theta	<= #20 32'h3C23D70A;
		x_cos_correct <= #380 32'h3F7FFBF3;
		y_sin_correct <= #380 32'h3C333508;

		//test 2 (time 20ns)
		x_start <= #40 32'h3F800000;
		y_start <= #40 32'h00000000;
		theta	<= #40 32'h3FC00000;
		x_cos_correct <= #400 32'h3D963973;
		y_sin_correct <= #400 32'h3F7F4F53;
		
 
		x_start <= #60 32'h3F800000;
		y_start <= #60 32'h00000000;
		theta	<= #60 32'h3FB74F0E;
		x_cos_correct <= #420 32'h3E09A0C3;
		y_sin_correct <= #420 32'h3F7DAD41;
		
		x_start <= #80 32'h3F800000;
		y_start <= #80 32'h00000000;
		theta	<= #80 32'h3F8193B4;
		x_cos_correct <= #440 32'h3F070507;
		y_sin_correct <= #440 32'h3F597F87;	

		x_start <= #100 32'h3F800000;
		y_start <= #100 32'h00000000;
		theta	<= #100 32'hBEAFD945;
		x_cos_correct <= #460 32'h3F70EE69;
		y_sin_correct <= #460 32'hBEAD10A6;			

		x_start <= #120 32'h3F800000;
		y_start <= #120 32'h00000000;
		theta	<= #120 32'h3F9DE1D5;
		x_cos_correct <= #480 32'h3EA94B96;
		y_sin_correct <= #480 32'h3F719997;
		
		x_start <= #140 32'h3F800000;
		y_start <= #140 32'h00000000;
		theta	<= #140 32'h3A03126F;
		x_cos_correct <= #500 32'h3F7FFF8D;
		y_sin_correct <= #500 32'h3B4CD8A0;
		
		x_start <= #160 32'h3F800000;
		y_start <= #160 32'h00000000;
		theta	<= #160 32'h3F8E353F;
		x_cos_correct <= #520 32'h3EE4248C;
		y_sin_correct <= #520 32'h3F652E15;		

	end

initial
	begin
	$monitor($stime," x_start=%h, y_start=%h, theta=%h, x_cos=%h, y_sin=%h, x_cos_correct=%h, y_sin_correct=%h, x diff=%d, y diff=%d",
	x_start,
	y_start,
	theta,
	x_cos,
	y_sin,
	x_cos_correct,
	y_sin_correct,
	$signed(x_cos_correct - x_cos),
	$signed(y_sin_correct - y_sin)
	);
	end

endmodule