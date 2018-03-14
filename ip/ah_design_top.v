module ah_design_top(
	clock,
	read_addr,
	size,
	read_en,
	sum_result,
	sum_done,
	control_fixed_location,
	control_read_base,
	control_read_length,
	control_go,
	control_done,
	user_buffer_data,
	user_data_available,
	user_read_buffer,
	clk_en,
	clk_out
	);
	
	//CLOCK
	input clock,clk_en;
	output clk_out;
	wire clk;
	
	assign clk = clock & clk_en;
	assign clk_out = clock & clk_en;
	
	//NIOS CONNECTION
	input [31:0] read_addr;
	input [31:0] size;
	input read_en;
	
	output [31:0] sum_result;
	output sum_done;
	
	//AVALON MASTER CONNECTION
	output 			control_fixed_location;
	output [24:0] 	control_read_base;
	output [24:0]	control_read_length;
	output			control_go;
	
	input control_done;
	
	//BUFFER CONNECTION
	input [31:0] user_buffer_data;
	input user_data_available;
	
	output user_read_buffer;
	
	//variable read size
	assign control_fixed_location = 1'b0;
	
	//control go latch
	parameter control_go_idle 	= 2'd1;
	parameter control_go_en 	= 2'd2;
	
	reg control_go_reg;
	reg [1:0] control_go_state;
	
	initial control_go_reg = 1'b0;
	initial control_go_state = control_go_idle;
	
	always @ (posedge clk) begin
		case(control_go_state)
		control_go_idle:
			if(read_en) begin
				control_go_reg 		<= 1'b1;
				control_go_state 	<= control_go_en;
			end
			control_go_en:
			if(control_done) begin
				control_go_reg 		<= 1'b0;
				control_go_state 	<= control_go_idle;
			end
		endcase
	end
	
	assign control_go = control_go_reg;
	
	reg user_read_buffer_reg;
	assign user_read_buffer = user_read_buffer_reg;
	
	always @(posedge clk) begin
		user_read_buffer_reg <= user_data_available;
	end
	
	assign sum_result = user_buffer_data;
	assign sum_done = user_data_available;
	
endmodule