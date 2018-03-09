// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_sub;

reg clk;
reg [31:0] dataa,datab,result_correct;
wire [31:0] result;

ahfp_sub dut (	.dataa(dataa),
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

		//test 2 (time 0ns)
		#20 dataa 		= 32'h3F800000;
		datab			= 32'h40000000;
		result_correct	= 32'hBF800000;

		//test 3 (time 0ns)
		#20 dataa 		= 32'h40000000;
		datab			= 32'h40800000;
		result_correct	= 32'hC0000000;
		
		//test 4 (time 0ns)
		#20 dataa		= 32'h40400000;
		datab			= 32'h40600000;
		result_correct	= 32'hBF000000;
		
		//test 5 (time 0ns)
		#20 dataa		= 32'h43FA0000;
		datab			= 32'h41133333;
		result_correct	= 32'h43F56666;
		
		//test 6 (time 0ns)
		#20 dataa		= 32'h41EC0000;
		datab			= 32'h453BF800;
		result_correct	= 32'hC53A2000;
		
		//test 7 (time 0ns)
		#20 dataa		= 32'h42FF999A;
		datab			= 32'h42FCCCCD;
		result_correct	= 32'h3FB33340;
		
		//test 8 (time 0ns)
		#20 dataa		= 32'h46A5E51F;
		datab			= 32'h435FAB85;
		result_correct	= 32'h46A425C8;
		
		//test 9 (time 0ns)
		#20 dataa		= 32'h4640E400;
		datab			= 32'h47F12040;
		result_correct	= 32'hC7D903C0;
		
		//test 10 (time 0ns)
		#20 dataa		= 32'h3F8E363B;
		datab			= 32'h3AA137F4;
		result_correct	= 32'h3F8E0DED;
		
	end

initial
	begin
	$monitor($stime," dataa=%h, datab=%h, result=%h, correct result=%h, man diff=%d, exp diff=%d",
	dataa,datab,
	result,
	result_correct,
	result_correct[30:23] - result[30:23],
	result_correct[22:0] - result[22:0]
	);
	end

endmodule
