// ######## Floating Point Subtractor #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// ############################################

module ahfp_sub(
	dataa,
	datab,
	result);
	
//input 
input	[31:0] dataa;
input	[31:0] datab;

//output
output	[31:0] result;

wire [23:0] 	a_m, b_m;
wire [22:0]  	z_m;
wire signed 	[7:0]  	a_e, b_e;
wire [7:0] z_e;
wire   			a_s, b_s, z_s;

//initialise mantissa
assign a_m = {1'b1,dataa[22:0]};
assign b_m = {1'b1,datab[22:0]};
	
//initialise exponent
assign a_e = dataa[30:23];
assign b_e = datab[30:23];
	
//initialise sign
assign a_s = dataa[31];
assign b_s = datab[31];	

// temporary exponent
wire [8:0] e_tmp;
assign e_tmp = 	(a_e == b_e) ? a_e :
				(a_e > b_e)  ? a_e : b_e;


// add the mantissa together
wire overflow;
wire [8:0] e_diff1, e_diff2;
assign e_diff1 = a_e[7:0]-b_e[7:0];
assign e_diff2 = b_e[7:0]-a_e[7:0];

wire [23:0] m_tmp;
assign {m_tmp} = 	(a_e == b_e) ?	((a_m>b_m) ? a_m-b_m : b_m-a_m) :
					(a_e  > b_e) ? 	(a_m - (b_m>>((a_e-b_e)&8'hFF))) :
									(b_m - (a_m>>((b_e-b_e)&8'hFF))) ;

//assign sign based on mantissa overflow
assign z_s = (a_e != b_e) ? ((a_e > b_e) ? 1'b0 : 1'b1 ) : 
							((m_tmp[23]) ? 1'b1 : 1'b0 ) ;

/*							
assign z_e = !m_tmp[24] ? e_tmp + 1'b1 : e_tmp;
assign z_m = !m_tmp[24] ? m_tmp[22:0] : m_tmp[23:1];
*/
assign z_e = 	(m_tmp[23] == 1'b1) ? e_tmp - 8'd0  :
				(m_tmp[22] == 1'b1) ? e_tmp - 8'd1  :
				(m_tmp[21] == 1'b1) ? e_tmp - 8'd2  :
				(m_tmp[20] == 1'b1) ? e_tmp - 8'd3  :
				(m_tmp[19] == 1'b1) ? e_tmp - 8'd4  :
				(m_tmp[18] == 1'b1) ? e_tmp - 8'd5  :
				(m_tmp[17] == 1'b1) ? e_tmp - 8'd6  :
				(m_tmp[16] == 1'b1) ? e_tmp - 8'd7  :
				(m_tmp[15] == 1'b1) ? e_tmp - 8'd8  :
				(m_tmp[14] == 1'b1) ? e_tmp - 8'd9  :
				(m_tmp[13] == 1'b1) ? e_tmp - 8'd10 :
				(m_tmp[12] == 1'b1) ? e_tmp - 8'd11 :
				(m_tmp[11] == 1'b1) ? e_tmp - 8'd12 :
				(m_tmp[10] == 1'b1) ? e_tmp - 8'd13 :
				(m_tmp[9]  == 1'b1) ? e_tmp - 8'd14 :
				(m_tmp[8]  == 1'b1) ? e_tmp - 8'd15 :
				(m_tmp[7]  == 1'b1) ? e_tmp - 8'd16 :
				(m_tmp[6]  == 1'b1) ? e_tmp - 8'd17 :
				(m_tmp[5]  == 1'b1) ? e_tmp - 8'd18 :
				(m_tmp[4]  == 1'b1) ? e_tmp - 8'd19 :
				(m_tmp[3]  == 1'b1) ? e_tmp - 8'd20 :
				(m_tmp[2]  == 1'b1) ? e_tmp - 8'd21 :
				(m_tmp[1]  == 1'b1) ? e_tmp - 8'd22 :
				8'd0;

assign z_m = 	(m_tmp[23] == 1'b1) ?  m_tmp[22:0]        :
				(m_tmp[22] == 1'b1) ? {m_tmp[21:0],1'b0}  :				
				(m_tmp[21] == 1'b1) ? {m_tmp[20:0],2'b0}  :
				(m_tmp[20] == 1'b1) ? {m_tmp[19:0],3'd0}  :
				(m_tmp[19] == 1'b1) ? {m_tmp[18:0],4'd0}  :
				(m_tmp[18] == 1'b1) ? {m_tmp[17:0],5'd0}  :
				(m_tmp[17] == 1'b1) ? {m_tmp[16:0],6'd0}  :
				(m_tmp[16] == 1'b1) ? {m_tmp[15:0],7'd0}  :
				(m_tmp[15] == 1'b1) ? {m_tmp[14:0],8'd0}  :
				(m_tmp[14] == 1'b1) ? {m_tmp[13:0],9'd0}  :
				(m_tmp[13] == 1'b1) ? {m_tmp[12:0],10'd0} :
				(m_tmp[12] == 1'b1) ? {m_tmp[11:0],11'd0} :
				(m_tmp[11] == 1'b1) ? {m_tmp[10:0],12'd0} :
				(m_tmp[10] == 1'b1) ? {m_tmp[9:0], 13'd0} :
				(m_tmp[9]  == 1'b1) ? {m_tmp[8:0], 14'd0} :
				(m_tmp[8]  == 1'b1) ? {m_tmp[7:0], 15'd0} :
				(m_tmp[7]  == 1'b1) ? {m_tmp[6:0], 16'd0} :
				(m_tmp[6]  == 1'b1) ? {m_tmp[5:0], 17'd0} :
				(m_tmp[5]  == 1'b1) ? {m_tmp[4:0], 18'd0} :
				(m_tmp[4]  == 1'b1) ? {m_tmp[3:0], 19'd0} :
				(m_tmp[3]  == 1'b1) ? {m_tmp[2:0], 20'd0} :
				(m_tmp[2]  == 1'b1) ? {m_tmp[1:0], 21'd0} :
				(m_tmp[1]  == 1'b1) ? {m_tmp[0],   22'd0} :
				23'd0;
				
//assign z_e = e_tmp;
//assign z_m = m_tmp[22:0];

//assign output
assign result = {z_s,z_e[7:0],z_m[22:0]};

endmodule	
