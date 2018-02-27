// #######  Floating point Multiplier   #######
// Authors: Alex Montgomerie and Henry Eshbaugh and Andre 'the giant' Bharath
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// - simulation: https://www.altera.com/support/support-resources/knowledge-base/solutions/rd06182013_21.html 
// - IEEE floating point multiplication paper
// ############################################

module ahfp_mult(
	dataa,
	datab,
	result);
	
//input 
input	[31:0] dataa;
input	[31:0] datab;

//output
output	[31:0] result;

wire 	[23:0] 	a_m, b_m;
wire    [22:0]  z_m;
wire 	[7:0]  	a_e, b_e; 
wire 	[7:0] 	z_e;
wire   			a_s, b_s, z_s;

wire underflow, overflow;

// parameters
parameter bias = 8'd127;

//initialise exponent
assign a_e = dataa[30:23];
assign b_e = datab[30:23];

//get fp fields
//initialise mantissa
assign a_m = (a_e==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, dataa[22:0]};
assign b_m = (b_e==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, datab[22:0]};
	
//initialise sign
assign a_s = dataa[31];
assign b_s = datab[31];	

//set overflows to zero initially
assign overflow = 1'b0;

// ##### initial setup #####

//assign output sign
assign z_s = a_s ^ b_s;

//assign z_e = exp_tmp_init;

//get mantissa
wire [47:0] man_tmp_init;
assign man_tmp_init = a_m * b_m;

//assign exponent
wire [7:0] exp_tmp_init;
assign exp_tmp_init = (man_tmp_init==0) && ((a_e || b_e)==0) ? 8'd0 : a_e + b_e - 8'd127;

// ###### normalise ######
// exponent
wire [7:0] z_e_tmp;
assign z_e_tmp = exp_tmp_init + man_tmp_init[47] ;

// mantissa (could remove rounding)
wire [23:0] z_m_tmp;		
assign z_m_tmp = man_tmp_init[47] ? (man_tmp_init[46:24] + man_tmp_init[23]) :
									(man_tmp_init[45:23] + man_tmp_init[22]) ;
							
// final assigns				
assign z_m = z_m_tmp[23] ? z_m_tmp[23:1] : z_m_tmp[22:0];
assign z_e = z_e_tmp + z_m_tmp[23];

assign underflow = ($signed(z_e) < $signed(8'h80));
assign overflow  = ($signed(z_e) > $signed(8'h7F));

assign result = underflow ? 32'd0 :
				overflow  ? {z_s, 31'h7F800000} :
							{z_s, z_e[7:0], z_m};

							
endmodule