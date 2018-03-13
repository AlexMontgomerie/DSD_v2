# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ah_func/ah_func.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ah_func/ah_func_tb.v

# simulate design
vsim -c work.test_ah_func

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
