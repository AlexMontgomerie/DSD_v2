`include "../ahfp_lzd/ahfp_lzd32.v"

module ahfp_fixed_2_float (in,out);

input [31:0] in;
output [31:0] out;

wire [22:0] man;
wire [7:0] exp; 
wire [4:0] shift;
wire sign;
wire [31:0] fixed_tmp;
wire valid;
wire [8:0] nul;

assign fixed_tmp = in[31] ? ~in + 1 : in;

ahfp_lzd32 lzd (.in(fixed_tmp),
				.out(shift),
				.valid(valid)
				);

assign exp 	= 8'd98 + shift;
assign {man,nul} = fixed_tmp<<(6'd33 - shift);
assign sign = in[31]; 

assign out = {sign,exp[7:0],man[22:0]};

endmodule