# make work directory
vlib work
vmap work work

# compile design

vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add/ahfp_add.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_sub/ahfp_sub.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_sub/ahfp_add_sub.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic/ahfp_cordic.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_cordic/ahfp_cordic_tb.v

# simulate design
vsim -c work.test_ahfp_cordic

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/a_tmp

add wave -position insertpoint  \
sim:/test_ahfp_cordic/dut/x

#run simulation
run 1000
