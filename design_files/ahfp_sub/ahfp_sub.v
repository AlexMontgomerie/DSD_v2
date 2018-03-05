// ######## Floating Point Subtractor #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// ############################################

module lzd4(in, out, valid)
	input  wire [3:0] in;
	output wire [1:0] out;
	output wire valid;
	assign {out, valid} = in[3] ? {2'b11, 1'b1} :
		              in[2] ? {2'b10, 1'b1} :
		              in[1] ? {2'b01, 1'b1} :
		              in[0] ? {2'b00, 1'b1} :
		                      {2'b00, 1'b0} ; // all zero
endmodule

module lzd8(in, out, valid)
	wire [7:0] in;
	wire [2:0] out;
	wire valid;
	wire [1:0] res1, res2;
	wire v1, v2;
	lzd4 lo(in[3:0], res1, v1);
	lzd4 hi(in[7:4], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {0'b1, res1};
endmodule

module lzd16(in, out, valid)
	wire [15:0] in;
	wire [3:0] out;
	wire valid;
	wire [2:0] res1, res2;
	wire v1, v2;
	lzd8 lo(in[7:0], res1, v1);
	lzd8 hi(in[15:8], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {0'b1, res1};
endmodule

module lzd32(in, out, valid)
	wire [31:0] in;
	wire [4:0] out;
	wire valid;
	wire [3:0] res1, res2;
	wire v1, v2;
	lzd16 lo(in[15:0], res1, v1);
	lzd16 hi(in[31:16], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {0'b1, res1};
endmodule

module lzd64(in, out, valid)
	wire [63:0] in;
	wire [5:0] out;
	wire valid;
	wire [4:0] res1, res2;
	wire v1, v2;
	lzd32 lo(in[31:0], res1, v1);
	lzd32 hi(in[63:32], res2, v2);
	assign valid = v1 | v2;
	assign out = v2 ? {1'b1, res2} : {0'b1, res1};
endmodule

module lzd48(in, out, valid)
	wire [47:0] in;
	wire [5:0] out;
	wire valid;
	lzd64 foo({in, 16'h0000}, out, valid);
endmodule

module ahfp_sub(
	dataa,
	datab,
	result);
	
//input 
input	[31:0] dataa;
input	[31:0] datab;

//output
output	[31:0] result;

wire	[47:0] 	a_m, b_m;
wire	[47:0] 	a_m_tmp, b_m_tmp;
wire 	[22:0]  z_m;
wire 	[7:0]  	a_e, b_e, z_e;
wire 	[7:0]  	a_e_tmp, b_e_tmp;
wire 			z_s;

//get temporary addition values
wire	[23:0] 	man_tmp;
wire 	[7:0]	exp_tmp;

wire underflow, overflow;

//initialise exponent
assign a_e_tmp = dataa[30:23];
assign b_e_tmp = datab[30:23];

//initialise mantissa
assign a_m_tmp = (a_e==8'd0) ? {25'h000000, dataa[22:0]} : {25'h000001, dataa[22:0]};
assign b_m_tmp = (b_e==8'd0) ? {25'h000000, dataa[22:0]} : {25'h000001, datab[22:0]};

assign {a_m,b_m,a_e,b_e} = (a_e_tmp == b_e_tmp) ? 	((a_m_tmp>=b_m_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp}) :
													((a_e_tmp >b_e_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp}) ;


// temporary exponent
wire signed [7:0] e_tmp;
assign e_tmp = a_e;

wire [7:0] e_diff_init, e_diff;
assign e_diff_init = a_e - b_e;
assign e_diff = (e_diff_init>8'd24) ? 8'd0 : e_diff_init;

// add the mantissa together
wire [47:0] m_tmp;
assign  m_tmp = (e_diff_init>8'd24) ? 	a_m :
										((a_m<<e_diff) - b_m) ;
							//condition for if exponent difference really large
											
//assign sign based on mantissa overflow
assign z_s = (a_e_tmp != b_e_tmp) ? ((a_e_tmp > b_e_tmp) 				? 1'b0 : 1'b1 ) : 
									((a_m_tmp[22:0] > b_m_tmp[22:0]) 	? 1'b0 : 1'b1 ) ;

/*							
assign z_e = !m_tmp[24] ? e_tmp + 1'b1 : e_tmp;
assign z_m = !m_tmp[24] ? m_tmp[22:0] : m_tmp[23:1];
*/
wire [7:0] z_e_tmp;
wire [22:0] z_m_tmp;
wire z_m_overflow;

assign {z_m_overflow,z_m_tmp,z_e_tmp} = (m_tmp[47] == 1'b1) ? {m_tmp[46:24] + m_tmp[23], e_tmp - e_diff + 8'd24} :
				(m_tmp[46] == 1'b1) ? {m_tmp[45:23] + m_tmp[22], e_tmp - e_diff + 8'd23} :
				(m_tmp[45] == 1'b1) ? {m_tmp[44:22] + m_tmp[21], e_tmp - e_diff + 8'd22} :
				(m_tmp[44] == 1'b1) ? {m_tmp[43:21] + m_tmp[20], e_tmp - e_diff + 8'd21} :
				(m_tmp[43] == 1'b1) ? {m_tmp[42:20] + m_tmp[19], e_tmp - e_diff + 8'd20} :
				(m_tmp[42] == 1'b1) ? {m_tmp[41:19] + m_tmp[18], e_tmp - e_diff + 8'd19} :
				(m_tmp[41] == 1'b1) ? {m_tmp[40:18] + m_tmp[17], e_tmp - e_diff + 8'd18} :
				(m_tmp[40] == 1'b1) ? {m_tmp[39:17] + m_tmp[16], e_tmp - e_diff + 8'd17} :
				(m_tmp[39] == 1'b1) ? {m_tmp[38:16] + m_tmp[15], e_tmp - e_diff + 8'd16} :
				(m_tmp[38] == 1'b1) ? {m_tmp[37:15] + m_tmp[14], e_tmp - e_diff + 8'd15} :
				(m_tmp[37] == 1'b1) ? {m_tmp[36:14] + m_tmp[13], e_tmp - e_diff + 8'd14} :
				(m_tmp[36] == 1'b1) ? {m_tmp[35:13] + m_tmp[12], e_tmp - e_diff + 8'd13} :
				(m_tmp[35] == 1'b1) ? {m_tmp[34:12] + m_tmp[11], e_tmp - e_diff + 8'd12} :
				(m_tmp[34] == 1'b1) ? {m_tmp[33:11] + m_tmp[10], e_tmp - e_diff + 8'd11} :
				(m_tmp[33] == 1'b1) ? {m_tmp[32:10] + m_tmp[9] , e_tmp - e_diff + 8'd10} :
				(m_tmp[32] == 1'b1) ? {m_tmp[31:9]  + m_tmp[8] , e_tmp - e_diff + 8'd9 } :
				(m_tmp[31] == 1'b1) ? {m_tmp[30:8]  + m_tmp[7] , e_tmp - e_diff + 8'd8 } :
				(m_tmp[30] == 1'b1) ? {m_tmp[29:7]  + m_tmp[6] , e_tmp - e_diff + 8'd7 } :
				(m_tmp[29] == 1'b1) ? {m_tmp[28:6]  + m_tmp[5] , e_tmp - e_diff + 8'd6 } :
				(m_tmp[28] == 1'b1) ? {m_tmp[27:5]  + m_tmp[4] , e_tmp - e_diff + 8'd5 } :
				(m_tmp[27] == 1'b1) ? {m_tmp[26:4]  + m_tmp[3] , e_tmp - e_diff + 8'd4 } :
				(m_tmp[26] == 1'b1) ? {m_tmp[25:3]  + m_tmp[2] , e_tmp - e_diff + 8'd3 } :
				(m_tmp[25] == 1'b1) ? {m_tmp[24:2]  + m_tmp[1] , e_tmp - e_diff + 8'd2 } :
				(m_tmp[24] == 1'b1) ? {m_tmp[23:1]  + m_tmp[0] , e_tmp - e_diff + 8'd1 } :
				(m_tmp[23] == 1'b1) ? {m_tmp[22:0]  + 1'd0	   , e_tmp - e_diff 	   } :
				(m_tmp[22] == 1'b1) ? {{1'd0,m_tmp[21:0],1'd0} , e_tmp - e_diff - 8'd1 } :
				(m_tmp[21] == 1'b1) ? {{1'd0,m_tmp[20:0],2'd0} , e_tmp - e_diff - 8'd2 } :
				(m_tmp[20] == 1'b1) ? {{1'd0,m_tmp[19:0],3'd0} , e_tmp - e_diff - 8'd3 } :
				(m_tmp[19] == 1'b1) ? {{1'd0,m_tmp[18:0],4'd0} , e_tmp - e_diff - 8'd4 } :
				(m_tmp[18] == 1'b1) ? {{1'd0,m_tmp[17:0],5'd0} , e_tmp - e_diff - 8'd5 } :
				(m_tmp[17] == 1'b1) ? {{1'd0,m_tmp[16:0],6'd0} , e_tmp - e_diff - 8'd6 } :
				(m_tmp[16] == 1'b1) ? {{1'd0,m_tmp[15:0],7'd0} , e_tmp - e_diff - 8'd7 } :
				(m_tmp[15] == 1'b1) ? {{1'd0,m_tmp[14:0],8'd0} , e_tmp - e_diff - 8'd8 } :
				(m_tmp[14] == 1'b1) ? {{1'd0,m_tmp[13:0],9'd0} , e_tmp - e_diff - 8'd9 } :
				(m_tmp[13] == 1'b1) ? {{1'd0,m_tmp[12:0],10'd0} , e_tmp - e_diff - 8'd10 } :
				(m_tmp[12] == 1'b1) ? {{1'd0,m_tmp[11:0],11'd0} , e_tmp - e_diff - 8'd11 } :
				(m_tmp[11] == 1'b1) ? {{1'd0,m_tmp[10:0],12'd0} , e_tmp - e_diff - 8'd12 } :
				(m_tmp[10] == 1'b1) ? {{1'd0,m_tmp[9:0],13'd0} , e_tmp - e_diff - 8'd13 } :
				(m_tmp[9] == 1'b1)  ? {{1'd0,m_tmp[8:0],14'd0} , e_tmp - e_diff - 8'd14 } :
				(m_tmp[8] == 1'b1)  ? {{1'd0,m_tmp[7:0],15'd0} , e_tmp - e_diff - 8'd15 } :
				(m_tmp[7] == 1'b1)  ? {{1'd0,m_tmp[6:0],16'd0} , e_tmp - e_diff - 8'd16 } :
				(m_tmp[6] == 1'b1)  ? {{1'd0,m_tmp[5:0],17'd0} , e_tmp - e_diff - 8'd17 } :
				(m_tmp[5] == 1'b1)  ? {{1'd0,m_tmp[4:0],18'd0} , e_tmp - e_diff - 8'd18 } :
				(m_tmp[4] == 1'b1)  ? {{1'd0,m_tmp[3:0],19'd0} , e_tmp - e_diff - 8'd19 } :
				(m_tmp[3] == 1'b1)  ? {{1'd0,m_tmp[2:0],20'd0} , e_tmp - e_diff - 8'd20 } :
				(m_tmp[2] == 1'b1)  ? {{1'd0,m_tmp[1:0],21'd0} , e_tmp - e_diff - 8'd21 } :
				(m_tmp[1] == 1'b1)  ? {{1'd0,m_tmp[0:0],22'd0} , e_tmp - e_diff - 8'd22 } :
				(m_tmp[0] == 1'b1)  ? {24'd0 		       , e_tmp - e_diff - 8'd23 } :
									  {24'd0,8'd0} ; 
				
/*
				(m_tmp[45] == 1'b1) ? e_tmp - e_diff + 8'd22 :
				(m_tmp[44] == 1'b1) ? e_tmp - e_diff + 8'd21 :
				(m_tmp[43] == 1'b1) ? e_tmp - e_diff + 8'd20 :
				(m_tmp[42] == 1'b1) ? e_tmp - e_diff + 8'd19 :
				(m_tmp[41] == 1'b1) ? e_tmp - e_diff + 8'd18 :
				(m_tmp[40] == 1'b1) ? e_tmp - e_diff + 8'd17 :
				(m_tmp[39] == 1'b1) ? e_tmp - e_diff + 8'd16 :
				(m_tmp[38] == 1'b1) ? e_tmp - e_diff + 8'd15 :
				(m_tmp[37] == 1'b1) ? e_tmp - e_diff + 8'd14 :
				(m_tmp[36] == 1'b1) ? e_tmp - e_diff + 8'd13 :
				(m_tmp[35] == 1'b1) ? e_tmp - e_diff + 8'd12 :
				(m_tmp[34] == 1'b1) ? e_tmp - e_diff + 8'd11 :
				(m_tmp[33] == 1'b1) ? e_tmp - e_diff + 8'd10 :
				(m_tmp[32] == 1'b1) ? e_tmp - e_diff + 8'd9  :
				(m_tmp[31] == 1'b1) ? e_tmp - e_diff + 8'd8  :
				(m_tmp[30] == 1'b1) ? e_tmp - e_diff + 8'd7  :
				(m_tmp[29] == 1'b1) ? e_tmp - e_diff + 8'd6  :
				(m_tmp[28] == 1'b1) ? e_tmp - e_diff + 8'd5  :
				(m_tmp[27] == 1'b1) ? e_tmp - e_diff + 8'd4  :
				(m_tmp[26] == 1'b1) ? e_tmp - e_diff + 8'd3  :
				(m_tmp[25] == 1'b1) ? e_tmp - e_diff + 8'd2  :
				(m_tmp[24] == 1'b1) ? e_tmp - e_diff + 8'd1  :
				(m_tmp[23] == 1'b1) ? e_tmp - e_diff         :
				(m_tmp[22] == 1'b1) ? e_tmp - e_diff - 8'd1  :
				(m_tmp[21] == 1'b1) ? e_tmp - e_diff - 8'd2  :
				(m_tmp[20] == 1'b1) ? e_tmp - e_diff - 8'd3  :
				(m_tmp[19] == 1'b1) ? e_tmp - e_diff - 8'd4  :
				(m_tmp[18] == 1'b1) ? e_tmp - e_diff - 8'd5  :
				(m_tmp[17] == 1'b1) ? e_tmp - e_diff - 8'd6  :
				(m_tmp[16] == 1'b1) ? e_tmp - e_diff - 8'd7  :
				(m_tmp[15] == 1'b1) ? e_tmp - e_diff - 8'd8  :
				(m_tmp[14] == 1'b1) ? e_tmp - e_diff - 8'd9  :
				(m_tmp[13] == 1'b1) ? e_tmp - e_diff - 8'd10 :
				(m_tmp[12] == 1'b1) ? e_tmp - e_diff - 8'd11 :
				(m_tmp[11] == 1'b1) ? e_tmp - e_diff - 8'd12 :
				(m_tmp[10] == 1'b1) ? e_tmp - e_diff - 8'd13 :
				(m_tmp[9] == 1'b1)  ? e_tmp - e_diff - 8'd14 :
				(m_tmp[8] == 1'b1)  ? e_tmp - e_diff - 8'd15 :
				(m_tmp[7] == 1'b1)  ? e_tmp - e_diff - 8'd16 :
				(m_tmp[6] == 1'b1)  ? e_tmp - e_diff - 8'd17 :
				(m_tmp[5] == 1'b1)  ? e_tmp - e_diff - 8'd18 :
				(m_tmp[4] == 1'b1)  ? e_tmp - e_diff - 8'd19 :
				(m_tmp[3] == 1'b1)  ? e_tmp - e_diff - 8'd20 :
				(m_tmp[2] == 1'b1)  ? e_tmp - e_diff - 8'd21 :
				(m_tmp[1] == 1'b1)  ? e_tmp - e_diff - 8'd22 :
				(m_tmp[0] == 1'b1)  ? e_tmp - e_diff - 8'd23 :
				8'd0;

assign {z_m_overflow,z_m_tmp} = (m_tmp[47] == 1'b1) ? m_tmp[46:24] + m_tmp[23] :
				(m_tmp[46] == 1'b1) ? m_tmp[45:23] + m_tmp[22] :				
				(m_tmp[45] == 1'b1) ? m_tmp[44:22] + m_tmp[21] :
				(m_tmp[44] == 1'b1) ? m_tmp[43:21] + m_tmp[20] :
				(m_tmp[43] == 1'b1) ? m_tmp[42:20] + m_tmp[19] :
				(m_tmp[42] == 1'b1) ? m_tmp[41:19] + m_tmp[18] :
				(m_tmp[41] == 1'b1) ? m_tmp[40:18] + m_tmp[17] :
				(m_tmp[40] == 1'b1) ? m_tmp[39:17] + m_tmp[16] : 
				(m_tmp[39] == 1'b1) ? m_tmp[38:16] + m_tmp[15] :
				(m_tmp[38] == 1'b1) ? m_tmp[37:15] + m_tmp[14] :
				(m_tmp[37] == 1'b1) ? m_tmp[36:14] + m_tmp[13] :
				(m_tmp[36] == 1'b1) ? m_tmp[35:13] + m_tmp[12] :
				(m_tmp[35] == 1'b1) ? m_tmp[34:12] + m_tmp[11] :
				(m_tmp[34] == 1'b1) ? m_tmp[33:11] + m_tmp[10] :
				(m_tmp[33] == 1'b1) ? m_tmp[32:10] + m_tmp[9]  :
				(m_tmp[32] == 1'b1) ? m_tmp[31:9]  + m_tmp[8]  :
				(m_tmp[31] == 1'b1) ? m_tmp[30:8]  + m_tmp[7]  :
				(m_tmp[30] == 1'b1) ? m_tmp[29:7]  + m_tmp[6]  :
				(m_tmp[29] == 1'b1) ? m_tmp[28:6]  + m_tmp[5]  :
				(m_tmp[28] == 1'b1) ? m_tmp[27:5]  + m_tmp[4]  :
				(m_tmp[27] == 1'b1) ? m_tmp[26:4]  + m_tmp[3]  :
				(m_tmp[26] == 1'b1) ? m_tmp[25:3]  + m_tmp[2]  :
				(m_tmp[25] == 1'b1) ? m_tmp[24:2]  + m_tmp[1]  :
				(m_tmp[24] == 1'b1) ? m_tmp[23:1]  + m_tmp[0]  :
				(m_tmp[23] == 1'b1) ? m_tmp[22:0]  + 1'b0		   :
				(m_tmp[22] == 1'b1) ? {m_tmp[21:0],1'd0} + 1'b0   :
				(m_tmp[21] == 1'b1) ? {m_tmp[20:0],2'd0} + 1'b0        :
				(m_tmp[20] == 1'b1) ? {m_tmp[19:0],3'd0}  + 1'b0       :
				(m_tmp[19] == 1'b1) ? {m_tmp[18:0],4'd0} + 1'b0        :
				(m_tmp[18] == 1'b1) ? {m_tmp[17:0],5'd0} + 1'b0        :
				(m_tmp[17] == 1'b1) ? {m_tmp[16:0],6'd0} + 1'b0        :
				(m_tmp[16] == 1'b1) ? {m_tmp[15:0],7'd0} + 1'b0        :
				(m_tmp[15] == 1'b1) ? {m_tmp[14:0],8'd0} + 1'b0        :
				(m_tmp[14] == 1'b1) ? {m_tmp[13:0],9'd0} + 1'b0        :
				(m_tmp[13] == 1'b1) ? {m_tmp[12:0],10'd0} + 1'b0       :
				(m_tmp[12] == 1'b1) ? {m_tmp[11:0],11'd0} + 1'b0       :
				(m_tmp[11] == 1'b1) ? {m_tmp[10:0],12'd0} + 1'b0       : 
				(m_tmp[10] == 1'b1) ? {m_tmp[9:0],13'd0}  + 1'b0       :
				(m_tmp[9] == 1'b1) 	? {m_tmp[8:0],14'd0}  + 1'b0       :
				(m_tmp[8] == 1'b1) 	? {m_tmp[7:0],15'd0}  + 1'b0       :
				(m_tmp[7] == 1'b1) 	? {m_tmp[6:0],16'd0}  + 1'b0       :
				(m_tmp[6] == 1'b1) 	? {m_tmp[5:0],17'd0}  + 1'b0       :
				(m_tmp[5] == 1'b1) 	? {m_tmp[4:0],18'd0}   + 1'b0      :
				(m_tmp[3] == 1'b1) 	? {m_tmp[3:0],19'd0}   + 1'b0      :
				(m_tmp[3] == 1'b1) 	? {m_tmp[2:0],20'd0}  + 1'b0       :
				(m_tmp[2] == 1'b1) 	? {m_tmp[1:0],21'd0}  + 1'b0       :
				(m_tmp[1] == 1'b1) 	? {m_tmp[0],22'd0}    + 1'b0       :
				23'd0;
*/	
	
assign z_e = z_m_overflow ? z_e_tmp + 1'b1 : z_e_tmp;
assign z_m = z_m_overflow ? {1'b1,z_m_tmp[22:1]}  : z_m_tmp;					
				
//assign z_e = e_tmp;
//assign z_m = m_tmp[22:0];
//TODO: remove later stage comparisons
//assign output
assign underflow = ($signed(z_e) < $signed(8'h80));
assign overflow  = ($signed(z_e) > $signed(8'h7F));

assign result = underflow ? 32'd0 :
				overflow  ? {z_s, 31'h7F800000} :
							{z_s, z_e, z_m};

endmodule	
