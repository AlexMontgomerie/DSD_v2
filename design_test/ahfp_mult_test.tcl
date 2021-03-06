# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/design_files/ahfp_mult.v
vlog -reportprogress 300 -work work C:/Users/Alex/design_files/tahfp_mult.v

# simulate design
vsim work.ahfp_mult

#window views
view objects
view locals
view source
view wave -undock
add wave *

#run simulation
run 500


