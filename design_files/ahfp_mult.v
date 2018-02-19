// #######  Floating point Multiplier   #######
// Authors: Alex Montgomerie and Henry Eshbaugh
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

wire	[22:0] 	a_m, b_m, z_m;
wire	[7:0]  	a_e, b_e, z_e;
wire   		a_s, b_s, z_s;

// parameters
parameter bias = 7'd127;

//get fp fields
//initialise mantissa
assign a_m = dataa[22:0];
assign b_m = datab[22:0];
	
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

assign z_e = exp_tmp_init;

//get mantissa
wire [46:0] man_tmp_init;
assign man_tmp_init = a_m * b_m;

assign z_m = man_tmp_init[46] ? (man_tmp_init[46:23]) :
								(man_tmp_init[45:22]) ;
/*
// ###### normalise ######
// exponent
wire [7:0] z_e_tmp;
assign z_e_tmp = man_tmp_init[46] ? (exp_tmp_init-9'd126) :
									(exp_tmp_init-9'd127) ;

// mantissa
wire [23:0] z_m_tmp;				
assign z_m_tmp = man_tmp_init[46] ? (man_tmp_init[46:23]+man_tmp_init[22]) :
									(man_tmp_init[45:22]+man_tmp_init[21]) ;

// final assigns				
assign z_m = z_m_tmp[23] ? (z_m_tmp[23:1]) : (z_m_tmp[22:0]);
assign z_e = z_m_tmp[23] ? (z_e_tmp+ 1'b1) : (z_e_tmp);
				
// TODO:
// - round result
// - over/under flow conditions
*/


//assign output
assign result = z_s << 31 | z_e << 23 | z_m;

endmodule	

/*
module ahfp_mult_multi(
	dataa,
	datab,
	clk,
	clk_en,
	reset,
	start,
	result,
	done);

//input 
input 	clk;
input 	clk_en;
input 	reset;
input 	start;
input	[31:0] dataa;
input	[31:0] datab;

//output
output	done;
output	[31:0] result;

//intermediate results
// - m: mantissa
// - e: exponent
// - s: sign
// a and b are inputs, z output
reg		[23:0] 	a_m, b_m, z_m;
reg		[9:0]  	a_e, b_e, z_e;
reg		   		a_s, b_s, z_s;

reg		[31:0] product;

reg state;

parameter initialise

always @(posedge clk)
begin

	case(state)
		initialise:
		begin
			//initialise mantissa
			a_m <= dataa[22:0];
			b_m <= datab[22:0];
	
			//initialise exponent
			a_e <= dataa[30:23];
			b_e <= datab[30:23];
	
			//initialise sign
			a_s <= dataa[31];
			b_s <= datab[31];	

			//change state
			state <= 
			
		end

end

endmodule
*/

