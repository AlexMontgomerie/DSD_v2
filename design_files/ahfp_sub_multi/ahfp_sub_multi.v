// ######## Floating Point Subtractor #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// ############################################

module ahfp_sub_multi(
	clk,
	dataa,
	datab,
	result);
	
//input 
input	[31:0] dataa;
input	[31:0] datab;
input 	clk;

//output
output	[31:0] result;
reg 	[31:0] res;

reg	[47:0] 	a_m, b_m;
reg	[47:0] 	a_m_tmp, b_m_tmp;
reg	[22:0]  z_m,z_m_final;
reg	[7:0]  	a_e, b_e, z_e,z_e_final;
reg	[7:0]  	a_e_tmp, b_e_tmp;
reg			z_s,z_s_2,z_s_3,z_s_4,z_s_final;

reg [7:0] 	z_e_tmp;
reg [22:0] z_m_tmp;
wire 		z_m_overflow;
wire [5:0] 	shift_index;
wire 		m_valid;
wire 		round;

reg [7:0] e_tmp;
reg [47:0] m_tmp;

reg underflow, overflow;

//wire to get the exponent difference
wire [7:0] e_diff_init;
reg  [7:0] e_diff;

assign e_diff_init = a_e - b_e;


ahfp_lzd48 lzd48 (	m_tmp,
					shift_index,
					m_valid
					);

always @(posedge clk) begin

	//Stage 1
	a_e_tmp <= dataa[30:23];
	b_e_tmp <= datab[30:23];


	a_m_tmp <= (dataa[30:23]==8'd0) ? {25'h000000, dataa[22:0]} : {25'h000001, dataa[22:0]};
	b_m_tmp <= (datab[30:23]==8'd0) ? {25'h000000, dataa[22:0]} : {25'h000001, datab[22:0]};

	//Stage 2
//performs subtraction by choosing largest minus smallest
	{a_m,b_m,a_e,b_e} <= (a_e_tmp == b_e_tmp) ? 	((a_m_tmp>=b_m_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp}) :
													((a_e_tmp >b_e_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp}) ;

	z_s_2 <= (a_e_tmp != b_e_tmp) ? ((a_e_tmp >= b_e_tmp) 				? 1'b0 : 1'b1 ) : 
									((a_m_tmp[22:0] >= b_m_tmp[22:0]) 	? 1'b0 : 1'b1 ) ;

	//Stage 3
	e_diff <= (e_diff_init>8'd24) ? 8'd0 : e_diff_init;	

	
	e_tmp <= a_e;

	m_tmp <= (e_diff_init>8'd24) ? 	a_m :
									((a_m<<((e_diff_init>8'd24) ? 8'd0 : e_diff_init)) - b_m) ;

	z_s_3 <= z_s_2;
	
	//Stage 4

	
	z_e_tmp = m_valid ? 	e_tmp - e_diff + {2'b00,shift_index} - 8'd23 :
							8'd0;
	
	z_m_tmp = (m_valid==0 || shift_index == 6'd0) ? 	24'd0 :
							(shift_index > 6'd23) 	? 	(m_tmp>>(shift_index - 6'd23))&24'h7FFFFF: //+m_tmp[shift_index-6'd24]
														(m_tmp<<(6'd23 - shift_index))&24'h7FFFFF; 

	z_s_4 <= z_s_3;
													
	//Stage 5
													
	z_e <= z_e_tmp;
	z_m <= z_m_tmp;					
	z_s <= z_s_4;
			
	//Stage 6
	underflow <= ($signed(z_e) < $signed(8'h80));
	overflow  <= ($signed(z_e) > $signed(8'h7F));

	z_e_final <= z_e;
	z_m_final <= z_m;
	z_s_final <= z_s;

	///////////////

	//Stage 7
	res <= underflow ? 32'd0 
	                    : overflow ? {z_s_final, 31'h7F800000}
						: {z_s_final, z_e_final, z_m_final};
	///////////////
end

assign result = res;

endmodule	

