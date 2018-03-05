module ahfp_mod_pi (data,
					result
					);

parameter p_inv = 31'h00000000;
					
input 	[31:0] data;
output 	[31:0] result;				
		
wire [31:0] floor_in;
wire [31:0] floor_out;

reg

ahfp_mult (	data,
			p_inv,
			floor_in
			);

ahfp_floor floor(	floor_in,
					floor_out
					);
ahfp_sub sub ( 	data,
				floor_out,
				result
				);
endmodule