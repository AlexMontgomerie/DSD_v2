module ah_custom_instruction (
	//CLOCK
	clk_instr,
	clk_master,
	
	//
	reset_instr,
	reset_master,
	
	// CUSTOM INSTRUCTION CONNECTIONS
	dataa,
	datab,
	result,
	start,
	clk_en,
	done,
	
	// AVALON MASTER BUS CONNECTIONS
	master_address,
	master_read,
	master_byteenable,
	master_readdata,
	master_readdatavalid,
	master_burstcount,
	master_waitrequest
);

//PARAMETERS
parameter M_ADDR_WIDTH = 24;
parameter M_DATA_WIDTH = 16;
parameter BYTEENABLEWIDTH 	= 2;

//CLOCK
input clk_instr	, clk_master;
input reset_instr	, reset_master;

wire clk,reset;
assign clk = clk_instr;
assign reset = reset_instr;

// CUSTOM INSTRUCTION
//	- inputs
input [31:0] dataa,datab;
input start,clk_en;
// - outputs
output [31:0] result;
output done;


// AVALON MASTER BUS CONNECTIONS
// - inputs
input 						master_waitrequest;
input 						master_readdatavalid;
input [M_DATA_WIDTH-1:0] 	master_readdata;			
// - outputs
output wire [M_ADDR_WIDTH-1:0] 		master_address;
output wire 						master_read;							
output wire [BYTEENABLEWIDTH-1:0] 	master_byteenable;	
output wire  						master_burstcount;	

//INTERNAL CONNECTIONS
wire 						control_fixed_location;
wire [M_ADDR_WIDTH-1:0] 	control_read_base;
wire [M_ADDR_WIDTH-1:0]		control_read_length;
wire						control_go;	
wire 						control_done;
wire						control_early_done;
	
wire [M_DATA_WIDTH-1:0] user_buffer_data;
wire 							user_data_available;	
wire 							user_read_buffer;

latency_aware_read_master master (
	.clk(clk_master),
	.reset(reset_master),

	// control inputs and outputs
	.control_fixed_location(control_fixed_location),
	.control_read_base(control_read_base),
	.control_read_length(control_read_length),
	.control_go(control_go),
	.control_done(control_done),
	.control_early_done(control_early_done),
	
	// user logic inputs and outputs
	.user_read_buffer(user_read_buffer),
	.user_buffer_data(user_buffer_data),
	.user_data_available(user_data_available),
	
	// master inputs and outputs
	.master_address(master_address),
	.master_read(master_read),
	.master_byteenable(master_byteenable),
	.master_readdata(master_readdata),
	.master_readdatavalid(master_readdatavalid),
	.master_waitrequest(master_waitrequest)
);

	assign control_read_base 	= dataa;

	//variable read size
	assign control_fixed_location = 1'b0;
	
	//control go latch
	parameter control_go_idle 	= 2'b01;
	parameter control_go_en 	= 2'b10;
	
	reg control_go_reg;
	reg [1:0] control_go_state;
	
	initial control_go_reg = 1'b0;
	initial control_go_state = control_go_idle;
	
	always @ (posedge clk) begin
		case(control_go_state)
		control_go_idle:
			if(start==1) begin
				control_go_reg 	<= 1'b1;
				control_go_state 	<= control_go_en;
			end
		control_go_en:
			if(control_done|control_early_done==1) begin
				control_go_reg 	<= 1'b0;
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
	
	assign result = user_buffer_data;
	assign done = user_data_available;
	
	// ADDRESS LENGTH
	
	reg [M_ADDR_WIDTH-1:0] control_read_length_reg;
	initial control_read_length_reg = 0;
	
	always @(posedge clk) begin
		if(reset==1)
			control_read_length_reg <= 0;
		if(start==1)
			control_read_length_reg <= datab[M_ADDR_WIDTH-1:0];
	end
	
	assign control_read_length = control_read_length_reg;
	
	//BURST COUNT
	assign master_burstcount = 1;

endmodule
