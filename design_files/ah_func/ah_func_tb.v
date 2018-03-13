// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_add;

reg clk;
reg [31:0] dataa,datab,result_correct;
wire [31:0] result;

ah_func dut (	.dataa(dataa),
		.datab(datab),
		.result(result));

initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
		dataa = 32'h0;
		datab = 32'h00000000;
		result_correct = 32'h0;

		#20 dataa = 32'h3f800000;
		datab = 32'h00000000;
		result_correct = 32'h3faac7d5;

		#20 dataa = 32'h40000000;
		datab = 32'h00000000;
		result_correct = 32'h408ac7d5;

		#20 dataa = 32'h40400000;
		datab = 32'h00000000;
		result_correct = 32'h411020d0;

		#20 dataa = 32'h40800000;
		datab = 32'h00000000;
		result_correct = 32'h41851647;

		#20 dataa = 32'h40a00000;
		datab = 32'h00000000;
		result_correct = 32'h41caf2cf;

		#20 dataa = 32'h40c00000;
		datab = 32'h00000000;
		result_correct = 32'h420fb910;

		#20 dataa = 32'h40e00000;
		datab = 32'h00000000;
		result_correct = 32'h42414a1c;

		#20 dataa = 32'h41000000;
		datab = 32'h00000000;
		result_correct = 32'h415df418;

		#20 dataa = 32'h41100000;
		datab = 32'h00000000;
		result_correct = 32'h4187f477;

		#20 dataa = 32'h41200000;
		datab = 32'h00000000;
		result_correct = 32'h41a366b3;

		#20 dataa = 32'h41300000;
		datab = 32'h00000000;
		result_correct = 32'h41c150be;

		#20 dataa = 32'h41400000;
		datab = 32'h00000000;
		result_correct = 32'hc2cb70c9;

		#20 dataa = 32'h41500000;
		datab = 32'h00000000;
		result_correct = 32'hc2efd7ec;

		#20 dataa = 32'h41600000;
		datab = 32'h00000000;
		result_correct = 32'hc30b9e89;

		#20 dataa = 32'h41700000;
		datab = 32'h00000000;
		result_correct = 32'hc320d01e;

		#20 dataa = 32'h41800000;
		datab = 32'h00000000;
		result_correct = 32'hc36e6d57;

		#20 dataa = 32'h41880000;
		datab = 32'h00000000;
		result_correct = 32'hc386d8b7;

		#20 dataa = 32'h41900000;
		datab = 32'h00000000;
		result_correct = 32'hc3977131;

		#20 dataa = 32'h41980000;
		datab = 32'h00000000;
		result_correct = 32'hc3a90018;

		#20 dataa = 32'h41a00000;
		datab = 32'h00000000;
		result_correct = 32'hc2d5b608;

		#20 dataa = 32'h41a80000;
		datab = 32'h00000000;
		result_correct = 32'hc2ecaa9c;

		#20 dataa = 32'h41b00000;
		datab = 32'h00000000;
		result_correct = 32'hc302652b;

		#20 dataa = 32'h41b80000;
		datab = 32'h00000000;
		result_correct = 32'hc30f0a9b;

		#20 dataa = 32'h41c00000;
		datab = 32'h00000000;
		result_correct = 32'h43c05012;

		#20 dataa = 32'h41c80000;
		datab = 32'h00000000;
		result_correct = 32'h43d0698c;

		#20 dataa = 32'h41d00000;
		datab = 32'h00000000;
		result_correct = 32'h43e128a3;

		#20 dataa = 32'h41d80000;
		datab = 32'h00000000;
		result_correct = 32'h43f28d56;

		#20 dataa = 32'h41e00000;
		datab = 32'h00000000;
		result_correct = 32'h4445c698;

		#20 dataa = 32'h41e80000;
		datab = 32'h00000000;
		result_correct = 32'h44540681;

		#20 dataa = 32'h41f00000;
		datab = 32'h00000000;
		result_correct = 32'h4462c548;

		#20 dataa = 32'h41f80000;
		datab = 32'h00000000;
		result_correct = 32'h447202f0;

		#20 dataa = 32'h42000000;
		datab = 32'h00000000;
		result_correct = 32'h43e12dfe;

		#20 dataa = 32'h42040000;
		datab = 32'h00000000;
		result_correct = 32'h43ef3729;

		#20 dataa = 32'h42080000;
		datab = 32'h00000000;
		result_correct = 32'h43fdacec;

		#20 dataa = 32'h420c0000;
		datab = 32'h00000000;
		result_correct = 32'h440647a3;

		#20 dataa = 32'h42100000;
		datab = 32'h00000000;
		result_correct = 32'hc428234e;

		#20 dataa = 32'h42140000;
		datab = 32'h00000000;
		result_correct = 32'hc431bcb3;

		#20 dataa = 32'h42180000;
		datab = 32'h00000000;
		result_correct = 32'hc43b9a4d;

		#20 dataa = 32'h421c0000;
		datab = 32'h00000000;
		result_correct = 32'hc445bc1a;

		#20 dataa = 32'h42200000;
		datab = 32'h00000000;
		result_correct = 32'hc4c57dfe;

		#20 dataa = 32'h42240000;
		datab = 32'h00000000;
		result_correct = 32'hc4cf8de5;

		#20 dataa = 32'h42280000;
		datab = 32'h00000000;
		result_correct = 32'hc4d9ddca;

		#20 dataa = 32'h422c0000;
		datab = 32'h00000000;
		result_correct = 32'hc4e46daf;

		#20 dataa = 32'h42300000;
		datab = 32'h00000000;
		result_correct = 32'hc481ccec;

		#20 dataa = 32'h42340000;
		datab = 32'h00000000;
		result_correct = 32'hc487d4db;

		#20 dataa = 32'h42380000;
		datab = 32'h00000000;
		result_correct = 32'hc48dffd8;

		#20 dataa = 32'h423c0000;
		datab = 32'h00000000;
		result_correct = 32'hc4944de3;

		#20 dataa = 32'h42400000;
		datab = 32'h00000000;
		result_correct = 32'h44710e27;

		#20 dataa = 32'h42440000;
		datab = 32'h00000000;
		result_correct = 32'h447b1386;

		#20 dataa = 32'h42480000;
		datab = 32'h00000000;
		result_correct = 32'h4482a691;

		#20 dataa = 32'h424c0000;
		datab = 32'h00000000;
		result_correct = 32'h4487dd7d;

		#20 dataa = 32'h42500000;
		datab = 32'h00000000;
		result_correct = 32'h4528b751;

		#20 dataa = 32'h42540000;
		datab = 32'h00000000;
		result_correct = 32'h452f3c57;

		#20 dataa = 32'h42580000;
		datab = 32'h00000000;
		result_correct = 32'h4535e101;

		#20 dataa = 32'h425c0000;
		datab = 32'h00000000;
		result_correct = 32'h453ca54e;

		#20 dataa = 32'h42600000;
		datab = 32'h00000000;
		result_correct = 32'h45032c0e;

		#20 dataa = 32'h42640000;
		datab = 32'h00000000;
		result_correct = 32'h4507dde8;

		#20 dataa = 32'h42680000;
		datab = 32'h00000000;
		result_correct = 32'h450ca4e3;

		#20 dataa = 32'h426c0000;
		datab = 32'h00000000;
		result_correct = 32'h45118100;

		#20 dataa = 32'h42700000;
		datab = 32'h00000000;
		result_correct = 32'hc47025a4;

		#20 dataa = 32'h42740000;
		datab = 32'h00000000;
		result_correct = 32'hc478587f;

		#20 dataa = 32'h42780000;
		datab = 32'h00000000;
		result_correct = 32'hc480574b;

		#20 dataa = 32'h427c0000;
		datab = 32'h00000000;
		result_correct = 32'hc48493f2;

		#20 dataa = 32'h42800000;
		datab = 32'h00000000;
		result_correct = 32'hc573292c;

		#20 dataa = 32'h42820000;
		datab = 32'h00000000;
		result_correct = 32'hc57ad9c8;

		#20 dataa = 32'h42840000;
		datab = 32'h00000000;
		result_correct = 32'hc5815484;

		#20 dataa = 32'h42860000;
		datab = 32'h00000000;
		result_correct = 32'hc5854b78;

		#20 dataa = 32'h42880000;
		datab = 32'h00000000;
		result_correct = 32'hc5596cbf;

		#20 dataa = 32'h428a0000;
		datab = 32'h00000000;
		result_correct = 32'hc55fe5fc;

		#20 dataa = 32'h428c0000;
		datab = 32'h00000000;
		result_correct = 32'hc5667788;

		#20 dataa = 32'h428e0000;
		datab = 32'h00000000;
		result_correct = 32'hc56d2163;

		#20 dataa = 32'h42900000;
		datab = 32'h00000000;
		result_correct = 32'h443a3620;

		#20 dataa = 32'h42920000;
		datab = 32'h00000000;
		result_correct = 32'h443f4b0c;

		#20 dataa = 32'h42940000;
		datab = 32'h00000000;
		result_correct = 32'h44447179;

		#20 dataa = 32'h42960000;
		datab = 32'h00000000;
		result_correct = 32'h4449a966;

		#20 dataa = 32'h42980000;
		datab = 32'h00000000;
		result_correct = 32'h45a4fb4d;

		#20 dataa = 32'h429a0000;
		datab = 32'h00000000;
		result_correct = 32'h45a95605;

		#20 dataa = 32'h429c0000;
		datab = 32'h00000000;
		result_correct = 32'h45adbf41;

		#20 dataa = 32'h429e0000;
		datab = 32'h00000000;
		result_correct = 32'h45b23702;

		#20 dataa = 32'h42a00000;
		datab = 32'h00000000;
		result_correct = 32'h45aa0552;

		#20 dataa = 32'h42a20000;
		datab = 32'h00000000;
		result_correct = 32'h45ae4835;

		#20 dataa = 32'h42a40000;
		datab = 32'h00000000;
		result_correct = 32'h45b29897;

		#20 dataa = 32'h42a60000;
		datab = 32'h00000000;
		result_correct = 32'h45b6f67b;

		#20 dataa = 32'h42a80000;
		datab = 32'h00000000;
		result_correct = 32'h42927498;

		#20 dataa = 32'h42aa0000;
		datab = 32'h00000000;
		result_correct = 32'h4294f38b;

		#20 dataa = 32'h42ac0000;
		datab = 32'h00000000;
		result_correct = 32'h42977705;

		#20 dataa = 32'h42ae0000;
		datab = 32'h00000000;
		result_correct = 32'h4299ff08;

		#20 dataa = 32'h42b00000;
		datab = 32'h00000000;
		result_correct = 32'hc5c9ae29;

		#20 dataa = 32'h42b20000;
		datab = 32'h00000000;
		result_correct = 32'hc5ce4e49;

		#20 dataa = 32'h42b40000;
		datab = 32'h00000000;
		result_correct = 32'hc5d2fbd5;

		#20 dataa = 32'h42b60000;
		datab = 32'h00000000;
		result_correct = 32'hc5d7b6cf;

		#20 dataa = 32'h42b80000;
		datab = 32'h00000000;
		result_correct = 32'hc5ef8e73;

		#20 dataa = 32'h42ba0000;
		datab = 32'h00000000;
		result_correct = 32'hc5f4ceed;

		#20 dataa = 32'h42bc0000;
		datab = 32'h00000000;
		result_correct = 32'hc5fa1df9;

		#20 dataa = 32'h42be0000;
		datab = 32'h00000000;
		result_correct = 32'hc5ff7b9a;

		#20 dataa = 32'h42c00000;
		datab = 32'h00000000;
		result_correct = 32'hc4a19db5;

		#20 dataa = 32'h42c20000;
		datab = 32'h00000000;
		result_correct = 32'hc4a51051;

		#20 dataa = 32'h42c40000;
		datab = 32'h00000000;
		result_correct = 32'hc4a88c3c;

		#20 dataa = 32'h42c60000;
		datab = 32'h00000000;
		result_correct = 32'hc4ac1178;

		#20 dataa = 32'h42c80000;
		datab = 32'h00000000;
		result_correct = 32'h45ed282f;

		#20 dataa = 32'h42ca0000;
		datab = 32'h00000000;
		result_correct = 32'h45f1e874;

		#20 dataa = 32'h42cc0000;
		datab = 32'h00000000;
		result_correct = 32'h45f6b4cc;

		#20 dataa = 32'h42ce0000;
		datab = 32'h00000000;
		result_correct = 32'h45fb8d31;

		#20 dataa = 32'h42d00000;
		datab = 32'h00000000;
		result_correct = 32'h462314cf;

		#20 dataa = 32'h42d20000;
		datab = 32'h00000000;
		result_correct = 32'h46263982;

		#20 dataa = 32'h42d40000;
		datab = 32'h00000000;
		result_correct = 32'h462965e4;

		#20 dataa = 32'h42d60000;
		datab = 32'h00000000;
		result_correct = 32'h462c99f5;

		#20 dataa = 32'h42d80000;
		datab = 32'h00000000;
		result_correct = 32'h45522a2c;

		#20 dataa = 32'h42da0000;
		datab = 32'h00000000;
		result_correct = 32'h45560b0d;

		#20 dataa = 32'h42dc0000;
		datab = 32'h00000000;
		result_correct = 32'h4559f501;

		#20 dataa = 32'h42de0000;
		datab = 32'h00000000;
		result_correct = 32'h455de808;

		#20 dataa = 32'h42e00000;
		datab = 32'h00000000;
		result_correct = 32'hc5fe7a72;

		#20 dataa = 32'h42e20000;
		datab = 32'h00000000;
		result_correct = 32'hc6018780;

		#20 dataa = 32'h42e40000;
		datab = 32'h00000000;
		result_correct = 32'hc603d703;

		#20 dataa = 32'h42e60000;
		datab = 32'h00000000;
		result_correct = 32'hc6062bbf;

		#20 dataa = 32'h42e80000;
		datab = 32'h00000000;
		result_correct = 32'hc64f3d5b;

		#20 dataa = 32'h42ea0000;
		datab = 32'h00000000;
		result_correct = 32'hc652d608;

		#20 dataa = 32'h42ec0000;
		datab = 32'h00000000;
		result_correct = 32'hc656769f;

		#20 dataa = 32'h42ee0000;
		datab = 32'h00000000;
		result_correct = 32'hc65a1f22;

		#20 dataa = 32'h42f00000;
		datab = 32'h00000000;
		result_correct = 32'hc5b9641e;

		#20 dataa = 32'h42f20000;
		datab = 32'h00000000;
		result_correct = 32'hc5bc8272;

		#20 dataa = 32'h42f40000;
		datab = 32'h00000000;
		result_correct = 32'hc5bfa770;

		#20 dataa = 32'h42f60000;
		datab = 32'h00000000;
		result_correct = 32'hc5c2d316;

		#20 dataa = 32'h42f80000;
		datab = 32'h00000000;
		result_correct = 32'h4602c6c0;

		#20 dataa = 32'h42fa0000;
		datab = 32'h00000000;
		result_correct = 32'h4604e2e4;

		#20 dataa = 32'h42fc0000;
		datab = 32'h00000000;
		result_correct = 32'h4607035b;

		#20 dataa = 32'h42fe0000;
		datab = 32'h00000000;
		result_correct = 32'h46092825;

		#20 dataa = 32'h43000000;
		datab = 32'h00000000;
		result_correct = 32'h46808000;

		#20 dataa = 32'h43010000;
		datab = 32'h00000000;
		result_correct = 32'h46828300;

		#20 dataa = 32'h43020000;
		datab = 32'h00000000;
		result_correct = 32'h46848a00;

		#20 dataa = 32'h43030000;
		datab = 32'h00000000;
		result_correct = 32'h46869500;

		#20 dataa = 32'h43040000;
		datab = 32'h00000000;
		result_correct = 32'h461420e8;

		#20 dataa = 32'h43050000;
		datab = 32'h00000000;
		result_correct = 32'h46165fa0;

		#20 dataa = 32'h43060000;
		datab = 32'h00000000;
		result_correct = 32'h4618a2ac;

		#20 dataa = 32'h43070000;
		datab = 32'h00000000;
		result_correct = 32'h461aea0a;

		#20 dataa = 32'h43080000;
		datab = 32'h00000000;
		result_correct = 32'hc5ee686a;

		#20 dataa = 32'h43090000;
		datab = 32'h00000000;
		result_correct = 32'hc5f1f148;

		#20 dataa = 32'h430a0000;
		datab = 32'h00000000;
		result_correct = 32'hc5f580ce;

		#20 dataa = 32'h430b0000;
		datab = 32'h00000000;
		result_correct = 32'hc5f916fc;

		#20 dataa = 32'h430c0000;
		datab = 32'h00000000;
		result_correct = 32'hc6970bb5;

		#20 dataa = 32'h430d0000;
		datab = 32'h00000000;
		result_correct = 32'hc6993715;

		#20 dataa = 32'h430e0000;
		datab = 32'h00000000;
		result_correct = 32'hc69b666b;

		#20 dataa = 32'h430f0000;
		datab = 32'h00000000;
		result_correct = 32'hc69d99b6;

		#20 dataa = 32'h43100000;
		datab = 32'h00000000;
		result_correct = 32'hc652a7d1;

		#20 dataa = 32'h43110000;
		datab = 32'h00000000;
		result_correct = 32'hc655996d;

		#20 dataa = 32'h43120000;
		datab = 32'h00000000;
		result_correct = 32'hc6589045;

		#20 dataa = 32'h43130000;
		datab = 32'h00000000;
		result_correct = 32'hc65b8c57;

		#20 dataa = 32'h43140000;
		datab = 32'h00000000;
		result_correct = 32'h45c47ab2;

		#20 dataa = 32'h43150000;
		datab = 32'h00000000;
		result_correct = 32'h45c720ad;

		#20 dataa = 32'h43160000;
		datab = 32'h00000000;
		result_correct = 32'h45c9cb33;

		#20 dataa = 32'h43170000;
		datab = 32'h00000000;
		result_correct = 32'h45cc7a41;

		#20 dataa = 32'h43180000;
		datab = 32'h00000000;
		result_correct = 32'h46ade78c;

		#20 dataa = 32'h43190000;
		datab = 32'h00000000;
		result_correct = 32'h46b03240;

		#20 dataa = 32'h431a0000;
		datab = 32'h00000000;
		result_correct = 32'h46b280cc;

		#20 dataa = 32'h431b0000;
		datab = 32'h00000000;
		result_correct = 32'h46b4d32e;

		#20 dataa = 32'h431c0000;
		datab = 32'h00000000;
		result_correct = 32'h468ff1ee;

		#20 dataa = 32'h431d0000;
		datab = 32'h00000000;
		result_correct = 32'h4691cae0;

		#20 dataa = 32'h431e0000;
		datab = 32'h00000000;
		result_correct = 32'h4693a6d5;

		#20 dataa = 32'h431f0000;
		datab = 32'h00000000;
		result_correct = 32'h469585ce;

		#20 dataa = 32'h43200000;
		datab = 32'h00000000;
		result_correct = 32'hc563ccd1;

		#20 dataa = 32'h43210000;
		datab = 32'h00000000;
		result_correct = 32'hc566b01a;

		#20 dataa = 32'h43220000;
		datab = 32'h00000000;
		result_correct = 32'hc569980b;

		#20 dataa = 32'h43230000;
		datab = 32'h00000000;
		result_correct = 32'hc56c84a5;

		#20 dataa = 32'h43240000;
		datab = 32'h00000000;
		result_correct = 32'hc6becf84;

		#20 dataa = 32'h43250000;
		datab = 32'h00000000;
		result_correct = 32'hc6c1260a;

		#20 dataa = 32'h43260000;
		datab = 32'h00000000;
		result_correct = 32'hc6c38036;

		#20 dataa = 32'h43270000;
		datab = 32'h00000000;
		result_correct = 32'hc6c5de06;

		#20 dataa = 32'h43280000;
		datab = 32'h00000000;
		result_correct = 32'hc6b85be9;

		#20 dataa = 32'h43290000;
		datab = 32'h00000000;
		result_correct = 32'hc6ba9071;

		#20 dataa = 32'h432a0000;
		datab = 32'h00000000;
		result_correct = 32'hc6bcc855;

		#20 dataa = 32'h432b0000;
		datab = 32'h00000000;
		result_correct = 32'hc6bf0395;

		#20 dataa = 32'h432c0000;
		datab = 32'h00000000;
		result_correct = 32'h4358ee0a;

		#20 dataa = 32'h432d0000;
		datab = 32'h00000000;
		result_correct = 32'h435af4eb;

		#20 dataa = 32'h432e0000;
		datab = 32'h00000000;
		result_correct = 32'h435cfe11;

		#20 dataa = 32'h432f0000;
		datab = 32'h00000000;
		result_correct = 32'h435f0979;

		#20 dataa = 32'h43300000;
		datab = 32'h00000000;
		result_correct = 32'h46cce671;

		#20 dataa = 32'h43310000;
		datab = 32'h00000000;
		result_correct = 32'h46cf3b34;

		#20 dataa = 32'h43320000;
		datab = 32'h00000000;
		result_correct = 32'h46d19357;

		#20 dataa = 32'h43330000;
		datab = 32'h00000000;
		result_correct = 32'h46d3eed9;

		#20 dataa = 32'h43340000;
		datab = 32'h00000000;
		result_correct = 32'h46e6668d;

		#20 dataa = 32'h43350000;
		datab = 32'h00000000;
		result_correct = 32'h46e8f6ba;

		#20 dataa = 32'h43360000;
		datab = 32'h00000000;
		result_correct = 32'h46eb8a89;

		#20 dataa = 32'h43370000;
		datab = 32'h00000000;
		result_correct = 32'h46ee21f8;

		#20 dataa = 32'h43380000;
		datab = 32'h00000000;
		result_correct = 32'h45938b00;

		#20 dataa = 32'h43390000;
		datab = 32'h00000000;
		result_correct = 32'h459522a6;

		#20 dataa = 32'h433a0000;
		datab = 32'h00000000;
		result_correct = 32'h4596bc7c;

		#20 dataa = 32'h433b0000;
		datab = 32'h00000000;
		result_correct = 32'h45985882;

		#20 dataa = 32'h433c0000;
		datab = 32'h00000000;
		result_correct = 32'hc6d108d1;

		#20 dataa = 32'h433d0000;
		datab = 32'h00000000;
		result_correct = 32'hc6d3449f;

		#20 dataa = 32'h433e0000;
		datab = 32'h00000000;
		result_correct = 32'hc6d58377;

		#20 dataa = 32'h433f0000;
		datab = 32'h00000000;
		result_correct = 32'hc6d7c559;

		#20 dataa = 32'h43400000;
		datab = 32'h00000000;
		result_correct = 32'hc7098729;

		#20 dataa = 32'h43410000;
		datab = 32'h00000000;
		result_correct = 32'hc70af75c;

		#20 dataa = 32'h43420000;
		datab = 32'h00000000;
		result_correct = 32'hc70c6979;

		#20 dataa = 32'h43430000;
		datab = 32'h00000000;
		result_correct = 32'hc70ddd81;

		#20 dataa = 32'h43440000;
		datab = 32'h00000000;
		result_correct = 32'hc623a2b4;

		#20 dataa = 32'h43450000;
		datab = 32'h00000000;
		result_correct = 32'hc6255142;

		#20 dataa = 32'h43460000;
		datab = 32'h00000000;
		result_correct = 32'hc6270205;

		#20 dataa = 32'h43470000;
		datab = 32'h00000000;
		result_correct = 32'hc628b4fa;

		#20 dataa = 32'h43480000;
		datab = 32'h00000000;
		result_correct = 32'h46cf2156;

		#20 dataa = 32'h43490000;
		datab = 32'h00000000;
		result_correct = 32'h46d133ea;

		#20 dataa = 32'h434a0000;
		datab = 32'h00000000;
		result_correct = 32'h46d34920;

		#20 dataa = 32'h434b0000;
		datab = 32'h00000000;
		result_correct = 32'h46d560fc;

		#20 dataa = 32'h434c0000;
		datab = 32'h00000000;
		result_correct = 32'h47211fee;

		#20 dataa = 32'h434d0000;
		datab = 32'h00000000;
		result_correct = 32'h4722b4d0;

		#20 dataa = 32'h434e0000;
		datab = 32'h00000000;
		result_correct = 32'h47244bac;

		#20 dataa = 32'h434f0000;
		datab = 32'h00000000;
		result_correct = 32'h4725e481;

		#20 dataa = 32'h43500000;
		datab = 32'h00000000;
		result_correct = 32'h468abe87;

		#20 dataa = 32'h43510000;
		datab = 32'h00000000;
		result_correct = 32'h468c13de;

		#20 dataa = 32'h43520000;
		datab = 32'h00000000;
		result_correct = 32'h468d6ad7;

		#20 dataa = 32'h43530000;
		datab = 32'h00000000;
		result_correct = 32'h468ec372;

		#20 dataa = 32'h43540000;
		datab = 32'h00000000;
		result_correct = 32'hc6bf7e49;

		#20 dataa = 32'h43550000;
		datab = 32'h00000000;
		result_correct = 32'hc6c14edb;

		#20 dataa = 32'h43560000;
		datab = 32'h00000000;
		result_correct = 32'hc6c3219e;

		#20 dataa = 32'h43570000;
		datab = 32'h00000000;
		result_correct = 32'hc6c4f692;

		#20 dataa = 32'h43580000;
		datab = 32'h00000000;
		result_correct = 32'hc735d22d;

		#20 dataa = 32'h43590000;
		datab = 32'h00000000;
		result_correct = 32'hc73782a8;

		#20 dataa = 32'h435a0000;
		datab = 32'h00000000;
		result_correct = 32'hc7393524;

		#20 dataa = 32'h435b0000;
		datab = 32'h00000000;
		result_correct = 32'hc73ae99f;

		#20 dataa = 32'h435c0000;
		datab = 32'h00000000;
		result_correct = 32'hc6c89e3d;

		#20 dataa = 32'h435d0000;
		datab = 32'h00000000;
		result_correct = 32'hc6ca7333;

		#20 dataa = 32'h435e0000;
		datab = 32'h00000000;
		result_correct = 32'hc6cc4a49;

		#20 dataa = 32'h435f0000;
		datab = 32'h00000000;
		result_correct = 32'hc6ce2382;

		#20 dataa = 32'h43600000;
		datab = 32'h00000000;
		result_correct = 32'h46a72736;

		#20 dataa = 32'h43610000;
		datab = 32'h00000000;
		result_correct = 32'h46a8a520;

		#20 dataa = 32'h43620000;
		datab = 32'h00000000;
		result_correct = 32'h46aa24bc;

		#20 dataa = 32'h43630000;
		datab = 32'h00000000;
		result_correct = 32'h46aba60a;

		#20 dataa = 32'h43640000;
		datab = 32'h00000000;
		result_correct = 32'h4749b8b0;

		#20 dataa = 32'h43650000;
		datab = 32'h00000000;
		result_correct = 32'h474b7e2b;

		#20 dataa = 32'h43660000;
		datab = 32'h00000000;
		result_correct = 32'h474d45a1;

		#20 dataa = 32'h43670000;
		datab = 32'h00000000;
		result_correct = 32'h474f0f13;

		#20 dataa = 32'h43680000;
		datab = 32'h00000000;
		result_correct = 32'h470877c9;

		#20 dataa = 32'h43690000;
		datab = 32'h00000000;
		result_correct = 32'h4709a51a;

		#20 dataa = 32'h436a0000;
		datab = 32'h00000000;
		result_correct = 32'h470ad3b7;

		#20 dataa = 32'h436b0000;
		datab = 32'h00000000;
		result_correct = 32'h470c039e;

		#20 dataa = 32'h436c0000;
		datab = 32'h00000000;
		result_correct = 32'hc67c63db;

		#20 dataa = 32'h436d0000;
		datab = 32'h00000000;
		result_correct = 32'hc67e8a95;

		#20 dataa = 32'h436e0000;
		datab = 32'h00000000;
		result_correct = 32'hc68059d2;

		#20 dataa = 32'h436f0000;
		datab = 32'h00000000;
		result_correct = 32'hc6816f85;

		#20 dataa = 32'h43700000;
		datab = 32'h00000000;
		result_correct = 32'hc7581e1a;

		#20 dataa = 32'h43710000;
		datab = 32'h00000000;
		result_correct = 32'hc759ec9d;

		#20 dataa = 32'h43720000;
		datab = 32'h00000000;
		result_correct = 32'hc75bbd0d;

		#20 dataa = 32'h43730000;
		datab = 32'h00000000;
		result_correct = 32'hc75d8f6b;

		#20 dataa = 32'h43740000;
		datab = 32'h00000000;
		result_correct = 32'hc72d7e5b;

		#20 dataa = 32'h43750000;
		datab = 32'h00000000;
		result_correct = 32'hc72eeba7;

		#20 dataa = 32'h43760000;
		datab = 32'h00000000;
		result_correct = 32'hc7305a73;

		#20 dataa = 32'h43770000;
		datab = 32'h00000000;
		result_correct = 32'hc731cabe;

		#20 dataa = 32'h43780000;
		datab = 32'h00000000;
		result_correct = 32'h46162c53;

		#20 dataa = 32'h43790000;
		datab = 32'h00000000;
		result_correct = 32'h461760fa;

		#20 dataa = 32'h437a0000;
		datab = 32'h00000000;
		result_correct = 32'h461896dd;

		#20 dataa = 32'h437b0000;
		datab = 32'h00000000;
		result_correct = 32'h4619cdfc;

		#20 dataa = 32'h437c0000;
		datab = 32'h00000000;
		result_correct = 32'h476367cd;

		#20 dataa = 32'h437d0000;
		datab = 32'h00000000;
		result_correct = 32'h4765363e;

		#20 dataa = 32'h437e0000;
		datab = 32'h00000000;
		result_correct = 32'h47670685;
	end

initial
	begin
	$monitor($stime," dataa=%h, datab=%h, result=%h, correct result=%h, sign diff=%d, exp diff=%d, man diff=%d",dataa,datab,
	result,
	result_correct,
	result[31]-result_correct[31],
	(result[30:23]>result_correct[30:23]) ? result[30:23]-result_correct[30:23] : result_correct[30:23]-result[30:23],
	(result[22:0]>result_correct[22:0]) ? result[22:0]-result_correct[22:0] : result_correct[22:0]-result[22:0]
	);
	end

endmodule
