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

		//test 2 (time 20ns)
		#20 dataa 		= 32'h3F800000;
		datab			= 32'h40000000;
		result_correct	= 32'h40400000;

		//test 3 (time 40ns)
		#20 dataa 		= 32'h40000000;
		datab			= 32'h40800000;
		result_correct	= 32'h40C00000;
		
		//test 4 (time 60ns)
		#20 dataa		= 32'h40400000;
		datab			= 32'h40600000;
		result_correct	= 32'h40D00000;
		
		//test 5 (time 80ns)
		#20 dataa		= 32'h43FA0000;
		datab			= 32'h41133333;
		result_correct	= 32'h43FE999A;
		
		//test 6 (time 100ns)
		#20 dataa		= 32'h41EC0000;
		datab			= 32'h453BF800;
		result_correct	= 32'h453DD000;
		
		//test 7 (time 120ns)
		#20 dataa		= 32'h42FF999A;
		datab			= 32'h42FCCCCD;
		result_correct	= 32'h437E3334;
		
		//test 8 (time 140ns)
		#20 dataa		= 32'h46A5E51F;
		datab			= 32'h435FAB85;
		result_correct	= 32'h46A7A476;
		
		//test 9 (time 160ns)
		#20 dataa		= 32'h4640E400;
		datab			= 32'h47F12040;
		result_correct	= 32'h48049E60;
		
		//test 10 (time 180ns)
		#20 dataa		= 32'h3F8E363B;
		datab			= 32'h3AA137F4;
		result_correct	= 32'h3F8E5E89;
		
	end

initial
	begin
	$monitor($stime," dataa=%h, datab=%h, result=%h, correct result=%h, sign diff=%d, exp diff=%d, man diff=%d",dataa,datab,
	result,
	result_correct,
	result[31]-result_correct[31],
	(result[30:23]>result_correct[30:23]) ? result[30:23]-result_correct[30:23] : result_correct[30:23]-result[30:23],
	(result[22:0]>result_correct[22:0]) ? result[22:0]-result_correct[22:0] : result_correct[22:0]-result[22:0]
	);
	end

endmodule
