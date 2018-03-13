module ahfp_mul_multi(
	clk,
	dataa,
	datab,
	result);
	
input wire [31:0] dataa;
input wire [31:0] datab;

input wire clk;
output [31:0] result;

reg [31:0] res;

	
reg 	[23:0] 	a_m, b_m;
reg		[22:0]  z_m,z_m_final;
reg		[7:0]  	a_e, b_e; 
reg		[7:0] 	z_e,z_e_final;
reg				a_s, b_s, z_s;
reg z_s_1, z_s_2, z_s_3, z_s_4, z_s_final;

reg [31:0] dataa_prev, datab_prev;

reg underflow, overflow;

reg 	[47:0] 	man_tmp;
reg 	[7:0]	exp_tmp;
reg 	[23:0] 	z_m_tmp;
reg 	[7:0] 	z_e_tmp;
	
always @ (posedge clk)
	begin
	
		dataa_prev <= dataa;
		datab_prev <= datab;
	
		/////////////////////
		////// Stage 1 //////
		/////////////////////
		//initialise exponent
		a_e <= dataa[30:23];
		b_e <= datab[30:23];

		//get fp fields
		//initialise mantissa
		a_m <= (dataa[30:23]==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, dataa[22:0]};
		b_m <= (datab[30:23]==8'd0) ? {1'b0, dataa[22:0]} : {1'b1, datab[22:0]};

		//initialise sign
		a_s <= dataa[31];
		b_s <= datab[31];	

		//assign output sign
		z_s_1 <= dataa[31] ^ datab[31];
		
		/////////////////////
		
		/////////////////////
		////// Stage 2 //////
		/////////////////////
		//get temporary calculations
		man_tmp <= a_m * b_m;
		exp_tmp <= (a_m[23]&b_m[23]) ? a_e + b_e - 8'd127 : 8'b0;
		z_s_2	<= z_s_1;
		
		/////////////////////
		////// Stage 3 //////
		/////////////////////		
		z_e_tmp <= exp_tmp + man_tmp[47] ;

		// mantissa (could remove rounding)		
		z_m_tmp <= man_tmp[47] ? 	(man_tmp[46:24] + man_tmp[23]) :
									(man_tmp[45:23] + man_tmp[22]) ;
						
		z_s_3 <= z_s_2;
		/////////////////////
		////// Stage 4 //////
		/////////////////////
		// final assigns				
		z_m <= z_m_tmp[23] ? z_m_tmp[23:1] : z_m_tmp[22:0];
		z_e <= z_e_tmp + z_m_tmp[23];
		z_s_4 <= z_s_3;
		
		/////////////////////
		////// Stage 5 //////
		/////////////////////
		underflow <= ($signed(z_e) < $signed(8'h80));
		overflow  <= ($signed(z_e) > $signed(8'h7F));
		z_e_final <= z_e;
		z_m_final <= z_m;
		z_s_final <= z_s_4;
		
		/////////////////////
		////// Stage 6 //////
		/////////////////////
		res <= 	underflow ? 32'd0 :
				overflow  ? {z_s_final, 31'h7F800000} :
							{z_s_final, z_e_final[7:0], z_m_final};

	end		
	
	assign result = res;
	
	endmodule