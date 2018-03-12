module test_ahfp_fixed_2_float;

reg clk;
reg [31:0] data,result_correct;
wire [31:0] result;

ahfp_fixed_2_float dut 	(	.in(data),
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
		result_correct 	<= #0 32'h3F800000;
		data			<= #0 32'h20000000;
		
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