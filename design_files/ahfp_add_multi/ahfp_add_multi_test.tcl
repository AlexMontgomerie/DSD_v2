# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_multi/ahfp_add_multi.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add_multi/ahfp_add_multi_tb.v

# simulate design
vsim -c work.ahfp_add_multi
vsim -c work.test_ahfp_add_multi

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/e_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/z_e
add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/z_m
add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/a_m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/b_m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/a_e_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add_multi/dut/b_e_tmp

#run simulation
run 500
