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
    static COEFF_TYPE gain = 1.0;
    static Y_TYPE peak = 0;
    static ac_int<6, false> peak_counter = 0;
    static Y_TYPE peak_window[PK_AVG_CNT] = {0};

    static COEFF_TYPE sample_window[SAMPLES_PEAK_DETECT];
    static ac_int<6, false> sample_count = 0;

    // Band-pass filter
    bpf(i_sample, b, filter_out);

    // Apply the gain factor to the output of the filter
    Y_TYPE v_out = filter_out * gain;

    // 1. Rectifier
    Y_TYPE abs_v_out = (v_out < 0) ? (Y_TYPE)(-v_out) : (Y_TYPE)(v_out);

    // 2. Peak detector

    if (sample_count == SAMPLES_PEAK_DETECT) {
        peak = 0;
        PK_DETECT_TRAVERSAL: for (int i = 0; i < SAMPLES_PEAK_DETECT; i++) {
            if (sample_window[i] > peak) peak = sample_window[i];
        } 
        sample_count = 0;
        
        peak_window[peak_counter] = peak;
        peak_counter = (peak_counter == PK_AVG_CNT) ? (ac_int<6, false>)0 : (ac_int<6, false>)(peak_counter+1);

        // 3. Peak averaging
        ac_fixed<16, 6, true> sum_peaks = 0;
        AVERAGE_LOOP: for (int i = 0; i < PK_AVG_CNT; i++) {
            sum_peaks += peak_window[i];
        }
        Y_TYPE avg_peak = sum_peaks / PK_AVG_CNT;
        // this line should be HW implemented as shift left 3

        // 4. Gain comparison and control
        if (avg_peak < x_inc_dec) {
            // Signal too weak or null input. Do nothing here
        } else if (avg_peak > x_high) {
            gain -= (COEFF_TYPE)INC_GAIN_STEP; // TODO: Check step size
        } else if (avg_peak < x_low) {
            gain += (COEFF_TYPE)DEC_GAIN_STEP;
        }

    } else {
        sample_window[sample_count] = abs_v_out;
        sample_count++;
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
