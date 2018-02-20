#start simulation
vsim

# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_mult.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_mult_tb.v

# simulate design
vsim -c work.ahfp_mult
vsim -c work.test_ahfp_mult

#window views
#view objects
#view locals
#view source
#view transcript
#view wave -undock

#add all waves to wave view
#add wave *

#run simulation
run 500
