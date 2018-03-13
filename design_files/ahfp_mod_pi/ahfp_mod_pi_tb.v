// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf
`timescale 1ns / 1ns
module test_ahfp_mod_pi;

`define DELAY 5

reg clk;
reg [31:0] data,result_correct;
wire [31:0] result;

ahfp_mod_pi dut (	.clk(clk),
					.data(data),
					.result(result));

initial // Clock generator
  begin
    clk = 1;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
		//test 1 (time 0ns)
		data 			<= #0 			32'h00000000;
		result_correct	<= #(`DELAY*20) 32'h00000000;

		data 			<= #(20)			32'hC0A00000;
		result_correct	<= #(`DELAY*20+20) 	32'hBFEDE04B;

		data 			<= #(40)			32'h41A00000;
		result_correct	<= #(`DELAY*20+40) 	32'h3F9341C0;

		data 			<= #(60)			32'h41300000;
		result_correct	<= #(`DELAY*20+60) 	32'h3FC9A0E0;		
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