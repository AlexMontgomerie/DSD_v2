# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/accumulate/accumulate.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/accumulate/accumulate_tb.v

# simulate design
vsim -c work.test_accumulate

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_accumulate/dut/dataa

add wave -position insertpoint  \
sim:/test_accumulate/dut/datab

add wave -position insertpoint  \
sim:/test_accumulate/dut/res

add wave -position insertpoint  \
sim:/test_accumulate/dut/done_state

add wave -position insertpoint  \
sim:/test_accumulate/dut/buffer

add wave -position insertpoint  \
sim:/test_accumulate/dut/count

add wave -position insertpoint  \
sim:/test_accumulate/dut/done_count

add wave -position insertpoint  \
sim:/test_accumulate/dut/done_acc_count

#run simulation
run 1000
