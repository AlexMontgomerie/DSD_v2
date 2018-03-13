module test_mutlicycle (
	clk,
	dataa,
	datab,
	result,
	start,
	done,
	read_addr,
	size,
	read_en,
	sum_result,
	sum_done);

input [31:0] dataa,datab,sum_result;
input clk,start,sum_done;

output [31:0] result,read_addr,size;
output done, read_en;

assign read_addr = dataa;
assign size = datab;
assign read_en = start;

assign result = sum_result;
assign done = sum_done;

endmodule