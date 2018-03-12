module ahfp_lzd4(in, out, valid);
	input  wire [3:0] in;
	output wire [1:0] out;
	output wire valid;
	assign {out, valid} = 	in[3] ? {2'b11, 1'b1} :
							in[2] ? {2'b10, 1'b1} :
							in[1] ? {2'b01, 1'b1} :
							in[0] ? {2'b00, 1'b1} :
									{2'b00, 1'b0} ; // all zero
endmodule