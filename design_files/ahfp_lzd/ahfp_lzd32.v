module ahfp_lzd32(in, out, valid);
	input	wire [31:0] in;
	output	wire [4:0] 	out;
	output	wire valid;
	wire [3:0] res1, res2;
	wire v1, v2;
	ahfp_lzd16 lo(in[15:0] , res1, v1);
	ahfp_lzd16 hi(in[31:16], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {1'b0, res1};
endmodule