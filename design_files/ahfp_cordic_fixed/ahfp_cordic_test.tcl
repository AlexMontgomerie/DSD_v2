# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_mult/ahfp_mult.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add/ahfp_add.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd4.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd8.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd16.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd32.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd64.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd48.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_sub/ahfp_sub.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_sub/ahfp_add_sub.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic_fixed/ahfp_cordic_fixed.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic_fixed/ahfp_cordic_fixed_tb.v

# simulate design
vsim -c work.test_ahfp_cordic_fixed

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/x

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/y

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/x_a

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/y_a

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/x_b

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/y_b

add wave -position insertpoint  \
{sim:/test_ahfp_cordic/dut/loop_generation[0]/add_sub_x/result}

add wave -position insertpoint  \
{sim:/test_ahfp_cordic/dut/loop_generation[0]/add_sub_y/result}

add wave -position insertpoint  \
{sim:/test_ahfp_cordic/dut/loop_generation[0]/add_sub_x/dataa}

add wave -position insertpoint  \
{sim:/test_ahfp_cordic/dut/loop_generation[0]/add_sub_x/datab}

add wave -position insertpoint  \
{sim:/test_ahfp_cordic/dut/loop_generation[0]/add_sub_y/dataa}

add wave -position insertpoint  \
{sim:/test_ahfp_cordic/dut/loop_generation[0]/add_sub_y/datab}


#run simulation
run 1000
