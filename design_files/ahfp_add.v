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
wire   			a_s, b_s, z_s;

//get temporary addition values
wire	[23:0] 	man_tmp;
wire	[7:0]	exp_tmp;

//both positive
if a_s and b_s:
	begin
	
	//temporary addition values
	assign man_tmp = (a_e > b_e) ? (a_m+b_m >> (a_e-b_e)) : (b_m+a_m >> (b_e-a_e)); 
	assign exp_tmp = (a_e > b_e) ? a_e : b_e;
	
	//assign output values
	assign z_m = man_tmp[23] ? man_tmp[23:1] : man_tmp[22:0];
	assign z_e = man_tmp[23] ? exp_tmp + 1 : exp_tmp;
	assign z_s = 0;
	
	end

assign man_tmp = (a_e > b_e) ? (a_m+b_m >> (a_e-b_e)) : (b_m+a_m >> (b_e-a_e)); 
assign exp_tmp = (a_e > b_e) ? a_e : b_e;

//adjust exponent
assign z


//assign output
assign result = z_s << 31 | z_e << 23 | z_m;

endmodule	


