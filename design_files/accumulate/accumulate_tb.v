// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_accumulate;
`define DELAY 7

reg clk;
reg [31:0] 	data, result_correct;
wire [31:0] result;
reg valid, start, finished;

accumulate dut (.clk(clk),
				.data(data),
				.result(result),
				.valid(valid),
				.start(start),
				.finished(finished),
				.done(done)
				);

initial // Clock generator
  begin
    clk = 1;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
	start 		= 1'b1;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;

	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	
	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	
	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b1;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b1;
	data  = 32'h3F800000;
	#20
	start 		= 1'b0;
	valid 		= 1'b0;
	finished 	= 1'b0;
	data  = 32'h3F800000;
	end

initial
	begin
	$monitor($stime," data=%h, result=%h",
	data,
	result
	);
	end

endmodule