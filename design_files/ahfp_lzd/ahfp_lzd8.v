module ahfp_lzd8(in, out, valid);
	input 	wire [7:0] in;
	output	wire [2:0] out;
	output 	wire valid;
	wire [1:0] res1, res2;
	wire v1, v2;
	lzd4 lo(in[3:0], res1, v1);
	lzd4 hi(in[7:4], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {1'b0, res1};
endmodule