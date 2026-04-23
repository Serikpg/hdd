void mc_testbench_capture_IN( ac_channel<ac_int<11, false> > &a, ac_channel<ac_int<14, false> > &b, ac_channel<ac_int<25, false> > &c, ac_fixed<10, 2, true, AC_TRN, AC_WRAP> gain, bool gain_adjust, ac_channel<ac_int<30, false> > &result ) {
  mc_testbench::capture_IN(a, b, c, gain, gain_adjust, result);
}
void mc_testbench_capture_OUT( ac_channel<ac_int<11, false> > &a, ac_channel<ac_int<14, false> > &b, ac_channel<ac_int<25, false> > &c, ac_fixed<10, 2, true, AC_TRN, AC_WRAP> gain, bool gain_adjust, ac_channel<ac_int<30, false> > &result ) {
  mc_testbench::capture_OUT(a, b, c, gain, gain_adjust, result);
}
