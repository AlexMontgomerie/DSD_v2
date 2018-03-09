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

wire	[47:0] 	a_m, b_m;
wire	[47:0] 	a_m_tmp, b_m_tmp;
wire 	[22:0]  z_m;
wire 	[7:0]  	a_e, b_e, z_e;
wire 	[7:0]  	a_e_tmp, b_e_tmp;
wire 			z_s;

reg [7:0] e_tmp;

//get temporary addition values
wire	[23:0] 	man_tmp;
wire 	[7:0]	exp_tmp;

wire underflow, overflow;

always @(posedge clk) begin

	//Stage 1
	a_e_tmp <= dataa[30:23];
	b_e_tmp <= datab[30:23];


	a_m_tmp <= (dataa[30:23]==8'd0) ? {25'h000000, dataa[22:0]} : {25'h000001, dataa[22:0]};
	b_m_tmp <= (datab[30:23]==8'd0) ? {25'h000000, dataa[22:0]} : {25'h000001, datab[22:0]};

	a_s_tmp <= dataa[31];
	b_s_tmp <= datab[31];
	
	//Stage 2
//performs subtraction by choosing largest minus smallest
	{a_m,b_m,a_e,b_e,a_s,b_s} < (a_e_tmp == b_e_tmp) ? 	((a_m_tmp>=b_m_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp,a_s_tmp,b_s_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp,b_s_tmp,a_s_tmp}) :
														((a_e_tmp >b_e_tmp) ? {a_m_tmp,b_m_tmp,a_e_tmp,b_e_tmp,a_s_tmp,b_s_tmp} : {b_m_tmp,a_m_tmp,b_e_tmp,a_e_tmp,b_s_tmp,a_s_tmp}) ;


// temporary exponent

	//Stage 3
	e_tmp <= a_e;

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
wire [7:0] 	z_e_tmp;
wire [22:0] z_m_tmp;
wire 		z_m_overflow;
wire [5:0] 	shift_index;
wire 		m_valid;
wire 		round;
//get the lzd results here


ahfp_lzd48 lzd48 (	m_tmp,
					shift_index,
					m_valid
					);
	
assign z_e_tmp = m_valid ? 	e_tmp - e_diff + {2'b00,shift_index} - 8'd23 :
							8'd0;
assign z_m_tmp = (m_valid==0 || shift_index == 6'd0) ? 	24'd0 :
								(shift_index > 6'd23) 	? 	(m_tmp>>(shift_index - 6'd23))&24'h7FFFFF: //+m_tmp[shift_index-6'd24]
															(m_tmp<<(6'd23 - shift_index))&24'h7FFFFF; 

													
assign z_m_overflow = 1'b0;
	
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

