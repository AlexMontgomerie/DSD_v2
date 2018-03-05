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
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ahfp_lzd/ahfp_lzd_tb.v

# simulate design
vsim -c work.test_ahfp_lzd

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