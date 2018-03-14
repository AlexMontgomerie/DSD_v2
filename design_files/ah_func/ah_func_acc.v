module ah_func_acc(	clk,
		dataa,
		datab,
		result);
		
		input wire        clk;
		input wire [31:0] dataa, datab;
		output reg [31:0] result;
		
		wire [31:0] resw;
		
		ah_func expr(clk, dataa, resultw, resw);
		ahfp_add_sub_multi adder(clk, result, resw, resultw);

		always @ (posedge clk) begin
			result   <= resultw;
		end
endmodule
		
		