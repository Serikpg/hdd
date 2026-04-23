# written for flow package OasysRTL 
set sdc_version 1.7 

set_operating_conditions typical
set_load 11.234 [all_outputs]
## driver/slew constraints on inputs
set data_inputs [list a_rsc_vld {a_rsc_dat[*]} b_rsc_vld {b_rsc_dat[*]} c_rsc_vld {c_rsc_dat[*]} result_rsc_rdy {gain_rsc_dat[*]} gain_adjust_rsc_dat]
set_driving_cell -no_design_rule -library NangateOpenCellLibrary -lib_cell DFFR_X1 -pin Q $data_inputs
set_units -time ns
# time_factor: 1.0

create_clock -name clk -period 1.11 -waveform { 0.0 0.555 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 1.11
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_dat[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_vld}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_rdy}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_dat[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_vld}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_rdy}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {c_rsc_dat[*]}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {c_rsc_vld}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {c_rsc_rdy}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {gain_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {gain_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {gain_adjust_rsc_dat}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {gain_adjust_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_vld}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_rdy}]

