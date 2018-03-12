//http://en.wikibooks.org/wiki/Digital_Circuits/CORDIC


module ahfp_cordic( clk,
                    x_start,
                    y_start,
                    theta,
                    x_cos,
                    y_sin
                  );
  
  //parameters
  parameter width = 32;
  parameter N     = 5;  

  //inputs
  input clk;
  input [31:0] x_start,y_start;
  input [31:0] theta;

  //outputs
  output [31:0] x_cos,y_sin;

  //variables
  wire [31:0] x [0:N-1];
  wire [31:0] y [0:N-1];
  wire [31:0] z [0:N-1];
  
  reg [31:0] x_a [0:N-2];
  reg [31:0] y_a [0:N-2];
  reg [31:0] z_a [0:N-2];
  
  reg [31:0] x_b [0:N-2];
  reg [31:0] y_b [0:N-2];
  reg [31:0] z_b [0:N-2];
  
  wire [31:0] atan_table [0:N-1]; 
  //TODO: generate atan
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
  
  assign index[0] = 8'd0;
  assign index[1] = 8'd1;
  assign index[2] = 8'd2;
  assign index[3] = 8'd3;
  assign index[4] = 8'd4;
  assign index[5] = 8'd5;
  assign index[6] = 8'd6;
  assign index[7] = 8'd7;
  assign index[8] = 8'd8;
  assign index[9] = 8'd9;
  
  //TODO: initial block

  
  //setup initial values 
  //TODO: outside +/- pi/2 range
  /*
  always @(posedge clk)
  begin
    x[0] <= x_start;
    y[0] <= y_start;
    z[0] <= theta;
  end
*/
  
  wire [31:0] add_sub_x_res [0:N-1];
  wire [31:0] add_sub_y_res [0:N-1];
  wire [31:0] add_sub_z_res [0:N-1];
  
  wire [31:0] an;
  assign an = 32'h3F1B74F4;
  
  ahfp_mult mul(
	x_start,
	an,
	x[0]);  
  
  //assign x[0] = x_start;
  assign y[0] = y_start;
  assign z[0] = theta;
  
  //TODO: need to do fp additions
  genvar i;
  generate
  for(i=0;i<(N-1);i=i+1)
  begin: loop_generation
  
	ahfp_add_sub add_sub_x (
							.clk(clk),
							.dataa(x_a[i]),
							.datab(x_b[i]),
							.result(x[i+1])
							);

	ahfp_add_sub add_sub_y (
							.clk(clk),
							.dataa(y_a[i]),
							.datab(y_b[i]),
							.result(y[i+1])
							);
  
 	ahfp_add_sub add_sub_z (
							.clk(clk),
							.dataa(z_a[i]),
							.datab(z_b[i]),
							.result(z[i+1])
							);
    always @(posedge clk)
    begin
		
		x_a[i] <= x[i];
		y_a[i] <= y[i];
		z_a[i] <= z[i];
		
		x_b[i] <= {z[i][31]^~y[i][31],((y[i][30:23]>=8'd2) ? (y[i][30:23]-index[i]) : (8'd0)),y[i][22:0]};
		y_b[i] <= {z[i][31]^x[i][31] ,((x[i][30:23]>=8'd2) ? (x[i][30:23]-index[i]) : (8'd0)),x[i][22:0]};
		z_b[i] <= {z[i][31]^~atan_table[i][31] ,  atan_table[i][30:0]};

    end
  end
  endgenerate

  assign x_cos = x[N-1];
  assign y_sin = y[N-1];

endmodule


