module test_mutlicycle (
	clk,
	dataa,
	datab,
	result,
	start,
	reset,
	clk_en,
	done,
	read_addr,
	size,
	read_en,
	sum_result,
	sum_done,
	clk_en_out
	);

input [31:0] dataa,datab,sum_result;
input clk,start,sum_done,clk_en,reset;

output [31:0] result,read_addr,size;
output done, read_en, clk_en_out;

assign read_addr = (reset) ? 32'd0 : dataa;
assign size = (reset) ? 32'd0 : datab;
assign read_en = (reset) ? 1'b0 : start;

assign result = sum_result;
assign done = sum_done;

assign clk_en_out = clk_en;

endmodule