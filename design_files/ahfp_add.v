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

wire	[24:0] 	a_m, b_m;
wire	[24:0] 	a_m_tmp, b_m_tmp;
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
assign a_m_tmp = (a_e==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, dataa[22:0],1'b0};
assign b_m_tmp = (b_e==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, datab[22:0],1'b0};

assign {a_m,b_m,a_e,b_e} = (a_e_tmp == b_e_tmp) ? 	((a_m_tmp>=b_m_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp}) :
													((a_e_tmp >b_e_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp}) ;

//positive, so assign z as zero
assign z_s = 1'b0;

// temporary exponent
wire [7:0] 	e_tmp;
wire [25:0] m_tmp;

assign e_tmp = a_e;

// add the mantissa together
assign	m_tmp = a_m + (b_m>>(a_e-b_e)) ;


// overflow cases

assign exp_tmp = 	m_tmp[25] ? e_tmp + 1'b1 :
					m_tmp[24] ? e_tmp + 1'b0 :
					8'd0;
				
assign man_tmp =	m_tmp[25] ?	m_tmp[24:2] + m_tmp[1] : 
					m_tmp[24] ?	m_tmp[23:1] + m_tmp[0] :
					23'd0;

assign z_e = man_tmp[23] ? exp_tmp + 1'b1 : exp_tmp;
assign z_m = man_tmp[23] ? man_tmp[23:1]  : man_tmp[22:0];					


assign underflow = ($signed(z_e) < $signed(8'h80));
assign overflow  = ($signed(z_e) > $signed(8'h7F));

assign result = underflow ? 32'd0 :
				overflow  ? {z_s, 31'h7F800000} :
							{z_s, z_e, z_m};

endmodule	


