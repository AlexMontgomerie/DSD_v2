module ahfp_fixed_2_float (clk,in,out);

input clk;
input [31:0] in;
output [31:0] out;

wire [22:0] man;
wire [7:0] exp; 
wire [4:0] shift;
reg  [4:0] shift_reg;
wire sign;
reg [31:0] fixed_tmp;
wire valid;
wire [8:0] nul;
reg sign_reg;

ahfp_lzd32 lzd (.in(fixed_tmp),
				.out(shift),
				.valid(valid)
				);

//buffer lzd stage
always @ (posedge clk) begin
	fixed_tmp <= in[31] ? ~in + 1 : in;
	shift_reg <= shift;
	sign_reg <= in[31];
end

assign exp 	= 8'd98 + shift_reg;
assign {man,nul} = fixed_tmp<<(6'd33 - shift_reg);
assign sign = sign_reg; 

assign out = {sign,exp[7:0],man[22:0]};
endmodule