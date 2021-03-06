# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd4.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd8.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd16.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd32.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd64.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd48.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_sub/ahfp_sub.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_sub/ahfp_sub_tb.v

# simulate design
vsim -c work.test_ahfp_sub

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/a_e
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/a_m
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/b_e
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/b_m
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/e_tmp
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/z_e
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/z_m
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/z_m_overflow
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/z_m_tmp
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/z_e_tmp
add wave -position insertpoint  \
sim:/test_ahfp_sub/dut/e_diff
#run simulation
run 500