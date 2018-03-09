module ahfp_pipeline_buffer(clk,in,out);
	
	input 	[31:0] in;
	output	[31:0] out;
	
	parameter N = 10;
	
	reg [31:0] buffer [N-1:0];
	
	genvar i;
	generate
	for(i=0;i<(N-1);i=i+1) begin: generate_loop
		always @(posedge clk) begin
			//intermediate buffers
			buffer[i+1] <= buffer[i];
		end
	end
	endgenerate
	
	assign out = buffer[N-1];
	
endmodule