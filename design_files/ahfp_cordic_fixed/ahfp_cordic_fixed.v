//http://en.wikibooks.org/wiki/Digital_Circuits/CORDIC


module ahfp_cordic( clk,
                    x_start,
                    y_start,
                    theta,
                    x_cos
                  );
  
  //parameters
  parameter width = 32;
  parameter N     = 10;  

  //inputs
  input clk;
  input [31:0] x_start,y_start;
  input [31:0] theta;

  //outputs
  output [31:0] x_cos;

  //variables
  reg [31:0] x [0:N-1];
  reg [31:0] y [0:N-1];
  reg [31:0] z [0:N-1];
  
  wire [31:0] atan_table [0:N-1]; 
  //TODO: change generate atan to fixed
  //TODO: has to be fixed point between bits 29 and 28
  assign atan_table[0] = 32'h3F490FDB;
  assign atan_table[1] = 32'h3EED6338;
  assign atan_table[2] = 32'h3E7ADBB0;
  assign atan_table[3] = 32'h3DFEADD5;
  assign atan_table[4] = 32'h3D7FAADE;
  assign atan_table[5] = 32'h3CFFEAAE;
  assign atan_table[6] = 32'h3C7FFAAB;
  assign atan_table[7] = 32'h3BFFFEAB;
  assign atan_table[8] = 32'h3B7FFFAB;
  assign atan_table[9] = 32'h3AFFFFEB;
  
  wire [7:0] index [0:N-1];
  
  wire [31:0] an;
  assign an = 32'h3F1B74F4;
  //TODO:
  // - assign an properly with input
  
  ahfp_mult mul(
	x_start,
	an,
	x[0]);  
  
  //assign x[0] = x_start;
  always @(posedge clk) begin
	x[0] = x_start*an;
	y[0] = y_start;
	z[0] = theta;
  end
  //TODO: need to do fp additions
  genvar i;
  generate
  for(i=0;i<(N-1);i=i+1)
  begin: loop_generation
    always @(posedge clk)
    begin
		x[i+1] <= z[i][31] ? x[i] - y[i] >>> i :
							 x[i] + y[i] >>> i ; 
							 
		y[i+1] <= z[i][31] ? y[i] + x[i] >>> i :
							 y[i] - x[i] >>> i ;
							
		z[i+1] <= z[i][31] ? z[i] - atan_table[i] :
							 z[i] - atan_table[i] ;
    end
  end
  endgenerate

  assign x_cos = x[N-1];

endmodule

