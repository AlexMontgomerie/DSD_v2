// ######## Floating Point Subtractor #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// ############################################

module ahfp_lzd48(in, out, valid);
	input 	wire [47:0] in;
	output 	wire [5:0] 	out;
	output	wire valid;
	wire [4:0] res1;
    wire [3:0] res2;
	wire v1, v2;
	
	ahfp_lzd32 lo(in[31:0] , res1, v1);
	ahfp_lzd16 hi(in[47:32], res2, v2);
	
	assign valid = v1 | v2;
	assign out = v2 ? {2'b10, res2} : {1'b0, res1};
endmodule
