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
	ahfp_lzd64 msb_finder ({16'h0000,in}, out, valid);
endmodule
