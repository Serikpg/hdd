//
// Copyright 2003-2019 Siemens
//
#include "mult_add_pipeline.h"
#include "mult_add_pipeline_ref.h"
#include <stdio.h>
#include <mc_scverify.h>

CCS_MAIN(int argv, char **argc)
{
  unsigned int a_ref = 60;
  unsigned int b_ref= 30;
  unsigned int c_ref;

  unsigned int result_ref;
  int errCnt = 0;
  ac_int<11,false> a;
  ac_int<14,false> b;
  ac_int<25,false> c;
  ac_channel<ac_int<11,false> > a_chan;
  ac_channel<ac_int<14,false> > b_chan;
  ac_channel<ac_int<25,false> > c_chan;
  float gain_ref = 0.5;
  ac_fixed<10,2,false> gain = 0.5;
  bool gain_adjust = false;
  ac_channel<ac_int<30,false> > result;
  ac_int<30,false> res;
  for (int i=0; i<20; i++) {
    a = rand();
    a_ref = a;
    b = rand();
    b_ref = b;
    c = 33554431;
    c_ref = c;
#ifdef CCS_SCVERIFY
#ifdef STALL
    if (i==3) {
      testbench::a_wait_ctrl.cycles = 2;
    }
    if (i==7) {
      testbench::result_wait_ctrl.cycles = 2;
    }
#endif
#endif
    if (i==9) {
      gain_adjust = true;
    }
    a_chan.write(a);
    b_chan.write(b);
    c_chan.write(c);
    mult_add_pipeline_ref(a_ref,b_ref,c_ref,gain,gain_adjust,result_ref);
    mult_add_pipeline(a_chan,b_chan,c_chan,gain,gain_adjust,result);
    res = result.read();
    if (result_ref != res) {
      printf("ERROR MISMATCH iteration: %d a = %4d  b = %5d  result_ref = %08x  result_bit_acc = %08x \n",i,a_ref,b_ref,result_ref, res.to_uint());
      errCnt++;
    } else {
      printf("iteration: %2d a = %4d  b = %5d  result_ref = %08x  result_bit_acc = %08x \n",i,a_ref,b_ref,result_ref, res.to_uint());
    }
  }
  CCS_RETURN(errCnt);
}

