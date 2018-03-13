module ahfp_floor_divide_four(
	data,
	result
	);
	
	input 	[31:0] data;
	output 	[31:0] result;
	
	wire [7:0]  e;
	wire [22:0] m;
	
	assign e = data[30:23];
	assign m = data[22:0];
	
	wire [22:0] m_tmp;
	assign m_tmp = 	(e==8'd129) 	? m & 23'b00000000000000000000000 : 
					(e==8'd130) 	? m & 23'b10000000000000000000000 : 
					(e==8'd131) 	? m & 23'b11000000000000000000000 : 
					(e==8'd132) 	? m & 23'b11100000000000000000000 : 
					(e==8'd133) 	? m & 23'b11110000000000000000000 : 
					(e==8'd134) 	? m & 23'b11111000000000000000000 : 
					(e==8'd135) 	? m & 23'b11111100000000000000000 : 
					(e==8'd136) 	? m & 23'b11111110000000000000000 : 
					(e==8'd137) 	? m & 23'b11111111000000000000000 : 
					(e==8'd138) 	? m & 23'b11111111100000000000000 : 
					(e==8'd139) 	? m & 23'b11111111110000000000000 : 
					(e==8'd140) 	? m & 23'b11111111111000000000000 : 
					(e==8'd141) 	? m & 23'b11111111111100000000000 : 
					(e==8'd142) 	? m & 23'b11111111111110000000000 : 
					(e==8'd143) 	? m & 23'b11111111111111000000000 : 
					(e==8'd144) 	? m & 23'b11111111111111100000000 : 
					(e==8'd145) 	? m & 23'b11111111111111110000000 : 
					(e==8'd146) 	? m & 23'b11111111111111111000000 : 
					(e==8'd147) 	? m & 23'b11111111111111111100000 : 
					(e==8'd148) 	? m & 23'b11111111111111111110000 : 
					(e==8'd149) 	? m & 23'b11111111111111111111000 : 
					(e==8'd150) 	? m & 23'b11111111111111111111100 : 
					(e==8'd151) 	? m & 23'b11111111111111111111110 :  
					m;
					
	assign result[30:23] 	= 	(e<8'd129) 		 ? 8'd0  : e-2;
	
	assign result[22:0]  	= 	(e<8'd129) 		 ? 23'd0 : m_tmp;
	
	assign result[31]		= 	data[31];

endmodule