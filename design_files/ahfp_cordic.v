

module ahfp_cordic( clk,
                    x_start,
                    y_start,
                    theta,
                    x_cos,
                    y_sin
                  );
  
  //parameters
  parameter width = 32;
  parameter N     = 10;  

  //inputs
  input clk;
  input [width-1:0] x_start,y_start;
  input [width-1:0] angle;

  //outputs
  output [width-1:0] x_cos,y_sin;

  //variables
  reg [width-1:0] x [0:N-1];
  reg [width-1:0] y [0:N-1];
  reg [width-1:0] z [0:N-1];
  
  reg [width-1:0] a_tmp [0:N-1];
  reg [width-1:0] b_tmp [0:N-1];
  reg [width-1:0] z_tmp	 [0:N-1];

  wire [width-1:0] atan_table [0:N-1]; 
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
  //TODO: initial block

  
  //setup initial values 
  //TODO: outside +/- pi/2 range
  always @(posedge clk)
  begin
    x[0] <= x_start;
    y[0] <= y_start;
    z[0] <= angle;
  end

  //TODO: need to do fp additions
  genvar i;
  generate
  for(i=0;i<(N-1);i=i+1)
  begin: loop_generation
  
	ahfp_add_sub add_sub_x (.dataa(x[i]),
							.datab(a_tmp[i]),
							.result(x[i+1])
							);

	ahfp_add_sub add_sub_y (.dataa(y[i]),
							.datab(b_tmp[i]),
							.result(y[i+1])
							);
  
 	ahfp_add_sub add_sub_z (.dataa(z[i]),
							.datab(z_tmp[i]),
							.result(z[i+1])
							);
    always @(posedge clk)
    begin

		/*
		x[i+1] <= z[i][31] ?  x[i] + {y[i][31],y[i][30:23]-i,y[22:0]} :   
								x[i] - {y[i][31],y[i][30:23]-i,y[22:0]} ;   
		
		y[i+1] <= z[i][31] ?  y[i] - {x[i][31],x[i][30:23]-i,x[22:0] :   
								y[i] + {x[i][31],x[i][30:23]-i,x[22:0] ;   

		z[i+1] <= z[i][31] ?  z[i] + atan_table[i] :
								z[i] - atan_table[i] ;
		*/
		a_tmp[i] = { z[i][31]^y[i][31],y[i][30:23]-i,y[22:0]};
		b_tmp[i] = {~z[i][31]^x[i][31],x[i][30:23]-i,x[22:0]};
		z_tmp[i] = { z[i][31]^atan_table[i][31],atan_table[i][30:0]};
      /*
      TODO:
       - have a way to stage additions, 
      */

    end
  end
  endgenerate

  assign x_cos = x[N-1];
  assign y_sin = y[N-1];

endmodule


