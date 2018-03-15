# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_sub_multi/ahfp_sub_multi.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_multi/ahfp_add_multi.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_sub_multi/ahfp_add_sub_multi.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_sub_multi/ahfp_add_sub_multi_tb.v

# simulate design
vsim -c work.test_ahfp_add_sub_multi

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *


add wave -position insertpoint  \
sim:/test_ahfp_add_sub_multi/dut/sub_res
add wave -position insertpoint  \
sim:/test_ahfp_add_sub_multi/dut/add_res
add wave -position insertpoint  \
sim:/test_ahfp_add_sub_multi/dut/out_mux
add wave -position insertpoint  \
sim:/test_ahfp_add_sub_multi/dut/out_mux_buf

#run simulation
run 500
