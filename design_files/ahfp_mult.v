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

wire	[23:0] 	a_m, b_m;
wire    [22:0]  z_m;
wire	[7:0]  	a_e, b_e, z_e;
wire   			a_s, b_s, z_s;

// parameters
parameter bias = 7'd127;

//get fp fields
//initialise mantissa
assign a_m = {1'b1, dataa[22:0]};
assign b_m = {1'b1, datab[22:0]};
	
//initialise exponent
assign a_e = dataa[30:23];
assign b_e = datab[30:23];
	
//initialise sign
assign a_s = dataa[31];
assign b_s = datab[31];	

// ##### initial setup #####

//assign output sign
assign z_s = a_s ^ b_s;

//assign exponent
wire [7:0] exp_tmp_init;
assign exp_tmp_init = a_e + b_e;

//assign z_e = exp_tmp_init;

//get mantissa
wire [47:0] man_tmp_init;
assign man_tmp_init = a_m * b_m;

// ###### normalise ######
// exponent
wire [7:0] z_e_tmp;
assign z_e_tmp = man_tmp_init[47] ? (exp_tmp_init-8'd126) :
									(exp_tmp_init-8'd127) ;

// mantissa (could remove rounding)
wire [23:0] z_m_tmp;
wire overflow;
assign overflow = 1'b0;			
assign {overflow,z_m_tmp} = man_tmp_init[47] ? (man_tmp_init[46:24] + man_tmp_init[23]) :
									(man_tmp_init[45:23] + man_tmp_init[22]) ;
							
// final assigns				
assign z_m = overflow ? (z_m_tmp[23:1]) : (z_m_tmp[22:0]);
assign z_e = overflow ? (z_e_tmp+ 1'b1) : (z_e_tmp);

//if overflow (large exponent), set mantissa to zero

		
assign result = {z_s, z_e, z_m};
				
// TODO:
// - [x] round result
// - [ ] over/under flow conditions
// - [ ] normaised/ de-normalised values

endmodule