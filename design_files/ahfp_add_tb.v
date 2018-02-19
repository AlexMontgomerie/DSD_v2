// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_add;

reg clk;
reg [31:0] dataa,datab,result_correct;
wire [31:0] result;

ahfp_add dut (	.dataa(dataa),
		.datab(datab),
		.result(result));

initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
		//test 1 (time 0ns)
		dataa 			= 32'h00000000;
		datab			= 32'h00000000;
		result_correct	= 32'h00000000;


	end

initial
	begin
	$monitor($stime," dataa=%h, datab=%h, result=%h, correct result=%h",dataa,datab,result,result_correct);
	end

endmodule
