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
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/a_e
add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/a_m
add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/b_e
add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/b_m
add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/exp_tmp_init
add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/man_tmp_init
add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/z_m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_mult/dut/z_e_tmp
#run simulation
run 500
