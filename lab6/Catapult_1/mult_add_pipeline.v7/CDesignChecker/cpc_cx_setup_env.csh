#! /bin/csh -f
setenv SYSTEMC_HOME /tools/Siemens_EDA/Catapult/2021.1/Mgc_home//shared
setenv SYSTEMC_LIB_DIR /tools/Siemens_EDA/Catapult/2021.1/Mgc_home//shared/lib
setenv CXX_FLAGS "-g -DCALYPTO_SKIP_SYSTEMC_VERSION_CHECK"
setenv LD_FLAGS "-lpthread"
setenv OSSIM ddd
setenv PATH /tools/Siemens_EDA/Catapult/2021.1/Mgc_home//bin:$PATH
