module test_ahfp_float_2_fixed;

reg clk;
reg [31:0] data,result_correct;
wire [31:0] result;

ahfp_float_2_fixed dut 	(	.in(data),
							.out(result)
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
		data 			<= #0 32'h3F800000;
		result_correct	<= #0 32'h20000000;
		
		data 			<= #20 32'h3F000000;
		result_correct	<= #20 32'h10000000;

		data 			<= #40 32'h3F000000;
		result_correct	<= #40 32'h08000000;		
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