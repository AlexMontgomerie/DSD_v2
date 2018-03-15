# make work directory
vlib work
vmap work work

# compile design
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ah_func_instr/ah_func_instr.v
vlog -reportprogress 300 -work work C:/Users/Alex/DSD_v2/design_files/ah_func_instr/ah_func_instr_tb.v

# simulate design
vsim -c work.test_ah_func_instr

#window views
#view objects
#view locals
#view source
view transcript
view wave -undock

#add all waves to wave view
add wave *

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/floor_res

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/floor_sub_res

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/mod_out

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/fixed_theta_in

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/cos

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/float_cos_out

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/float_cos_out_reg

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/xcos_res

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/cos_add_half_res

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/xfifo

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/sumfifo

add wave -position insertpoint  \
sim:/test_ah_func_instr/dut/mulx_res

#run simulation
run 5000
