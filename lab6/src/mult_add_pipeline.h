//
// Copyright 2003-2019 Siemens
//
#ifndef _INCLUDED_MULT_ADD_PIPELINE_H_
#define _INCLUDED_MULT_ADD_PIPELINE_H_

#include <ac_fixed.h>       // Algortihmic C fixed-point data types
#include <ac_channel.h>     // Algorithmic C channel class

void mult_add_pipeline(ac_channel<ac_int<11,false> > &a, 
                       ac_channel<ac_int<14,false> > &b, 
                       ac_channel<ac_int<25,false> > &c, 
                       ac_fixed<10,2,true>           gain, 
                       bool                          gain_adjust, 
                       ac_channel<ac_int<30,false> > &result);

#endif

