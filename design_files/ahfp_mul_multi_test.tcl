# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_mul_multi.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_mul_multi_tb.v

# simulate design
vsim -c work.ahfp_mul_multi
vsim -c work.test_ahfp_mul_multi

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/a_e
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/a_m
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/b_e
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/b_m
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/exp_tmp
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/man_tmp
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/z_m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/z_e_tmp
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/res
add wave -position insertpoint  \
sim:/test_ahfp_mul_multi/dut/state
#run simulation
run 500
