#**************************************************************
# Altera DE1-Standard SDC settings
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 20 [get_ports clk]


# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]


#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks


## create_generated_clock -source "path" must be same "target" as: the path get from the Compilation Report -> TimeQuest Timing Analyzer -> Clocks 
## otherwise create_generated_clock constrain may not work

							 
#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************


#**************************************************************
# Set Clock Groups
#**************************************************************




#**************************************************************
# Set False Path
#**************************************************************

#button LED KEY
# Asynchronous I/O

set_false_path -from [get_ports {resetn}] -to *
set_false_path -from [get_ports {enable} ] -to *
set_false_path -from * -to [get_ports {count28_out*}]



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



