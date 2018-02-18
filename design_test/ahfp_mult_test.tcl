# modelsim
vsim

# make work directory

# open work directory and use it
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work $PWD/../design_files/ahfp_mult.v
vlog -reportprogress 300 -work work $PWD/../design_files/tahfp_mult.v

# simulate design
vsim work.ahfp_mult




