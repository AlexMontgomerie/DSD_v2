# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_pipeline_buffer/ahfp_pipeline_buffer.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_pipeline_buffer/ahfp_pipeline_buffer_tb.v

# simulate design
vsim -c work.test_ahfp_pipeline_buffer

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ahfp_pipeline_buffer/dut/buffer

#run simulation
run 500
