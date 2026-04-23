//
// Copyright 2003-2019 Siemens
//
#include "mult_add_pipeline.h"
#include <mc_scverify.h>

#pragma hls_design top
void CCS_BLOCK(mult_add_pipeline)(ac_channel<ac_int<11,false> > &a,
                                  ac_channel<ac_int<14,false> > &b,
                                  ac_channel<ac_int<25,false> > &c,
                                  ac_fixed<10,2,true>           gain, 
                                  bool                          gain_adjust,
                                  ac_channel<ac_int<30,false> > &result)
{
  ac_int<25,false> product = a.read() * b.read();
  ac_int<26,false> sum = product + c.read();

  CHECK:if (gain_adjust) {
    sum = ((ac_fixed<26,26,false>)(sum*gain)).to_uint();
  }
  // NOTE: cast sum to ac_int<30,false> to avoid losing precison on left shift to multiply by 16
  result.write((ac_int<30,false> )sum<< 4); 
}

