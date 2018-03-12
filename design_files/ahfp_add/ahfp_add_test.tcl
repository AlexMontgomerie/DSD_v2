# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add/ahfp_add.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_add/ahfp_add_tb.v

# simulate design
vsim -c work.ahfp_add
vsim -c work.test_ahfp_add

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_add/dut/e_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add/dut/m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add/dut/z_e
add wave -position insertpoint  \
sim:/test_ahfp_add/dut/z_m
add wave -position insertpoint  \
sim:/test_ahfp_add/dut/a_m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add/dut/b_m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add/dut/a_e_tmp
add wave -position insertpoint  \
sim:/test_ahfp_add/dut/b_e_tmp

#run simulation
run 500
