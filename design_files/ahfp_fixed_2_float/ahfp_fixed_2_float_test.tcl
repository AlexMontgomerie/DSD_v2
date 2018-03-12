# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_fixed_2_float/ahfp_fixed_2_float.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_fixed_2_float/ahfp_fixed_2_float_tb.v

# simulate design
vsim -c work.test_ahfp_fixed_2_float

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_fixed_2_float/dut/shift

add wave -position insertpoint  \
sim:/test_ahfp_fixed_2_float/dut/fixed_tmp

#run simulation
run 500
