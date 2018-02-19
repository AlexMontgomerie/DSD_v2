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

wire	[22:0] 	a_m, b_m, z_m;
wire	[7:0]  	a_e, b_e, z_e;
wire   			a_s, b_s, z_s;

//get temporary addition values
wire	[23:0] 	man_tmp;
wire	[7:0]	exp_tmp;

//initialise mantissa
assign a_m = dataa[22:0];
assign b_m = datab[22:0];
	
//initialise exponent
assign a_e = dataa[30:23];
assign b_e = datab[30:23];
	
//initialise sign
assign a_s = dataa[31];
assign b_s = datab[31];	

//positive, so assign z as zero
assign z_s = 1'b0;

// exponent a bigger than b 
assign z_e = 	(a_e == b_e) ? a_e :
				(a_e > b_e)  ? a_e : b_e;


// get the temporary mantissa
wire [23:0] m_tmp;
assign m_tmp = (a_e > b_e) ? {1'b1,datab} : {1'b1,dataa};

// add the mantissa together
assign z_m = (a_e>b_e) ? 	(a_e + (m_tmp>>(a_e-b_e))) :
							(b_e + (m_tmp>>(b_e-a_e))) ;

//assign output
assign result = {z_s,z_e,z_m};

endmodule	


