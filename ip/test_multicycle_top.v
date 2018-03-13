`include "./test_mutlicycle.v"
`timescale 1 ps / 1 ps
module test_mutlicycle_top (clock,dataa,datab,result);
	input	wire  clock;
	input	wire [31:0]  dataa;
	input	wire [31:0]  datab;
	output	wire [31:0]  result;

	wire done;
	wire [31:0] temp;
	assign result = temp;
	
	test_multicycle test (
				.clock (clock),
				.dataa (dataa),
				.datab (datab),
				.result (temp)
				);

endmodule