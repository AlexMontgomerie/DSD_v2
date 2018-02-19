// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_mult;

reg clk;
reg [31:0] dataa,datab,result_correct;
wire [31:0] result;

ahfp_mult dut (	.dataa(dataa),
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
		#20 dataa 		= 32'h00C00001;
		datab 			= 32'h00C00000;
		result_correct 	= 32'h01400001;
			
		//test 3 (time 40ns)
		#20 dataa		= 32'h00C00000;
		datab			= 32'h00C00000;
		result_correct	= 32'h01400000;	

		//test 4 (time 60ns)
		#20 dataa		= 32'h3F800000;
		datab			= 32'h40000000;
		result_correct	= 32'h40000000;	
		
		//test 5 (time 80ns)
		#20 dataa		= 32'h40000000;
		datab			= 32'h40800000;
		result_correct	= 32'h41000000;	
		
		//test 6 (time 100ns)
		#20 dataa		= 32'h40400000;
		datab			= 32'h40600000;
		result_correct	= 32'h41280000;	
		
		//test 7 (time 120ns)
		#20 dataa		= 32'h40A00000;
		datab			= 32'h41133333;
		result_correct	= 32'h42380000;	

		//test 8 (time 140ns)
		#20 dataa		= 32'h41EC0000;
		datab			= 32'h42160000;
		result_correct	= 32'h448A4800;	
		
		//test 9 (time 160ns)
		#20 dataa		= 32'h42FF999A;
		datab			= 32'h42FCCCCD;
		result_correct	= 32'h467C67AF;			

		//test 10 (time 180ns)
		#20 dataa		= 32'hC6A5E51F;
		datab			= 32'hC6AE9357;
		result_correct	= 32'h4DE2426C;	
		
		//test 11 (time 200ns)
		#20 dataa		= 32'hC640E400;
		datab			= 32'h47F12040;
		result_correct	= 32'hCEB5AEF1;	
		
	end

initial
	begin
	$monitor($stime," dataa=%h, datab=%h, result=%h, correct result=%h",dataa,datab,result,result_correct);
	end

endmodule
