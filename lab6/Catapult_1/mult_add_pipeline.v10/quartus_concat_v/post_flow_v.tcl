set CATAPULT_HOME "/tools/Siemens_EDA/Catapult/2021.1/Mgc_home/"
set module [lindex $quartus(args) 0]
global env
source [file join $CATAPULT_HOME pkgs sif userware En_na flows quartus_funcs.tcl]
SourceCustomScriptIfExists final
