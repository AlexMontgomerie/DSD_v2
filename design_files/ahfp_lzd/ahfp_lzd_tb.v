// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_lzd;

reg  [47:0] in;
reg clk;
reg	 [5:0] out_correct;
wire [5:0]  out;
wire        valid;


ahfp_lzd48 dut (.in (in),
				.out(out),
				.valid(valid)
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
		// TODO testbenches
		//test 2 (time 20ns)
		in 			= 48'h800000000000;
		out_correct = 7'd47;
		
		#20
		in 			= 48'hCD01004FFFFF;
		out_correct = 7'd47;

		#20
		in 			= 48'h14E5000004A4;
		out_correct = 7'd44;
		
		#20
		in 			= 48'h005200003E40;
		out_correct = 7'd38;
		
		#20
		in 			= 48'h00001F3948C8;
		out_correct = 7'd28;

		#20
		in 			= 48'h000000040000;
		out_correct = 7'd18;
		
		#20
		in 			= 48'h000000000001;
		out_correct = 7'd0;
		
		#20
		in 			= 48'h000000000000;
		out_correct = 7'd0;
	end

initial
	begin
	$monitor($stime," in=%h, out=%h, valid=%h, out correct=%h",
	in,
	out,
	valid,
	out_correct
	);
	end

endmodule
