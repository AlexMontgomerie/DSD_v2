module ahfp_mod_pi (clk,
					data,
					result
					);

parameter pi_inv 	= 32'h3EA2F983;
parameter pi 		= 32'h40490FDB;

input clk;
input 	[31:0] data;
output 	[31:0] result;				
		
wire [31:0] floor_in;
wire [31:0] floor_out;

//TODO: need to buffer data for last sub
wire [31:0] mod_buf_val, mul_b_out;

parameter STAGES = 12;

reg [31:0] mod_buf [STAGES-1:0];

always @(posedge clk) begin
		mod_buf[0] <= data;
end

genvar i;
generate
	for (i = 0; i < STAGES-1; i=i+1)
	begin:mod_buf_gen
		always @(posedge clk) begin
			mod_buf[i+1] <= mod_buf[i];
		end
	end
endgenerate

ahfp_mul_multi mul_a 	(clk, data, pi_inv, floor_in);
ahfp_floor floor		(floor_in, floor_out);
ahfp_mul_multi mul_b 	(clk, floor_out, pi, mul_b_out);
ahfp_add_sub_multi sub 	(clk, mod_buf[STAGES-1], {~mul_b_out[31],mul_b_out[30:0]}, result);
endmodule