//
// Copyright 2003-2019 Siemens
//
#include "mult_add_pipeline_ref.h"

void mult_add_pipeline_ref(unsigned int         a,
                           unsigned int         b,
                           unsigned int         c, 
                           ac_fixed<10,2,false> gain, 
                           bool                 gain_adjust, 
                           unsigned int         &result)
{
  int product = a * b;
  int sum = product + c;

  if (gain_adjust) {
    sum = sum*gain.to_double();
  }
  result = sum<<4; // multiply by 16
}

