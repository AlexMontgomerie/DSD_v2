`ifndef STAGES
`define STAGES 10
`endif
`ifndef WIDTH
`define WIDTH 32
`endif
module ahfp_pipeline_buffer(clk,in,out);
	
	input clk;
	input 	[`WIDTH-1:0] in;
	output	[`WIDTH-1:0] out;
	
	//parameter N = STAGES;
	
	reg [`WIDTH-1:0] buffer [`STAGES-1:0];
	
	always @(posedge clk) begin
		buffer[0] <= in;
	end
	
	genvar i;
	generate
	for(i=0;i<(`STAGES-1);i=i+1) begin: generate_loop
		always @(posedge clk) begin
			//intermediate buffers
			buffer[i+1] <= buffer[i];
		end
	end
	endgenerate
	
	assign out = buffer[`STAGES-1];
	
endmodule