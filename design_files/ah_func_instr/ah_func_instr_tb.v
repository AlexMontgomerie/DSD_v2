// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ah_func_instr;

reg clk;
reg [31:0] dataa,datab,result_correct;
wire [31:0] result;
wire reset,clk_en;

ah_func_instr dut (	
		.clk(clk),
		.dataa(dataa),
		.datab(datab),
		.result(result),
		.clk_en(clk_en),
		.reset(reset));

initial // Clock generator
  begin
    clk = 1;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
                 dataa <=#0 32'h0;
                datab <=#0 32'h0;
                result_correct <=#1280 32'h0;

                dataa <=#20 32'h3f800000;
                datab <=#20 32'h0;
                result_correct <=#1300 32'h3faac7d5;

                dataa <=#40 32'h40000000;
                datab <=#40 32'h3faac7d5;
                result_correct <=#1320 32'h40b579ca;

                dataa <=#60 32'h40400000;
                datab <=#60 32'h40b579ca;
                result_correct <=#1340 32'h416addb4;

                dataa <=#80 32'h40800000;
                datab <=#80 32'h416addb4;
                result_correct <=#1360 32'h41fa8521;

                dataa <=#100 32'h40a00000;
                datab <=#100 32'h41fa8521;
                result_correct <=#1380 32'h4262bbf8;

                dataa <=#120 32'h40c00000;
                datab <=#120 32'h4262bbf8;
                result_correct <=#1400 32'h42b93a84;

                dataa <=#140 32'h40e00000;
                datab <=#140 32'h42b93a84;
                result_correct <=#1420 32'h430cefc9;

                dataa <=#160 32'h41000000;
                datab <=#160 32'h430cefc9;
                result_correct <=#1440 32'h431acf0a;

                dataa <=#180 32'h41100000;
                datab <=#180 32'h431acf0a;
                result_correct <=#1460 32'h432bcd99;

                dataa <=#200 32'h41200000;
                datab <=#200 32'h432bcd99;
                result_correct <=#1480 32'h43403a6f;

                dataa <=#220 32'h41300000;
                datab <=#220 32'h43403a6f;
                result_correct <=#1500 32'h43586487;

                dataa <=#240 32'h41400000;
                datab <=#240 32'h43586487;
                result_correct <=#1520 32'h42e55845;

                dataa <=#260 32'h41500000;
                datab <=#260 32'h42e55845;
                result_correct <=#1540 32'hc0a7fa70;

                dataa <=#280 32'h41600000;
                datab <=#280 32'hc0a7fa70;
                result_correct <=#1560 32'hc310de5c;

                dataa <=#300 32'h41700000;
                datab <=#300 32'hc310de5c;
                result_correct <=#1580 32'hc398d73d;

                dataa <=#320 32'h41800000;
                datab <=#320 32'hc398d73d;
                result_correct <=#1600 32'hc40806f4;

                dataa <=#340 32'h41880000;
                datab <=#340 32'hc40806f4;
                result_correct <=#1620 32'hc44b7350;

                dataa <=#360 32'h41900000;
                datab <=#360 32'hc44b7350;
                result_correct <=#1640 32'hc48b95f4;

                dataa <=#380 32'h41980000;
                datab <=#380 32'hc48b95f4;
                result_correct <=#1660 32'hc4b5d5fa;

                dataa <=#400 32'h41a00000;
                datab <=#400 32'hc4b5d5fa;
                result_correct <=#1680 32'hc4c3315a;

                dataa <=#420 32'h41a80000;
                datab <=#420 32'hc4c3315a;
                result_correct <=#1700 32'hc4d1fc04;

                dataa <=#440 32'h41b00000;
                datab <=#440 32'hc4d1fc04;
                result_correct <=#1720 32'hc4e248a9;

                dataa <=#460 32'h41b80000;
                datab <=#460 32'hc4e248a9;
                result_correct <=#1740 32'hc4f429fc;

                dataa <=#480 32'h41c00000;
                datab <=#480 32'hc4f429fc;
                result_correct <=#1760 32'hc4c415f8;

                dataa <=#500 32'h41c80000;
                datab <=#500 32'hc4c415f8;
                result_correct <=#1780 32'hc48ffb95;

                dataa <=#520 32'h41d00000;
                datab <=#520 32'hc48ffb95;
                result_correct <=#1800 32'hc42f62d9;

                dataa <=#540 32'h41d80000;
                datab <=#540 32'hc42f62d9;
                result_correct <=#1820 32'hc35870b8;

                dataa <=#560 32'h41e00000;
                datab <=#560 32'hc35870b8;
                result_correct <=#1840 32'h440faa6a;

                dataa <=#580 32'h41e80000;
                datab <=#580 32'h440faa6a;
                result_correct <=#1860 32'h44b1d875;

                dataa <=#600 32'h41f00000;
                datab <=#600 32'h44b1d875;
                result_correct <=#1880 32'h45119d8d;

                dataa <=#620 32'h41f80000;
                datab <=#620 32'h45119d8d;
                result_correct <=#1900 32'h454e1e49;

                dataa <=#640 32'h42000000;
                datab <=#640 32'h454e1e49;
                result_correct <=#1920 32'h456a4409;

                dataa <=#660 32'h42040000;
                datab <=#660 32'h456a4409;
                result_correct <=#1940 32'h45841577;

                dataa <=#680 32'h42080000;
                datab <=#680 32'h45841577;
                result_correct <=#1960 32'h4593f046;

                dataa <=#700 32'h420c0000;
                datab <=#700 32'h4593f046;
                result_correct <=#1980 32'h45a4b93a;

                dataa <=#720 32'h42100000;
                datab <=#720 32'h45a4b93a;
                result_correct <=#2000 32'h458fb4d0;

                dataa <=#740 32'h42140000;
                datab <=#740 32'h458fb4d0;
                result_correct <=#2020 32'h4572fa73;

                dataa <=#760 32'h42180000;
                datab <=#760 32'h4572fa73;
                result_correct <=#2040 32'h454413e0;

                dataa <=#780 32'h421c0000;
                datab <=#780 32'h454413e0;
                result_correct <=#2060 32'h4512a4da;

                dataa <=#800 32'h42200000;
                datab <=#800 32'h4512a4da;
                result_correct <=#2080 32'h443f976b;

                dataa <=#820 32'h42240000;
                datab <=#820 32'h443f976b;
                result_correct <=#2100 32'hc45f845e;

                dataa <=#840 32'h42280000;
                datab <=#840 32'hc45f845e;
                result_correct <=#2120 32'hc524cffc;

                dataa <=#860 32'h422c0000;
                datab <=#860 32'hc524cffc;
                result_correct <=#2140 32'hc58b836a;

                dataa <=#880 32'h42300000;
                datab <=#880 32'hc58b836a;
                result_correct <=#2160 32'hc5abf6a5;

                dataa <=#900 32'h42340000;
                datab <=#900 32'hc5abf6a5;
                result_correct <=#2180 32'hc5cdebdc;

                dataa <=#920 32'h42380000;
                datab <=#920 32'hc5cdebdc;
                result_correct <=#2200 32'hc5f16bd2;

                dataa <=#940 32'h423c0000;
                datab <=#940 32'hc5f16bd2;
                result_correct <=#2220 32'hc60b3fa5;

                dataa <=#960 32'h42400000;
                datab <=#960 32'hc60b3fa5;
                result_correct <=#2240 32'hc5f85d85;

                dataa <=#980 32'h42440000;
                datab <=#980 32'hc5f85d85;
                result_correct <=#2260 32'hc5d8fb14;

                dataa <=#1000 32'h42480000;
                datab <=#1000 32'hc5d8fb14;
                result_correct <=#2280 32'hc5b85170;

                dataa <=#1020 32'h424c0000;
                datab <=#1020 32'hc5b85170;
                result_correct <=#2300 32'hc5965a11;

                dataa <=#1040 32'h42500000;
                datab <=#1040 32'hc5965a11;
                result_correct <=#2320 32'hc503fcd1;

                dataa <=#1060 32'h42540000;
                datab <=#1060 32'hc503fcd1;
                result_correct <=#2340 32'h442cfe19;

                dataa <=#1080 32'h42580000;
                datab <=#1080 32'h442cfe19;
                result_correct <=#2360 32'h45612087;

                dataa <=#1100 32'h425c0000;
                datab <=#1100 32'h45612087;
                result_correct <=#2380 32'h45cee2ea;

                dataa <=#1120 32'h42600000;
                datab <=#1120 32'h45cee2ea;
                result_correct <=#2400 32'h46083c78;

                dataa <=#1140 32'h42640000;
                datab <=#1140 32'h46083c78;
                result_correct <=#2420 32'h462a33f2;

                dataa <=#1160 32'h42680000;
                datab <=#1160 32'h462a33f2;
                result_correct <=#2440 32'h464d5d2b;

                dataa <=#1180 32'h426c0000;
                datab <=#1180 32'h464d5d2b;
                result_correct <=#2460 32'h4671bd6b;

                dataa <=#1200 32'h42700000;
                datab <=#1200 32'h4671bd6b;
                result_correct <=#2480 32'h4662bb11;

                dataa <=#1220 32'h42740000;
                datab <=#1220 32'h4662bb11;
                result_correct <=#2500 32'h46533589;

                dataa <=#1240 32'h42780000;
                datab <=#1240 32'h46533589;
                result_correct <=#2520 32'h46432aa0;

                dataa <=#1260 32'h427c0000;
                datab <=#1260 32'h46432aa0;
                result_correct <=#2540 32'h46329822;

                dataa <=#1280 32'h42800000;
                datab <=#1280 32'h46329822;
                result_correct <=#2560 32'h45eb9bae;

                dataa <=#1300 32'h42820000;
                datab <=#1300 32'h45eb9bae;
                result_correct <=#2580 32'h455c5d94;

                dataa <=#1320 32'h42840000;
                datab <=#1320 32'h455c5d94;
                result_correct <=#2600 32'hc4192dd4;

                dataa <=#1340 32'h42860000;
                datab <=#1340 32'hc4192dd4;
                result_correct <=#2620 32'hc5987132;

                dataa <=#1360 32'h42880000;
                datab <=#1360 32'hc5987132;
                result_correct <=#2640 32'hc60293c9;

                dataa <=#1380 32'h428a0000;
                datab <=#1380 32'hc60293c9;
                result_correct <=#2660 32'hc63a8d48;

                dataa <=#1400 32'h428c0000;
                datab <=#1400 32'hc63a8d48;
                result_correct <=#2680 32'hc6742b2a;

                dataa <=#1420 32'h428e0000;
                datab <=#1420 32'hc6742b2a;
                result_correct <=#2700 32'hc697b9c1;

                dataa <=#1440 32'h42900000;
                datab <=#1440 32'hc697b9c1;
                result_correct <=#2720 32'hc691e810;

                dataa <=#1460 32'h42920000;
                datab <=#1460 32'hc691e810;
                result_correct <=#2740 32'hc68bedb8;

                dataa <=#1480 32'h42940000;
                datab <=#1480 32'hc68bedb8;
                result_correct <=#2760 32'hc685ca2c;

                dataa <=#1500 32'h42960000;
                datab <=#1500 32'hc685ca2c;
                result_correct <=#2780 32'hc67ef9c2;

                dataa <=#1520 32'h42980000;
                datab <=#1520 32'hc67ef9c2;
                result_correct <=#2800 32'hc62c7c1b;

                dataa <=#1540 32'h429a0000;
                datab <=#1540 32'hc62c7c1b;
                result_correct <=#2820 32'hc5afa232;

                dataa <=#1560 32'h429c0000;
                datab <=#1560 32'hc5afa232;
                result_correct <=#2840 32'hc2717908;

                dataa <=#1580 32'h429e0000;
                datab <=#1580 32'hc2717908;
                result_correct <=#2860 32'h45b0540f;

                dataa <=#1600 32'h42a00000;
                datab <=#1600 32'h45b0540f;
                result_correct <=#2880 32'h462d2cb1;

                dataa <=#1620 32'h42a20000;
                datab <=#1620 32'h462d2cb1;
                result_correct <=#2900 32'h46822866;

                dataa <=#1640 32'h42a40000;
                datab <=#1640 32'h46822866;
                result_correct <=#2920 32'h46aece8c;

                dataa <=#1660 32'h42a60000;
                datab <=#1660 32'h46aece8c;
                result_correct <=#2940 32'h46dc8c2b;

                dataa <=#1680 32'h42a80000;
                datab <=#1680 32'h46dc8c2b;
                result_correct <=#2960 32'h46dd1ea0;

                dataa <=#1700 32'h42aa0000;
                datab <=#1700 32'h46dd1ea0;
                result_correct <=#2980 32'h46ddb394;

                dataa <=#1720 32'h42ac0000;
                datab <=#1720 32'h46ddb394;
                result_correct <=#3000 32'h46de4b0b;

                dataa <=#1740 32'h42ae0000;
                datab <=#1740 32'h46de4b0b;
                result_correct <=#3020 32'h46dee50a;

                dataa <=#1760 32'h42b00000;
                datab <=#1760 32'h46dee50a;
                result_correct <=#3040 32'h46ac7980;

                dataa <=#1780 32'h42b20000;
                datab <=#1780 32'h46ac7980;
                result_correct <=#3060 32'h4671cbdc;

                dataa <=#1800 32'h42b40000;
                datab <=#1800 32'h4671cbdc;
                result_correct <=#3080 32'h46084df1;

                dataa <=#1820 32'h42b60000;
                datab <=#1820 32'h46084df1;
                result_correct <=#3100 32'h44e3944a;

                dataa <=#1840 32'h42b80000;
                datab <=#1840 32'h44e3944a;
                result_correct <=#3120 32'hc5b6a961;

                dataa <=#1860 32'h42ba0000;
                datab <=#1860 32'hc5b6a961;
                result_correct <=#3140 32'hc655bc27;

                dataa <=#1880 32'h42bc0000;
                datab <=#1880 32'hc655bc27;
                result_correct <=#3160 32'hc6a96592;

                dataa <=#1900 32'h42be0000;
                datab <=#1900 32'hc6a96592;
                result_correct <=#3180 32'hc6e94479;

                dataa <=#1920 32'h42c00000;
                datab <=#1920 32'hc6e94479;
                result_correct <=#3200 32'hc6f35e54;

                dataa <=#1940 32'h42c20000;
                datab <=#1940 32'hc6f35e54;
                result_correct <=#3220 32'hc6fdaf59;

                dataa <=#1960 32'h42c40000;
                datab <=#1960 32'hc6fdaf59;
                result_correct <=#3240 32'hc7041c0e;

                dataa <=#1980 32'h42c60000;
                datab <=#1980 32'hc7041c0e;
                result_correct <=#3260 32'hc7097c9a;

                dataa <=#2000 32'h42c80000;
                datab <=#2000 32'hc7097c9a;
                result_correct <=#3280 32'hc6d7af28;

                dataa <=#2020 32'h42ca0000;
                datab <=#2020 32'hc6d7af28;
                result_correct <=#3300 32'hc69b350b;

                dataa <=#2040 32'h42cc0000;
                datab <=#2040 32'hc69b350b;
                result_correct <=#3320 32'hc63b0fb1;

                dataa <=#2060 32'h42ce0000;
                datab <=#2060 32'hc63b0fb1;
                result_correct <=#3340 32'hc5752462;


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
