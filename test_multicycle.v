// test_multicycle.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module test_multicycle (
		input  wire [31:0] dataa,  //                avalon_slave_0.writebyteenable_n
		input  wire [31:0] datab,  //                              .writebyteenable_n
		output wire [31:0] result, //                              .readdata
		input  wire        clock   // nios_custom_instruction_slave.clk
	);

	// TODO: Auto-generated HDL template

	assign result = 32'b00000000000000000000000000000000;

endmodule
