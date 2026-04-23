# written for flow package Quartus 
set sdc_version 1.7 

create_clock -name clk -period 7.69 -waveform { 0.0 3.845 } [get_ports {clk}]
set_clock_uncertainty -from [get_clocks {*}] -to [get_clocks {*}] 0.0

create_clock -name virtual_io_clk -period 7.69
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

