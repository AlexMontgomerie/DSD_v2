// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_mult;

reg clk;
wire [31:0] dataa,datab,result,result_correct;

ahfp_mult dut (	.dataa(dataa),
		.datab(datab),
		.result(result));

// clock generator
always
	#10 clk = ~clk;

// test cases
initial
	begin
		//test 1 (time 0ns)
		#0 dataa 		= 32'h00000000;
		#0 datab		= 32'h00000000;
		#0 result_correct 	= 32'h00000000;
		//test 2 (time 20ns)

		//test 3 (time 40ns)

	end

initial
	begin
	$monitor($stime," dataa=%h, datab=%h, result=%h, correct result=%h",dataa,datab,result,result_correct);
	end

endmodule
