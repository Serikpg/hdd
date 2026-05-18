// High-Level Digital Design (HDD)
//
// Lab evolved from Catapult Online Training (Copyright 2018-2021 Siemens)
//

// Modified from fir_filter.cpp
//

#include "lpf_AC.h"
#include "stdio.h"


#pragma hls_design top // To set the Catapult top design block

void bpf_gain_ac (const X_TYPE i_sample, COEFF_TYPE b[], Y_TYPE &y)
{
// Init variables
Y_TYPE filter_out;
static ac_fixed<12, 2, true> gain = 1.0;
static Y_TYPE peak = 0;
static ac_int<6, false> sample_counter = 0;
static Y_TYPE peak_history[PK_AVG_CNT] = {0};

// Band-pass filter
bpf(i_sample, b, filter_out);

// Apply the gain factor to the output of the filter
Y_TYPE v_out = filter_out * gain;

Y_TYPE abs_v_out = (v_out < 0) ? (Y_TYPE)(-v_out) : (Y_TYPE)(v_out);
if (abs_v_out > peak) {
  peak = abs_v_out;
}

sample_counter++;

if (sample_counter == SAMPLES_PEAK_DETECT) {
  sample_counter = 0;

  UPDATE_HISTORY_LOOP: for (int i = PK_AVG_CNT - 1; i > 0; i--) {
    peak_history[i] = peak_history[i-1];
  }
  peak_history[0] = peak;
  peak = 0;

  ac_fixed<16, 6, true> sum_peaks = 0;
  AVERAGE_LOOP: for (int i = 0; i < PK_AVG_CNT; i++) {
    sum_peaks += peak_history[i];
  }
  Y_TYPE avg_peak = sum_peaks / PK_AVG_CNT;

  if (avg_peak < x_inc_dec) {
    // Signal too weak or null input. Do nothing here
  } else if (avg_peak > x_high) {
    gain -= (ac_fixed<12, 2, true>)0.002; // TODO: Check step size
  } else if (avg_peak < x_low) {
    gain += (ac_fixed<12, 2, true>)0.002;
  }
}

y = v_out;
}

// Band-pass filter function
void bpf(const X_TYPE i_sample, COEFF_TYPE b[], Y_TYPE &y)
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
