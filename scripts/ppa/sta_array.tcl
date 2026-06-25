read_liberty /home/ubuntu/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog results/netlists/array_sky130_netlist.v
link_design array_multiplier_64bit

create_clock -name vclk -period 10
set_input_delay 0 -clock vclk [all_inputs]
set_output_delay 0 -clock vclk [all_outputs]

report_checks -from [all_inputs] -to [all_outputs] -path_delay max -digits 4
report_worst_slack -max
report_wns
report_tns
