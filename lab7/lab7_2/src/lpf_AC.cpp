// High-Level Digital Design (HDD)
//
// Lab evolved from Catapult Online Training (Copyright 2018-2021 Siemens)
// 

// Modified from fir_filter.cpp
//

#include "lpf_AC.h" 
#include "stdio.h"


#pragma hls_design top // To set the Catapult top design block

void lpf_ac (const X_TYPE i_sample, COEFF_TYPE b[], Y_TYPE &y)                 
{
Y_TYPE filter_out; 

// Functions
lpf(i_sample, b, filter_out);

// For debug
//  printf("%f \n", filter_out.to_double());

y = filter_out; 
}

// Low-pass filter function

void lpf(const X_TYPE i_sample, COEFF_TYPE b[], Y_TYPE &y) 
  {
  // previous input history, remember across calls
  static X_TYPE x[TAP_COUNT];
  SHIFT_LOOP: for (int n=TAP_COUNT-1; n>0; n--) {
    x[n] = x[n-1];
  }
  x[0] = i_sample;

  SUM_TYPE sum = 0;
  MAC_LOOP: for (unsigned n=0; n<TAP_COUNT; n++) {
    sum += x[n] * b[n];
  }
  // round & saturate according to Y_TYPE  

  y = sum;
}


