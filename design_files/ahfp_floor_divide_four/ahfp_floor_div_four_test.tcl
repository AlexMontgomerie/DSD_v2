# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_floor_divide_four.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_floor_divide_four_tb.v

# simulate design
vsim -c work.floor_div_four
vsim -c work.test_floor_div_four

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