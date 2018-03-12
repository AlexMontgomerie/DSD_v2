// ######## Floating Point Subtractor #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// ############################################

module lzd4(in, out, valid);
	input  wire [3:0] in;
	output wire [1:0] out;
	output wire valid;
	assign {out, valid} = 	in[3] ? {2'b11, 1'b1} :
							in[2] ? {2'b10, 1'b1} :
							in[1] ? {2'b01, 1'b1} :
							in[0] ? {2'b00, 1'b1} :
									{2'b00, 1'b0} ; // all zero
endmodule

module lzd8(in, out, valid);
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

module lzd16(in, out, valid);
	input	wire [15:0] in;
	output	wire [3:0] 	out;
	output	wire valid;
	wire [2:0] res1, res2;
	wire v1, v2;
	lzd8 lo(in[7:0] , res1, v1);
	lzd8 hi(in[15:8], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {1'b0, res1};
endmodule

module lzd32(in, out, valid);
	input	wire [31:0] in;
	output	wire [4:0] 	out;
	output	wire valid;
	wire [3:0] res1, res2;
	wire v1, v2;
	lzd16 lo(in[15:0] , res1, v1);
	lzd16 hi(in[31:16], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {1'b0, res1};
endmodule

module lzd64(in, out, valid);
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

module lzd48(in, out, valid);
	input 	wire [47:0] in;
	output 	wire [5:0] 	out;
	output	wire valid;
	lzd64 msb_finder ({in, 16'h0000}, out, valid);
endmodule
