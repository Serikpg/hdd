// High-Level Digital Design (HDD)
//
// Lab evolved from Catapult Online Training (Copyright 2018-2021 Siemens)
// 

#ifndef LPF_AC_H_
#define LPF_AC_H_

#include <ac_fixed.h>
#include <ac_int.h>

const unsigned FILTER_ORDER = 120; // 158; //120;        // filter order
const unsigned TAP_COUNT = FILTER_ORDER+1;  // there are N+1 coefficients for an N-order filter

// Number of samples to detect one peak: Half period of the lower filter frequency
// Tlow/(2Ts) = fs/(2flow) = 10 kHz/600 Hz = ~17. Take 32 for simpler division
const unsigned SAMPLES_PEAK_DETECT = 20; // 32;
const unsigned PK_AVG_CNT = 8;// 32; // Number of averaged peaks



typedef ac_fixed<10,2,true>   X_TYPE;
typedef ac_fixed<12,2,true> COEFF_TYPE;
typedef ac_fixed<12,4,true,AC_RND,AC_SAT_SYM> Y_TYPE;

// Intermediate variable data types:
typedef X_TYPE::rt_T<COEFF_TYPE>::mult           PROD_TYPE;
typedef PROD_TYPE::rt_unary::set<TAP_COUNT>::sum SUM_TYPE;

// Comparison constants
const Y_TYPE x_max = 2;
const Y_TYPE x_ref = x_max/2;
const Y_TYPE x_high = x_ref + x_ref/64;
const Y_TYPE x_low = x_ref - x_ref/64; 
const Y_TYPE x_lock = x_ref/8;
const Y_TYPE x_inc_dec = x_ref/16;

// Function prototypes
void lpf_ac(const X_TYPE i_sample, COEFF_TYPE b[], Y_TYPE &y);
void lpf(const X_TYPE i_sample, COEFF_TYPE b[], Y_TYPE &y);

#endif


