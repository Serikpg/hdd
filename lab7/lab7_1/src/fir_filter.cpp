// High-Level Digital Design (HDD)
//
// Lab evolved from Catapult Online Training (Copyright 2018-2021 Siemens)
// 

#include "fir_filter.h"

#pragma hls_design top // To set the Catapult top design block

void fir_filter (const double i_sample,
                 double b[],
                 double &y)
{
  // previous input history, remember across calls
  static double x[TAP_COUNT];
  SHIFT_LOOP:for (int n=TAP_COUNT-1; n>0; n--) {
    x[n] = x[n-1];
  }
  x[0] = i_sample;

  double sum = 0;
  MAC_LOOP:for (unsigned n=0; n<TAP_COUNT; n++) {
    sum += x[n] * b[n];
  }
  y = sum;
}
