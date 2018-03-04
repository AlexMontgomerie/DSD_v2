module ahfp_add_sub(
	dataa,
	datab,
	result);
	
input wire [31:0] dataa;
input wire [31:0] datab;

output [31:0] result;

wire a_s,b_s;

ahfp_sub sub;
ahfp_add add;

if(a_s>b_s)
	sub (datab,data,result);
else if(b_s>a_s)
	sub (dataa,datab,result);
else if(b_s==0 && a_s==0)
	add (dataa,datab,result);
else if(b_s==1 && a_s==1) 
	add (dataa,datab,result);

endmodule