module ahfp_lzd64(in, out, valid);
	input 	wire [63:0] in;
	output	wire [5:0] 	out;
	output	wire valid;
	wire [4:0] res1, res2;
	wire v1, v2;
	lzd32 lo(in[31:0], res1, v1);
	lzd32 hi(in[63:32], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {1'b0, res1};
endmodule