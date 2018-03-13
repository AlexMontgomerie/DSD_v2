# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_mod_pi/ahfp_mod_pi.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_mod_pi/ahfp_mod_pi_tb.v

# simulate design
vsim -c work.test_ahfp_mod_pi

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_mod_pi/dut/floor_out
add wave -position insertpoint  \
sim:/test_ahfp_mod_pi/dut/floor_in
add wave -position insertpoint  \
sim:/test_ahfp_mod_pi/dut/mod_buf_val

#run simulation
run 500
