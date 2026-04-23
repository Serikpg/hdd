//
// Copyright 2003-2019 Siemens
//
#ifndef _INCLUDED_MULT_ADD_PIPELINE_REF_H_
#define _INCLUDED_MULT_ADD_PIPELINE_REF_H_

#include <ac_fixed.h>       // Algortihmic C fixed-point data types

void mult_add_pipeline_ref(unsigned int         a, 
                           unsigned int         b, 
                           unsigned int         c, 
                           ac_fixed<10,2,false> gain, 
                           bool                 gain_adjust, 
                           unsigned int         &result);

#endif

