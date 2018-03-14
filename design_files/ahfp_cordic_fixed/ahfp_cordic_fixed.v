//http://en.wikibooks.org/wiki/Digital_Circuits/CORDIC


module ahfp_cordic_fixed( 	clk,
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
  reg signed [31:0] x [0:N-1];
  reg signed [31:0] y [0:N-1];
  reg signed [31:0] z [0:N-1];

  wire [31:0] atan_table [0:N-1]; 
  assign atan_table[0] = 32'h1921fb60;
  assign atan_table[1] = 32'h0ed63380;
  assign atan_table[2] = 32'h07d6dd80;
  assign atan_table[3] = 32'h03fab754;
  assign atan_table[4] = 32'h01ff55bc;
  assign atan_table[5] = 32'h00ffeaae;
  assign atan_table[6] = 32'h007ffd55;
  assign atan_table[7] = 32'h003fffaa;
  assign atan_table[8] = 32'h001ffff5;
  assign atan_table[9] = 32'h000ffffe;
  
  wire [7:0] index [0:N-1];
  
  wire [31:0] an;
  assign an = 32'h136e9e80;
 
  
  wire [31:0] nothing;
  //assign x[0] = x_start;
  
  wire [1:0] quadrant;
  assign quadrant = theta[31:30];
  
  always @(posedge clk) begin
	case(quadrant)
	2'b00,2'b11:
		begin
			x[0] <= an;
			y[0] <= 32'd0;
			z[0] <= theta;
		end
	2'b01:
		begin
			x[0] <= 32'd0;
			y[0] <= an;
			z[0] <= {2'b00,theta[29:0]};
		end
	2'b10:
		begin
			x[0] <= 32'd0;
			y[0] <= ~an + 1;
			z[0] <= {2'b11,theta[29:0]};
		end
	endcase
  end
  genvar i;
  generate
  for(i=0;i<(N-1);i=i+1)
  begin: loop_generation
    always @(posedge clk)
    begin
		x[i+1] <= z[i][31] ? x[i] + (y[i] >>> i) :
							 x[i] - (y[i] >>> i) ; 
							 
		y[i+1] <= z[i][31] ? y[i] - (x[i] >>> i) :
							 y[i] + (x[i] >>> i) ;
							
		z[i+1] <= z[i][31] ? z[i] + atan_table[i] :
							 z[i] - atan_table[i] ;
    end
  end
  endgenerate

  assign x_cos = x[N-1];

endmodule

