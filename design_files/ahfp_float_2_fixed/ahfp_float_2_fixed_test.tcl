# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_float_2_fixed/ahfp_float_2_fixed.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_float_2_fixed/ahfp_float_2_fixed_tb.v

# simulate design
vsim -c work.test_ahfp_float_2_fixed

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

#run simulation
run 500
