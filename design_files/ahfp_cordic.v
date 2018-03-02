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

  wire [width-1:0] atan_table [0:N-1]; 
  //TODO: generate atan

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
  begin
    always @(posedge clk)
    begin
      x[i+1] <= z[i][31] ?  x[i] + {y[i][31],y[i][30:23]-i,y[22:0] :   
                            x[i] - {y[i][31],y[i][30:23]-i,y[22:0] ;   
   
      y[i+1] <= z[i][31] ?  y[i] - {x[i][31],x[i][30:23]-i,x[22:0] :   
                            y[i] + {x[i][31],x[i][30:23]-i,x[22:0] ;   

      z[i+1] <= z[i][31] ?  z[i] + atan_table[i] :
                            z[i] - atan_table[i] ;
    end
  end
  endgenerate

  assign x_cos = x[N-1];
  assign y_sin = y[N-1];

endmodule


