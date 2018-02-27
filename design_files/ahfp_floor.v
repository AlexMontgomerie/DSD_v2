module floor(
	data,
	result
	);
	
	input 	[31:0] data;
	output 	[31:0] result;
	
	wire signed [7:0] 	e;
	wire signed [22:0] m;
	
	assign e = data[30:23];
	assign m = data[22:0];
	
	wire signed [22:0] m_tmp;
	assign m_tmp = 	(e==8'd0) 	? m & 23'b00000000000000000000000 : 
					(e==8'd1) 	? m & 23'b10000000000000000000000 : 
					(e==8'd2) 	? m & 23'b11000000000000000000000 : 
					(e==8'd3) 	? m & 23'b11100000000000000000000 : 
					(e==8'd4) 	? m & 23'b11110000000000000000000 : 
					(e==8'd5) 	? m & 23'b11111000000000000000000 : 
					(e==8'd6) 	? m & 23'b11111100000000000000000 : 
					(e==8'd7) 	? m & 23'b11111110000000000000000 : 
					(e==8'd8) 	? m & 23'b11111111000000000000000 : 
					(e==8'd9) 	? m & 23'b11111111100000000000000 : 
					(e==8'd10) 	? m & 23'b11111111110000000000000 : 
					(e==8'd11) 	? m & 23'b11111111111000000000000 : 
					(e==8'd12) 	? m & 23'b11111111111100000000000 : 
					(e==8'd13) 	? m & 23'b11111111111110000000000 : 
					(e==8'd14) 	? m & 23'b11111111111111000000000 : 
					(e==8'd15) 	? m & 23'b11111111111111100000000 : 
					(e==8'd16) 	? m & 23'b11111111111111110000000 : 
					(e==8'd17) 	? m & 23'b11111111111111111000000 : 
					(e==8'd18) 	? m & 23'b11111111111111111100000 : 
					(e==8'd19) 	? m & 23'b11111111111111111110000 : 
					(e==8'd20) 	? m & 23'b11111111111111111111000 : 
					(e==8'd21) 	? m & 23'b11111111111111111111100 : 
					(e==8'd22) 	? m & 23'b11111111111111111111110 :  
					m;
					
	assign result[30:23] 	= (e_tmp<0) ? 8'd0 : e;
	assign result[22:0]  	= (e_tmp<0) ? 8'd0 : m;
	assign result[31]		= data[31];

endmodule