// High-Level Digital Design (HDD)
//
// Lab evolved from Catapult Online Training (Copyright 2018-2021 Siemens)
// 

#ifndef FIR_FILTER_H_
#define FIR_FILTER_H_

const unsigned N = 121;          // filter order
const unsigned TAP_COUNT = N+1;  // there are N+1 coefficients for an N-order filter

void fir_filter(const double, double [], double &);
#endif
