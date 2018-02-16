// #########   Floating Point Adder   #########
// Authors: Alex Montgomerie and Henry Eshbaugh
// 
// Design Notes:
// - Combinational
// - refere to altera's ug_embedded_ip for info
// ############################################

module ahfp_add_combi(
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

//assign output
assign result = z_s << 31 | z_e << 23 | z_m;

endmodule	


