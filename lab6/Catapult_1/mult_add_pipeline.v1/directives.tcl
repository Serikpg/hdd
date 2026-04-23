//  Catapult Ultra Synthesis 2021.1/950854 (Production Release) Mon Aug  2 21:36:02 PDT 2021
//  
//          Copyright (c) Siemens EDA, 1996-2021, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//  
//  Running on Linux serik.perez@c5c6 6.8.0-51-generic x86_64 aol
//  
//  Package information: SIFLIBS v23.7_0.0, HLS_PKGS v23.7_0.0, 
//                       SIF_TOOLKITS v23.7_0.0, SIF_XILINX v23.7_0.0, 
//                       SIF_ALTERA v23.7_0.0, CCS_LIBS v23.7_0.0, 
//                       CDS_PPRO v10.5a, CDS_DesigChecker v2021.1, 
//                       CDS_OASYS v20.1_3.6, CDS_PSR v20.2_1.8, 
//                       DesignPad v2.78_1.0
//  
solution new -state initial
solution options defaults
solution options set /OnTheFly/VthAttributeType cell_lib
solution file add ./src/mult_add_pipeline.cpp -type C++
solution file add ./src/tb.cpp -type C++ -exclude true
solution file add ./src/mult_add_pipeline_ref.cpp -type C++ -exclude true
directive set -DESIGN_GOAL area
directive set -SPECULATE true
directive set -MERGEABLE true
directive set -REGISTER_THRESHOLD 256
directive set -MEM_MAP_THRESHOLD 32
directive set -LOGIC_OPT false
directive set -FSM_ENCODING none
directive set -FSM_BINARY_ENCODING_THRESHOLD 64
directive set -REG_MAX_FANOUT 0
directive set -NO_X_ASSIGNMENTS true
directive set -SAFE_FSM false
directive set -REGISTER_SHARING_MAX_WIDTH_DIFFERENCE 8
directive set -REGISTER_SHARING_LIMIT 0
directive set -ASSIGN_OVERHEAD 0
directive set -TIMING_CHECKS true
directive set -MUXPATH true
directive set -REALLOC true
directive set -UNROLL no
directive set -IO_MODE super
directive set -CHAN_IO_PROTOCOL use_library
directive set -ARRAY_SIZE 1024
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
directive set -RESET_CLEARS_ALL_REGS use_library
directive set -CLOCK_OVERHEAD 20.000000
directive set -ON_THE_FLY_PROTOTYPING false
directive set -OPT_CONST_MULTS use_library
directive set -CHARACTERIZE_ROM false
directive set -PROTOTYPE_ROM true
directive set -ROM_THRESHOLD 64
directive set -CLUSTER_ADDTREE_IN_WIDTH_THRESHOLD 0
directive set -CLUSTER_ADDTREE_IN_COUNT_THRESHOLD 0
directive set -CLUSTER_OPT_CONSTANT_INPUTS true
directive set -CLUSTER_RTL_SYN false
directive set -CLUSTER_FAST_MODE false
directive set -CLUSTER_TYPE combinational
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
go compile
solution library add nangate-45nm_beh -- -rtlsyntool OasysRTL -vendor Nangate -technology 045nm
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 1.11 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 0.555 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /mult_add_pipeline/core -DESIGN_GOAL area
directive set /mult_add_pipeline/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
