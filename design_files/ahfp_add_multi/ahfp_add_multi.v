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
reg		[31:0] res;

reg	[24:0] 	a_m, b_m;
reg	[24:0] 	a_m_tmp, b_m_tmp;
reg [22:0]  z_m_final, z_m;
reg [7:0]  	a_e, b_e, z_e, z_e_final;
reg [7:0]  	a_e_tmp, b_e_tmp;
reg			z_s_1,z_s_2,z_s_3,z_s_4,z_s_5;

reg [7:0]  e_tmp;
reg [25:0] m_tmp;

//get temporary addition values
reg	[23:0] 	man_tmp;
reg [7:0]	exp_tmp;

reg underflow, overflow;

//initialise exponent
always @ (posedge clk) begin
	
	//Stage 1
	//initialise mantissa
	a_e_tmp <= dataa[30:23];
	b_e_tmp <= datab[30:23];

	
	a_m_tmp <= (dataa[30:23]==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, dataa[22:0],1'b0};
	b_m_tmp <= (datab[30:23]==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, datab[22:0],1'b0};

	z_s_1 <= dataa[31];

	///////////////
	
	//Stage 2
	{a_m,b_m,a_e,b_e} <= (a_e_tmp == b_e_tmp) ? ((a_m_tmp>=b_m_tmp) ? 	{a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp}  	:
																		{b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp}) 	:
												((a_e_tmp >b_e_tmp) ? 	{a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp}  	:
																		{b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp})	;
	z_s_2 <= z_s_1;
	
	///////////////
	
	//Stage 3
	e_tmp <= a_e;

	m_tmp <= a_m + (b_m>>(a_e-b_e));
	
	z_s_3 <=z_s_2;

	///////////////

	//Stage 4
	exp_tmp <= m_tmp[25] ? e_tmp + 1'b1 : (m_tmp[24] ? e_tmp + 1'b0 : 8'd0);
				
	man_tmp <= m_tmp[25] ? m_tmp[24:2] + m_tmp[1] : (m_tmp[24] ? m_tmp[23:1] + m_tmp[0] : 23'd0);

	z_s_4 <= z_s_3;
	
	///////////////

	//Stage 5
	z_e <= man_tmp[23] ? exp_tmp + 1'b1 : exp_tmp;

	z_m <= man_tmp[23] ? man_tmp[23:1]  : man_tmp[22:0];					

	z_s_5 <= z_s_4;
	
	///////////////

	//Stage 6
	underflow <= ($signed(z_e) < $signed(8'h80));
	overflow  <= ($signed(z_e) > $signed(8'h7F));

	z_e_final <= z_e;
	z_m_final <= z_m;
	z_s_final <= z_s_5;

	///////////////

	//Stage 7
	res <= underflow ? 32'd0 
	                : overflow ? {z_s_final, 31'h7F800000}
					: {z_s_final, z_e_final, z_m_final};
	///////////////
	end

assign result = res;
	
endmodule	
