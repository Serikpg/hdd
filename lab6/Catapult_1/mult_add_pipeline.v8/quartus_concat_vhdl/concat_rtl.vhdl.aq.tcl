    set_global_assignment -name PRE_FLOW_SCRIPT_FILE "quartus_sh:/home/alumnes/s/serik.perez/hdd/lab6/Catapult_1/mult_add_pipeline.v8/quartus_concat_vhdl/pre_flow_vhdl.tcl"
    set_global_assignment -name POST_MODULE_SCRIPT_FILE "quartus_sh:/home/alumnes/s/serik.perez/hdd/lab6/Catapult_1/mult_add_pipeline.v8/quartus_concat_vhdl/post_mod_vhdl.tcl"
    set_global_assignment -name POST_FLOW_SCRIPT_FILE "quartus_sh:/home/alumnes/s/serik.perez/hdd/lab6/Catapult_1/mult_add_pipeline.v8/quartus_concat_vhdl/post_flow_vhdl.tcl"
set CATAPULT_HOME "/tools/Siemens_EDA/Catapult/2021.1/Mgc_home/"
puts "-- CATAPULT_HOME is set to '$CATAPULT_HOME' "

# ----------------------------------------------
# Helper function for dealing with various Quartus Prime versions
proc SetGlobalAssignmentIfAvailable { aname avalue } {
  if { [lsearch -exact [get_all_assignment_names] $aname] != -1 } {
    set_global_assignment -name $aname $avalue
  } else {
    post_message "Global Assignment '$aname' is not available in this version of Quartus Prime"
  }
}

# ----------------------------------------------
# Catapult Quartus Flow Options
#    Flows/Quartus/FITTER_RESYNTHESIS = false
#set_global_assignment -name FITTER_RESYNTHESIS OFF
SetGlobalAssignmentIfAvailable FITTER_RESYNTHESIS OFF
#    Flows/Quartus/ALLOW_RAM_RETIMING = true
#set_global_assignment -name ALLOW_RAM_RETIMING ON
SetGlobalAssignmentIfAvailable ALLOW_RAM_RETIMING ON
#    Flows/Quartus/ALLOW_DSP_RETIMING = true
#set_global_assignment -name ALLOW_DSP_RETIMING ON
SetGlobalAssignmentIfAvailable ALLOW_DSP_RETIMING ON
#    Flows/Quartus/ALLOW_ANY_ROM_SIZE_FOR_RECOGNITION = true
#set_global_assignment -name ALLOW_ANY_ROM_SIZE_FOR_RECOGNITION ON
SetGlobalAssignmentIfAvailable ALLOW_ANY_ROM_SIZE_FOR_RECOGNITION ON
#    Flows/Quartus/ALLOW_ANY_RAM_SIZE_FOR_RECOGNITION = true
#set_global_assignment -name ALLOW_ANY_RAM_SIZE_FOR_RECOGNITION ON
SetGlobalAssignmentIfAvailable ALLOW_ANY_RAM_SIZE_FOR_RECOGNITION ON
# ----------------------------------------------
# Configure device
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CEBA2F17C6
# ----------------------------------------------
# Configure tool options
set_global_assignment -name NUM_PARALLEL_PROCESSORS 3
set_global_assignment -name IO_PLACEMENT_OPTIMIZATION OFF
set_global_assignment -name REPORT_IO_PATHS_SEPARATELY ON
set_global_assignment -name SYNTH_MESSAGE_LEVEL HIGH
# ----------------------------------------------
# Input HDL files
set_global_assignment -name VHDL_FILE ../concat_rtl.vhdl
set_global_assignment -name SDC_FILE /home/alumnes/s/serik.perez/hdd/lab6/Catapult_1/mult_add_pipeline.v8/quartus_concat_vhdl/concat_rtl.vhdl.aq.sdc
set_global_assignment -name TOP_LEVEL_ENTITY mult_add_pipeline
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY .

# ----------------------------------------------
# Configure ROMs (if any)

# make pins virtual to prevent IO routing/buffering generation
set_instance_assignment -name GLOBAL_SIGNAL GLOBAL_CLOCK -to clk
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_vld
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_vld
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_vld
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_rdy
set_instance_assignment -name VIRTUAL_PIN ON -to gain_adjust_rsc_dat
set_instance_assignment -name VIRTUAL_PIN ON -to clk
set_instance_assignment -name VIRTUAL_PIN ON -to rst
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_vld
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[10]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[9]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[8]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[7]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[6]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[5]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[4]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[3]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[2]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[1]
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_dat[0]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_vld
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[13]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[12]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[11]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[10]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[9]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[8]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[7]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[6]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[5]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[4]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[3]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[2]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[1]
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_dat[0]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_vld
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[24]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[23]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[22]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[21]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[20]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[19]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[18]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[17]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[16]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[15]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[14]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[13]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[12]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[11]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[10]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[9]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[8]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[7]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[6]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[5]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[4]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[3]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[2]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[1]
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_dat[0]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_rdy
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[9]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[8]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[7]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[6]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[5]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[4]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[3]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[2]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[1]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_dat[0]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_adjust_rsc_dat
set_instance_assignment -name VIRTUAL_PIN ON -to a_rsc_rdy
set_instance_assignment -name VIRTUAL_PIN ON -to b_rsc_rdy
set_instance_assignment -name VIRTUAL_PIN ON -to c_rsc_rdy
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_vld
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[29]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[28]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[27]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[26]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[25]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[24]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[23]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[22]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[21]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[20]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[19]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[18]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[17]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[16]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[15]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[14]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[13]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[12]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[11]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[10]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[9]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[8]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[7]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[6]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[5]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[4]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[3]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[2]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[1]
set_instance_assignment -name VIRTUAL_PIN ON -to result_rsc_dat[0]
set_instance_assignment -name VIRTUAL_PIN ON -to gain_rsc_triosy_lz
set_instance_assignment -name VIRTUAL_PIN ON -to gain_adjust_rsc_triosy_lz

