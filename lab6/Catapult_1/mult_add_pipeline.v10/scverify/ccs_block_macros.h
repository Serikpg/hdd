// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_mult_add_pipeline
#define ccs_intercept_mult_add_pipeline_8 \
  mult_add_pipeline(ac_channel<ac_int<11, false> > &a, ac_channel<ac_int<14, false> > &b, ac_channel<ac_int<25, false> > &c, ac_fixed<10, 2, true, AC_TRN, AC_WRAP> gain, bool gain_adjust, ac_channel<ac_int<30, false> > &result);\
  extern void mc_testbench_capture_IN( ac_channel<ac_int<11, false> > &a, ac_channel<ac_int<14, false> > &b, ac_channel<ac_int<25, false> > &c, ac_fixed<10, 2, true, AC_TRN, AC_WRAP> gain, bool gain_adjust, ac_channel<ac_int<30, false> > &result );\
  extern void mc_testbench_capture_OUT( ac_channel<ac_int<11, false> > &a, ac_channel<ac_int<14, false> > &b, ac_channel<ac_int<25, false> > &c, ac_fixed<10, 2, true, AC_TRN, AC_WRAP> gain, bool gain_adjust, ac_channel<ac_int<30, false> > &result );\
  void ccs_real_mult_add_pipeline(ac_channel<ac_int<11, false> > &a, ac_channel<ac_int<14, false> > &b, ac_channel<ac_int<25, false> > &c, ac_fixed<10, 2, true, AC_TRN, AC_WRAP> gain, bool gain_adjust, ac_channel<ac_int<30, false> > &result);\
  void mult_add_pipeline(ac_channel<ac_int<11, false> > &a, ac_channel<ac_int<14, false> > &b, ac_channel<ac_int<25, false> > &c, ac_fixed<10, 2, true, AC_TRN, AC_WRAP> gain, bool gain_adjust, ac_channel<ac_int<30, false> > &result)\
  {\
    static bool ccs_intercept_flag = false;\
    if (!ccs_intercept_flag) {\
      std::cout << "SCVerify intercepting C++ function 'mult_add_pipeline' for RTL block 'mult_add_pipeline'" << std::endl;\
      ccs_intercept_flag=true;\
    }\
    mc_testbench_wait_for_idle_sync();\
    mc_testbench_capture_IN(a, b, c, gain, gain_adjust, result);\
    ccs_real_mult_add_pipeline(a, b, c, gain, gain_adjust, result);\
    mc_testbench_capture_OUT(a, b, c, gain, gain_adjust, result);\
  }\
  void ccs_real_mult_add_pipeline
#else
#define ccs_intercept_mult_add_pipeline_8 mult_add_pipeline
#endif //CCS_DESIGN_FUNC_mult_add_pipeline
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

