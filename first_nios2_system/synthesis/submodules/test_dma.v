module test_dma(
	slave_address,
	slave_chipselect,
	slave_writedata,
	slave_write,
	slave_byteenable,
	
	//CLOCK
	clk_instr,
	clk_master,
	
	//RESET
	reset_instr,
	reset_master,
	
	// CUSTOM INSTRUCTION CONNECTIONS
	dataa,
	datab,
	result,
	start,
	clk_en,
	done,
	
	// master inputs and outputs
	master_address,
	master_write,
	master_chipselect,
	master_writedata,
	master_readdata,
	master_waitrequest,
	master_response,
	master_waitresponsevalid,
	master_waitresponserequest
);

//PARAMETERS
parameter M_ADDR_WIDTH = 32;
parameter M_DATA_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter BYTEENABLEWIDTH 	= 4;

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

wire 						control_fixed_location;
wire [M_ADDR_WIDTH-1:0] 	control_write_base;
wire [M_ADDR_WIDTH-1:0]		control_write_length;
wire						control_go;	
wire 						control_done;
wire						control_early_done;


//SLAVE
// slave interface
input slave_address;
input slave_write;
input slave_chipselect;
input [31:0] slave_writedata;
input [3:0] slave_byteenable;

wire [31:0] out_data;
wire out_valid;

avalon_slave slave (
	// SLAVE
	.clk(clk_master),
	.reset(reset_master),
	.slave_address(slave_address),
	.slave_chipselect(slave_chipselect),
	.slave_writedata(slave_writedata),
	.slave_write(slave_write),
	.slave_byteenable(slave_byteenable),
	.out_data(out_data),
	.out_valid(out_valid)
);



//MASTER
output [4:0] 				master_address;
output 						master_write;
input [M_ADDR_WIDTH-1:0] 	master_readdata;	
output						master_chipselect;
output [M_ADDR_WIDTH-1:0] 	master_writedata;
input 						master_waitrequest;
input [1:0]	master_response;
input	master_waitresponsevalid;
output	master_waitresponserequest;

assign master_waitresponserequest = 1'b0;

//DMA setup
parameter dma_read_addr_setup 	= 5'b00001;
parameter dma_write_addr_setup 	= 5'b00010;
parameter dma_length_setup 		= 5'b00100;
parameter dma_idle			= 5'b01000;
parameter dma_control_setup		= 5'b10000;

reg [3:0] 	dma_update_state;
reg [4:0] 	master_address_reg;
reg [31:0]	master_writedata_reg;
reg			master_write_reg;
reg			master_chipselect_reg;

assign master_write 		= master_write_reg;
assign master_address 		= master_address_reg;
assign master_writedata 	= master_writedata_reg;
assign master_chipselect 	= master_chipselect_reg;

always @(posedge clk) begin
	if(reset==1) begin
			master_address_reg <= 5'd0;
			master_writedata_reg   <= 32'd0;
			master_write_reg <= 1'b0;
			master_chipselect_reg <= 1'b0;
			dma_update_state <= dma_idle;
	end
	else begin
	case(dma_update_state)
		dma_idle:
		begin
			master_write_reg <= 1'b0;
			master_chipselect_reg <= 1'b0;
			if(start==1) begin
				dma_update_state <= dma_read_addr_setup;
			end
		end
		dma_read_addr_setup:
		if(master_waitrequest==0) begin
			master_address_reg <= 5'd4;
			master_writedata_reg <= dataa;
			master_write_reg <= 1'b1;
			master_chipselect_reg <= 1'b1;
			dma_update_state <= dma_write_addr_setup;
		end
		dma_write_addr_setup:
		if(master_waitrequest==0) begin
			master_address_reg <= 5'd8;
			master_writedata_reg   <= 32'd0;
			master_write_reg <= 1'b1;
			master_chipselect_reg <= 1'b1;
			dma_update_state <= dma_length_setup;
		end
		dma_length_setup:
		if(master_waitrequest==0) begin
			master_address_reg <= 5'd12;
			master_writedata_reg   <= datab;
			master_write_reg <= 1'b1;
			master_chipselect_reg <= 1'b1;
			dma_update_state <= dma_control_setup;
		end
		dma_control_setup:
		if(master_waitrequest==0) begin
			master_address_reg <= 5'd24;
			master_writedata_reg <= 32'h0000014C;
			master_write_reg <= 1'b1;
			master_chipselect_reg <= 1'b1;
			dma_update_state <= dma_idle;
		end
	endcase
	end

end

assign done = out_valid&clk_en;
reg [31:0] result_reg;
assign result = result_reg;

always @ (posedge clk) begin
	if(out_valid)
		result_reg <= out_data;
end

endmodule

module avalon_slave (
	// SLAVE
	clk,
	reset,
	slave_address,
	slave_chipselect,
	slave_writedata,
	slave_write,
	slave_byteenable,
	out_data,
	out_valid
);

input clk;
input reset;

input slave_address;
input slave_chipselect;
input [31:0] slave_writedata;
input slave_write;
input [3:0] slave_byteenable;

output [31:0] out_data;
output out_valid;

reg [31:0] out_data_reg;
reg out_valid_reg;

assign out_valid = out_valid_reg;
assign out_data = out_data_reg;

always @ (posedge clk) begin
	if(slave_write==1 && slave_chipselect==1) begin
		out_valid_reg <= 1'b0;
		out_data_reg  <= slave_writedata;
	end
	else
		out_valid_reg = 1'b0;
end

endmodule