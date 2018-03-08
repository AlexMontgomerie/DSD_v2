// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_add_sub;

reg clk;
reg [31:0] 	dataa, datab, result_correct;
wire [31:0] result;

ahfp_add_sub dut (	.clk(clk),
					.dataa(dataa),
					.datab(datab),
					.result(result)
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
		dataa 			<= #0 	32'h00000000;
		datab			<= #0 	32'h00000000;
		result_correct	<= #20 	32'h00000000;

		//test 2 (time 20ns)
		dataa 			<= #20 	32'h3F800000;
		datab			<= #20	32'h40000000;
		result_correct	<= #40	32'h40400000;

		//test 3 (time 40ns)
		dataa 			<= #40 	32'hC0000000;
		datab			<= #40	32'h40800000;
		result_correct	<= #60	32'h40000000;
		
		//test 4 (time 60ns)
		dataa			<= #60	32'h40400000;
		datab			<= #60	32'h40600000;
		result_correct	<= #80	32'h40D00000;
		
		//test 5 (time 80ns)
		dataa			<= #80	32'h43FA0000;
		datab			<= #80	32'hC1133333;
		result_correct	<= #100	32'h43F56666;
		
		//test 6 (time 100ns)
		dataa			<= #100	32'h41EC0000;
		datab			<= #100	32'h453BF800;
		result_correct	<= #120	32'h453DD000;
		
		//test 7 (time 120ns)
		dataa			<= #120	32'hC2FF999A;
		datab			<= #120	32'h42FCCCCD;
		result_correct	<= #140	32'hBFB33340;
		
		//test 8 (time 140ns)
		dataa			<= #140	32'h46A5E51F;
		datab			<= #140	32'hC35FAB85;
		result_correct	<= #160	32'h46A425C8;	

		//test 9 (time 160ns)
		dataa			<= #160	32'hC640E400;
		datab			<= #160	32'hC7F12040;
		result_correct	<= #180	32'hC8049E60;		
		
		//test 10 (time 180ns)
		dataa			<= #180	32'h3F8E363B;
		datab			<= #180	32'h3AA137FA;
		result_correct	<= #200	32'h3F8E5E89;	
	end

initial
	begin
	$monitor($stime," dataa=%h, datab=%h, result=%h, correct result=%h, diff=%d ",
	dataa,
	datab,
	result,
	result_correct,
	result_correct-result
	);
	end

endmodule