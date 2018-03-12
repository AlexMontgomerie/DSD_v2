// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf
`define N 10
`timescale 1ns / 1ns
module test_ahfp_pipeline_buffer;

reg clk;
reg [31:0] data,result_correct;
wire [31:0] result;

parameter STAGES = 10;

ahfp_pipeline_buffer dut (	.clk(clk),
							.in(data),
							.out(result));

initial // Clock generator
  begin
    clk = 1;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
		//test 1 (time 0ns)
		data 			<= #0 			32'h3F800000;
		result_correct	<= #(STAGES*20) 32'h3F800000;
		
	end

initial
	begin
	$monitor($stime," data=%h, result=%h, correct result=%h",
	data,
	result,
	result_correct
	);
	end

endmodule
