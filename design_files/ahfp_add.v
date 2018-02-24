// #########   Floating Point Adder   #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// ############################################

module ahfp_add(
	dataa,
	datab,
	result);
	
//input 
input	[31:0] dataa;
input	[31:0] datab;

//output
output	[31:0] result;

wire	[23:0] 	a_m, b_m;
wire 	[22:0]  z_m;
wire signed	[7:0]  	a_e, b_e, z_e;
wire 		a_s, b_s, z_s;

//get temporary addition values
wire	[23:0] 	man_tmp;
wire signed	[7:0]	exp_tmp;

//initialise mantissa
assign a_m = {1'b1,dataa[22:0]};
assign b_m = {1'b1,datab[22:0]};
	
//initialise exponent
assign a_e = dataa[30:23];
assign b_e = datab[30:23];
	
//initialise sign
assign a_s = dataa[31];
assign b_s = datab[31];	

//positive, so assign z as zero
assign z_s = 1'b0;

// temporary exponent
wire signed [7:0] e_tmp;
wire [24:0] m_tmp;
wire overflow;

assign {overflow,e_tmp} = 	(a_e == b_e) ? a_e :
				(a_e > b_e)  ? a_e :
				b_e;

// add the mantissa together
assign {overflow,m_tmp} = 	(a_e == b_e) ?	(a_m + b_m) :
				(a_e>b_e) 	 ? 	(a_m + (b_m>>(a_e-b_e))) :
								(b_m + (a_m>>(b_e-a_e))) ;

//assign {m_tmp,e_tmp} = 	(a_e == b_e) ?	{(a_m + b_m),a_e} 			   :
//						(a_e>b_e) 	 ? 	{(a_m + (b_m>>(a_e-b_e))),a_e} :
//									    {(b_m + (a_m>>(b_e-a_e))),b_e} ;

// overflow cases

assign {overflow,z_e} = 	m_tmp[24] ? e_tmp + 1'b1 :
				m_tmp[23] ? e_tmp :
				e_tmp + 2'd2;
				
assign z_m = 	m_tmp[24] ?	m_tmp[23:1] : 
				m_tmp[23] ?	m_tmp[22:0] :
				m_tmp[24:2];


//assign {z_e,z_m} = m_tmp[24] ? {e_tmp + 1'b1, m_tmp[23:1]} : {e_tmp+1'b0,m_tmp[22:0]};

//assign output
//assign result = {z_s,z_e,z_m};

wire signed underflow;
assign underflow = z_e < 8'h80;
		
assign result = (z_e < -8'd126)&&(z_m[22]==0)	? 32'b0 : {z_s, z_e[7:0], z_m[22:0]};

endmodule	


