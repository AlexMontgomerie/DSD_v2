module ahfp_lzd16(in, out, valid);
	input	wire [15:0] in;
	output	wire [3:0] 	out;
	output	wire valid;
	wire [2:0] res1, res2;
	wire v1, v2;
	ahfp_lzd8 lo(in[7:0] , res1, v1);
	ahfp_lzd8 hi(in[15:8], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {1'b0, res1};
endmodule