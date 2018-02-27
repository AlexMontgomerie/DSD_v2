// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_floor;

reg clk;
reg [31:0] data,result_correct;
wire [31:0] result;

floor dut (	.data(data),
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
		data 			= 32'h00000000;
		result_correct	= 32'h00000000;

		#20
		data 			= 32'h3F800000;
		result_correct	= 32'h3F800000;

		#20
		data 			= 32'h4015FC65;
		result_correct	= 32'h40000000;
	
		#20
		data 			= 32'h4555FADD;
		result_correct	= 32'h4555F000;
		
		#20
		data 			= 32'h5306BBF0;
		result_correct	= 32'h5306BBF0;
		
		#20
		data 			= 32'h41EC0000;
		result_correct	= 32'h41E80000;
		
		#20
		data 			= 32'h42FF999A;
		result_correct	= 32'h42FE0000;
		
		#20
		data 			= 32'h3F0F5C29;
		result_correct	= 32'h00000000;
		
		#20
		data 			= 32'h3F25436C;
		result_correct	= 32'h00000000;
		
		#20
		data 			= 32'h31E1EF97;
		result_correct	= 32'h00000000;
		
	end

initial
	begin
	$monitor($stime," data=%h, result=%h, correct result=%h ",
	data,
	result,
	result_correct
	);
	end

endmodule
