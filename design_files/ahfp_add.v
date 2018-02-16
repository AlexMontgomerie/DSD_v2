// #########   Floating point adder   #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - multi-cycle 
// - refere to altera's ug_embedded_ip for info
// ############################################

module ahfp_mult_combi(
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

//parameters


//get fp fields
//initialise mantissa
assign a_m = {1'b1,dataa[22:1]};
assign b_m = {1'b1,datab[22:1]};
	
//initialise exponent
assign a_e = dataa[30:23];
assign b_e = datab[30:23];
	
//initialise sign
assign a_s = dataa[31];
assign b_s = datab[31];	

//assign output sign
assign z_s = a_s ^ b_s;

//assign exponent
wire [8:0] exp_tmp;
assign exp_tmp = a_e + b_e;

//get mantissa
wire [46:0] man_tmp;
assign man_tmp = a_m * b_m;

assign z_e = man_tmp[46] ? (exp_tmp-9'd126) : (exp_tmp-9'd127);
assign z_m = man_tmp[46] ? (man_tmp[45:23]) : (man_tmp[45:22]);

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

