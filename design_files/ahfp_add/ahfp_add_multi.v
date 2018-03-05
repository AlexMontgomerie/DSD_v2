// #########   Floating Point Adder   #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refer to altera's ug_embedded_ip for info
// ############################################

module ahfp_add_multi(
	clk,
	dataa,
	datab,
	result);
	
//input 
input	[31:0] dataa;
input	[31:0] datab;

//output
output	[31:0] result;

reg	[24:0] 	a_m, b_m;
reg	[24:0] 	a_m_tmp, b_m_tmp;
reg 	[22:0]  z_m;
reg 	[7:0]  	a_e, b_e, z_e;
reg 	[7:0]  	a_e_tmp, b_e_tmp;
 			z_s;

reg [7:0]  e_tmp;
reg [25:0] m_tmp;

//get temporary addition values
reg	[23:0] 	man_tmp;
reg 	[7:0]	exp_tmp;

reg underflow, overflow;

//initialise exponent
always @ (posedge clk) begin
	
	//Stage 1
	//initialise mantissa
	a_m_tmp <= (dataa[30:23]==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, dataa[22:0],1'b0};
	b_m_tmp <= (datab[30:23]==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, datab[22:0],1'b0};


	// stage 2
	{a_m,b_m,a_e,b_e} <= (a_e_tmp == b_e_tmp) ? ((a_m_tmp>=b_m_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp}
									: {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp})
						  : ((a_e_tmp >b_e_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp}
						 			: {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp});
	z_s <= 1'b0;
/////////////////////
//positive, so assign z as zero

// temporary exponent
//stage 2
	e_tmp <= a_e;

// add the mantissa together
	m_tmp <= a_m + (b_m>>(a_e-b_e));


// overflow cases
	exp_tmp <= m_tmp[25] ? e_tmp + 1'b1
		  	     : m_tmp[24] ? e_tmp + 1'b0
			      	         : 8'd0;
				
	man_tmp <= m_tmp[25] ? m_tmp[24:2] + m_tmp[1]
	                     : m_tmp[24] ? m_tmp[23:1] + m_tmp[0]
					 : 23'd0;
/////////////////////
//
//stage 3
	z_e <= man_tmp[23] ? exp_tmp + 1'b1 : exp_tmp;
	z_m <= man_tmp[23] ? man_tmp[23:1]  : man_tmp[22:0];					

//////////
// stage 4
	underflow <= ($signed(z_e) < $signed(8'h80));
	overflow  <= ($signed(z_e) > $signed(8'h7F));
//////////
//
//stage 5
	result <= underflow ? 32'd0 
	                    : overflow ? {z_s, 31'h7F800000}
				       : {z_s, z_e, z_m};
/////////////////////////////
	end

endmodule	
