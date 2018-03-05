# make work directory
vlib work
vmap work work

# compile design

vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_sub.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_sub.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic_tb.v

# simulate design
vsim -c work.ahfp_cordic
vsim -c work.test_ahfp_cordic

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
