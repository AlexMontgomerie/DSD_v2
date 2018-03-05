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
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h3F800000;
		x_cos_correct = 32'h3F0A5140;
		y_sin_correct = 32'h3F576AA4;
		
		//test 2 (time 20ns)
		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h3C23D70A;
		x_cos_correct = 32'h3F7FFCB9;
		y_sin_correct = 32'h3C23D657;

		//test 2 (time 20ns)
		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h40400000;
		x_cos_correct = 32'hBF7D7026;
		y_sin_correct = 32'h3E1081C3;

		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h40466666;
		x_cos_correct = 32'hBF7FC752;
		y_sin_correct = 32'h3D2A5096;
		
		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h400851EC;
		x_cos_correct = 32'hBF07CF99;
		y_sin_correct = 32'h3F590169;	

		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h40428F5C;
		x_cos_correct = 32'hBF7EAE17;
		y_sin_correct = 32'h3DCFB441;			

		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h3F9DE1D5;
		x_cos_correct = 32'h3EA97638;
		y_sin_correct = 32'h3F71923E;
		
		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h3A03126F;
		x_cos_correct = 32'h3F7FFFFE;
		y_sin_correct = 32'h3A03126F;
		
		#20 
		x_start = 32'h3F800000;
		y_start = 32'h3F800000;
		theta	= 32'h3F8E353F;
		x_cos_correct = 32'h3EE33540;
		y_sin_correct = 32'h3F8E353F;		
		
	end

initial
	begin
	$monitor($stime," x_start=%h, y_start=%h, theta=%h, x_cos=%h, y_sin=%h, x_cos_correct=%h, y_sin_correct=%h",
	x_start,
	y_start,
	theta,
	x_cos,
	y_sin,
	x_cos_correct,
	y_sin_correct
	);
	end

endmodule