// Test bench for fp multiplier
// testbench reference: https://people.ece.cornell.edu/land/courses/ece5760/Verilog/LatticeTestbenchPrimer.pdf

`timescale 1ns / 1ns
module test_ahfp_cordic;

reg clk;
reg [31:0] 		x_start,
				y_start,
				theta,
				x_cos_correct;

wire [31:0] 	x_cos;

ahfp_cordic_fixed dut (.clk(clk),
				.x_start(x_start),
				.y_start(y_start),
				.theta(theta),
				.x_cos(x_cos),
				);

initial // Clock generator
  begin
    clk = 1;
    forever #10 clk = !clk;
  end
  
// test cases
initial
	begin
		x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h40000000
		x_cos_correct <= 32'h20000000

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h64ecda
		x_cos_correct <= 32'h1fff60e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hc9d9b4
		x_cos_correct <= 32'h1ffd8360

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h12ec68e
		x_cos_correct <= 32'h1ffa67c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h193b368
		x_cos_correct <= 32'h1ff60e00

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1f8a042
		x_cos_correct <= 32'h1ff07660

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h25d8d1c
		x_cos_correct <= 32'h1fe9a100

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2c279f8
		x_cos_correct <= 32'h1fe18e40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h32766d0
		x_cos_correct <= 32'h1fd83e60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h38c53ac
		x_cos_correct <= 32'h1fcdb1a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3f14084
		x_cos_correct <= 32'h1fc1e8a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4562d60
		x_cos_correct <= 32'h1fb4e3c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4bb1a38
		x_cos_correct <= 32'h1fa6a380

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5200718
		x_cos_correct <= 32'h1f972840

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h584f3f0
		x_cos_correct <= 32'h1f867300

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5e9e0c8
		x_cos_correct <= 32'h1f748400

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h64ecda0
		x_cos_correct <= 32'h1f615c20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h6b3ba80
		x_cos_correct <= 32'h1f4cfc40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h718a758
		x_cos_correct <= 32'h1f3764e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h77d9430
		x_cos_correct <= 32'h1f209700

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h7e28108
		x_cos_correct <= 32'h1f0893a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h8476de0
		x_cos_correct <= 32'h1eef5b80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h8ac5ac0
		x_cos_correct <= 32'h1ed4efa0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h91147a0
		x_cos_correct <= 32'h1eb95100

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h9763470
		x_cos_correct <= 32'h1e9c80e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h9db2150
		x_cos_correct <= 32'h1e7e8040

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'ha400e30
		x_cos_correct <= 32'h1e5f5040

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'haa4fb00
		x_cos_correct <= 32'h1e3ef220

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hb09e7e0
		x_cos_correct <= 32'h1e1d6740

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hb6ed4b0
		x_cos_correct <= 32'h1dfab0c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hbd3c190
		x_cos_correct <= 32'h1dd6d000

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hc38ae70
		x_cos_correct <= 32'h1db1c680

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hc9d9b40
		x_cos_correct <= 32'h1d8b95a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hd028820
		x_cos_correct <= 32'h1d643ee0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hd677500
		x_cos_correct <= 32'h1d3bc3a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hdcc61d0
		x_cos_correct <= 32'h1d1225c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'he314eb0
		x_cos_correct <= 32'h1ce766a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'he963b90
		x_cos_correct <= 32'h1cbb8800

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hefb2860
		x_cos_correct <= 32'h1c8e8ba0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hf601540
		x_cos_correct <= 32'h1c607340

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'hfc50210
		x_cos_correct <= 32'h1c314080

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1029ef00
		x_cos_correct <= 32'h1c00f540

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h108edbc0
		x_cos_correct <= 32'h1bcf93a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h10f3c8a0
		x_cos_correct <= 32'h1b9d1d40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1158b580
		x_cos_correct <= 32'h1b699440

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h11bda260
		x_cos_correct <= 32'h1b34fa80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h12228f40
		x_cos_correct <= 32'h1aff5240

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h12877c00
		x_cos_correct <= 32'h1ac89d60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h12ec68e0
		x_cos_correct <= 32'h1a90de20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h135155c0
		x_cos_correct <= 32'h1a5816a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h13b642a0
		x_cos_correct <= 32'h1a1e4900

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h141b2f80
		x_cos_correct <= 32'h19e377a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h14801c60
		x_cos_correct <= 32'h19a7a4a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h14e50920
		x_cos_correct <= 32'h196ad2a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1549f600
		x_cos_correct <= 32'h192d03c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h15aee2e0
		x_cos_correct <= 32'h18ee3a60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1613cfc0
		x_cos_correct <= 32'h18ae7900

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1678bca0
		x_cos_correct <= 32'h186dc240

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h16dda960
		x_cos_correct <= 32'h182c1880

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h17429640
		x_cos_correct <= 32'h17e97e20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h17a78320
		x_cos_correct <= 32'h17a5f600

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h180c7000
		x_cos_correct <= 32'h176182a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h18715ce0
		x_cos_correct <= 32'h171c26c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h18d649c0
		x_cos_correct <= 32'h16d5e4e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h193b3680
		x_cos_correct <= 32'h168ec000

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h19a02360
		x_cos_correct <= 32'h1646bac0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1a051040
		x_cos_correct <= 32'h15fdd7c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1a69fd20
		x_cos_correct <= 32'h15b41a20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1aceea00
		x_cos_correct <= 32'h15698480

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1b33d6c0
		x_cos_correct <= 32'h151e1a20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1b98c3a0
		x_cos_correct <= 32'h14d1dd80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1bfdb080
		x_cos_correct <= 32'h1484d1c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1c629d60
		x_cos_correct <= 32'h1436fa00

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1cc78a40
		x_cos_correct <= 32'h13e85920

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1d2c7720
		x_cos_correct <= 32'h1398f240

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1d9163e0
		x_cos_correct <= 32'h1348c880

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1df650c0
		x_cos_correct <= 32'h12f7dec0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1e5b3da0
		x_cos_correct <= 32'h12a63880

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1ec02a80
		x_cos_correct <= 32'h1253d8a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1f251760
		x_cos_correct <= 32'h1200c280

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1f8a0420
		x_cos_correct <= 32'h11acf960

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h1feef100
		x_cos_correct <= 32'h11588040

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2053de00
		x_cos_correct <= 32'h11035aa0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h20b8cac0
		x_cos_correct <= 32'h10ad8be0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h211db780
		x_cos_correct <= 32'h10571740

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2182a480
		x_cos_correct <= 32'hffffff0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h21e79140
		x_cos_correct <= 32'hfa849a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h224c7e40
		x_cos_correct <= 32'hf4ff760

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h22b16b00
		x_cos_correct <= 32'hef70d10

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h231657c0
		x_cos_correct <= 32'he9d8de0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h237b44c0
		x_cos_correct <= 32'he437d10

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h23e03180
		x_cos_correct <= 32'hde8de90

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h24451e80
		x_cos_correct <= 32'hd8db580

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h24aa0b40
		x_cos_correct <= 32'hd3205e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h250ef800
		x_cos_correct <= 32'hcd5d300

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2573e500
		x_cos_correct <= 32'hc792030

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h25d8d1c0
		x_cos_correct <= 32'hc1bf190

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h263dbec0
		x_cos_correct <= 32'hbbe4a40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h26a2ab80
		x_cos_correct <= 32'hb602e50

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h27079840
		x_cos_correct <= 32'hb01a140

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h276c8540
		x_cos_correct <= 32'haa2a680

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h27d17200
		x_cos_correct <= 32'ha434230

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h28365f00
		x_cos_correct <= 32'h9e37790

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h289b4bc0
		x_cos_correct <= 32'h9834ac0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h290038c0
		x_cos_correct <= 32'h922bf20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h29652580
		x_cos_correct <= 32'h8c1d8e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h29ca1240
		x_cos_correct <= 32'h8609b80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2a2eff40
		x_cos_correct <= 32'h7ff0a90

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2a93ec00
		x_cos_correct <= 32'h79d2a50

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2af8d900
		x_cos_correct <= 32'h73afe18

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2b5dc5c0
		x_cos_correct <= 32'h6d88a30

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2bc2b280
		x_cos_correct <= 32'h675d230

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2c279f80
		x_cos_correct <= 32'h612d9b0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2c8c8c40
		x_cos_correct <= 32'h5afa508

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2cf17940
		x_cos_correct <= 32'h54c3790

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2d566600
		x_cos_correct <= 32'h4e895a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2dbb52c0
		x_cos_correct <= 32'h484c2e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2e203fc0
		x_cos_correct <= 32'h420c2f0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2e852c80
		x_cos_correct <= 32'h3bc9a2c

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2eea1980
		x_cos_correct <= 32'h3584bfc

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2f4f0640
		x_cos_correct <= 32'h2f3dccc

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h2fb3f300
		x_cos_correct <= 32'h28f5038

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3018e000
		x_cos_correct <= 32'h22aa9f0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h307dccc0
		x_cos_correct <= 32'h1c5ee5c

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h30e2b9c0
		x_cos_correct <= 32'h16120e4

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3147a680
		x_cos_correct <= 32'hfc45f2

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h31ac9380
		x_cos_correct <= 32'h9760f4

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h32118040
		x_cos_correct <= 32'h327653

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h32766d00
		x_cos_correct <= 32'hffcd89be

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h32db5a00
		x_cos_correct <= 32'hff689edd

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h334046c0
		x_cos_correct <= 32'hff03ba1f

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h33a533c0
		x_cos_correct <= 32'hfe9edeee

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h340a2080
		x_cos_correct <= 32'hfe3a11b6

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h346f0d40
		x_cos_correct <= 32'hfdd55620

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h34d3fa40
		x_cos_correct <= 32'hfd70afd8

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3538e700
		x_cos_correct <= 32'hfd0c2348

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h359dd400
		x_cos_correct <= 32'hfca7b3d4

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3602c0c0
		x_cos_correct <= 32'hfc4365e8

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3667ad80
		x_cos_correct <= 32'hfbdf3d28

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h36cc9a80
		x_cos_correct <= 32'hfb7b3d30

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h37318740
		x_cos_correct <= 32'hfb176a70

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h37967440
		x_cos_correct <= 32'hfab3c848

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h37fb6100
		x_cos_correct <= 32'hfa505b08

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h38604dc0
		x_cos_correct <= 32'hf9ed2660

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h38c53ac0
		x_cos_correct <= 32'hf98a2de0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h392a2780
		x_cos_correct <= 32'hf92775e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h398f1480
		x_cos_correct <= 32'hf8c501b8

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h39f40140
		x_cos_correct <= 32'hf862d5c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3a58ee40
		x_cos_correct <= 32'hf800f548

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3abddb00
		x_cos_correct <= 32'hf79f6490

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3b22c7c0
		x_cos_correct <= 32'hf73e2730

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3b87b4c0
		x_cos_correct <= 32'hf6dd40b0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3beca180
		x_cos_correct <= 32'hf67cb550

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3c518e80
		x_cos_correct <= 32'hf61c8850

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3cb67b40
		x_cos_correct <= 32'hf5bcbde0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3d1b6800
		x_cos_correct <= 32'hf55d5990

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3d805500
		x_cos_correct <= 32'hf4fe5ed0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3de541c0
		x_cos_correct <= 32'hf49fd1c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3e4a2ec0
		x_cos_correct <= 32'hf441b5a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3eaf1b80
		x_cos_correct <= 32'hf3e40e80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3f140840
		x_cos_correct <= 32'hf386dfe0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3f78f540
		x_cos_correct <= 32'hf32a2d10

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h3fdde200
		x_cos_correct <= 32'hf2cdfa30

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4042cf00
		x_cos_correct <= 32'hf2724a50

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h40a7bc00
		x_cos_correct <= 32'hf2172140

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h410ca880
		x_cos_correct <= 32'hf1bc8300

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h41719580
		x_cos_correct <= 32'hf1627230

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h41d68280
		x_cos_correct <= 32'hf108f2d0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h423b6f00
		x_cos_correct <= 32'hf0b008b0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h42a05c00
		x_cos_correct <= 32'hf057b660

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h43054900
		x_cos_correct <= 32'hefffffe0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h436a3580
		x_cos_correct <= 32'hefa8e900

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h43cf2280
		x_cos_correct <= 32'hef527420

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h44340f80
		x_cos_correct <= 32'heefca540

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4498fc80
		x_cos_correct <= 32'heea77f80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h44fde900
		x_cos_correct <= 32'hee5306c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4562d600
		x_cos_correct <= 32'hedff3d80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h45c7c300
		x_cos_correct <= 32'hedac2740

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h462caf80
		x_cos_correct <= 32'hed59c7c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h46919c80
		x_cos_correct <= 32'hed082140

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h46f68980
		x_cos_correct <= 32'hecb73780

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h475b7680
		x_cos_correct <= 32'hec670d80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h47c06300
		x_cos_correct <= 32'hec17a700

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h48255000
		x_cos_correct <= 32'hebc90600

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h488a3d00
		x_cos_correct <= 32'heb7b2e20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h48ef2980
		x_cos_correct <= 32'heb2e22a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h49541680
		x_cos_correct <= 32'heae1e600

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h49b90380
		x_cos_correct <= 32'hea967b40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4a1df000
		x_cos_correct <= 32'hea4be600

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4a82dd00
		x_cos_correct <= 32'hea022840

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4ae7ca00
		x_cos_correct <= 32'he9b94540

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4b4cb700
		x_cos_correct <= 32'he9713fe0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4bb1a380
		x_cos_correct <= 32'he92a1b20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4c169080
		x_cos_correct <= 32'he8e3d940

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4c7b7d80
		x_cos_correct <= 32'he89e7d40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4ce06a00
		x_cos_correct <= 32'he85a0a20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4d455700
		x_cos_correct <= 32'he81681e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4daa4400
		x_cos_correct <= 32'he7d3e780

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4e0f3080
		x_cos_correct <= 32'he7923de0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4e741d80
		x_cos_correct <= 32'he7518700

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4ed90a80
		x_cos_correct <= 32'he711c5a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4f3df780
		x_cos_correct <= 32'he6d2fc20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h4fa2e400
		x_cos_correct <= 32'he6952d80

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5007d100
		x_cos_correct <= 32'he6585b40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h506cbe00
		x_cos_correct <= 32'he61c8840

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h50d1aa80
		x_cos_correct <= 32'he5e1b720

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h51369780
		x_cos_correct <= 32'he5a7e980

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h519b8480
		x_cos_correct <= 32'he56f21e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h52007180
		x_cos_correct <= 32'he5376280

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h52655e00
		x_cos_correct <= 32'he500ade0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h52ca4b00
		x_cos_correct <= 32'he4cb0560

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h532f3800
		x_cos_correct <= 32'he4966ba0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h53942480
		x_cos_correct <= 32'he462e2c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h53f91180
		x_cos_correct <= 32'he4306c60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h545dfe80
		x_cos_correct <= 32'he3ff0aa0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h54c2eb00
		x_cos_correct <= 32'he3cebfa0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5527d800
		x_cos_correct <= 32'he39f8ce0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h558cc500
		x_cos_correct <= 32'he3717440

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h55f1b200
		x_cos_correct <= 32'he34477e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h56569e80
		x_cos_correct <= 32'he3189960

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h56bb8b80
		x_cos_correct <= 32'he2edda40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h57207880
		x_cos_correct <= 32'he2c43c40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h57856500
		x_cos_correct <= 32'he29bc140

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h57ea5200
		x_cos_correct <= 32'he2746a60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h584f3f00
		x_cos_correct <= 32'he24e3980

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h58b42b80
		x_cos_correct <= 32'he2293020

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h59191880
		x_cos_correct <= 32'he2054f60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h597e0580
		x_cos_correct <= 32'he1e298c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h59e2f280
		x_cos_correct <= 32'he1c10dc0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5a47df00
		x_cos_correct <= 32'he1a0afc0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5aaccc00
		x_cos_correct <= 32'he1817fc0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5b11b900
		x_cos_correct <= 32'he1637f20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5b76a580
		x_cos_correct <= 32'he146af00

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5bdb9280
		x_cos_correct <= 32'he12b1080

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5c407f80
		x_cos_correct <= 32'he110a480

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5ca56c80
		x_cos_correct <= 32'he0f76c60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5d0a5900
		x_cos_correct <= 32'he0df6900

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5d6f4600
		x_cos_correct <= 32'he0c89b20

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5dd43300
		x_cos_correct <= 32'he0b303c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5e391f80
		x_cos_correct <= 32'he09ea3e0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5e9e0c80
		x_cos_correct <= 32'he08b7c00

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5f02f980
		x_cos_correct <= 32'he0798d00

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5f67e600
		x_cos_correct <= 32'he068d7c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h5fccd300
		x_cos_correct <= 32'he0595ca0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h6031c000
		x_cos_correct <= 32'he04b1c40

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h6096ad00
		x_cos_correct <= 32'he03e1760

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h60fb9980
		x_cos_correct <= 32'he0324e60

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h61608680
		x_cos_correct <= 32'he027c1a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h61c57380
		x_cos_correct <= 32'he01e71c0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h622a6000
		x_cos_correct <= 32'he0165f00

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h628f4d00
		x_cos_correct <= 32'he00f89a0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h62f43a00
		x_cos_correct <= 32'he009f200

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h63592700
		x_cos_correct <= 32'he0059840

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h63be1380
		x_cos_correct <= 32'he0027ca0

		#20 x_start <= 32'h20000000
		y_start <= 32'h00000000
		theta <= 32'h64230080
		x_cos_correct <= 32'he0009f20

	end

initial
	begin
	$monitor($stime," x_start=%h, y_start=%h, theta=%h, x_cos=%h, y_sin=%h, x_cos_correct=%h, y_sin_correct=%h, x diff=%d, y diff=%d",
	x_start,
	y_start,
	theta,
	x_cos,
	y_sin,
	x_cos_correct,
	y_sin_correct,
	$signed(x_cos_correct - x_cos),
	$signed(y_sin_correct - y_sin)
	);
	end

endmodule
