vlib work

vmap work work

vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic_fixed/ahfp_cordic_fixed.v

vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic_fixed/ahfp_cordic_fixed_tb.v


# simulate design
vsim -c work.test_ahfp_cordic_fixed

view transcript
view wave -undock

#add all waves to wave view
add wave *


add wave -position insertpoint  \
sim:/test_ahfp_cordic_fixed/dut/theta

add wave -position insertpoint  \
sim:/test_ahfp_cordic_fixed/dut/x_cos

add wave -position insertpoint  \
{sim:/test_ahfp_cordic_fixed/dut/x}

add wave -position insertpoint  \
{sim:/test_ahfp_cordic_fixed/dut/y}

add wave -position insertpoint  \
{sim:/test_ahfp_cordic_fixed/dut/z}

#run simulation
run 1000