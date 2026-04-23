## HLS SP STA script: characterization mode is 'p2p'
#set_operating_conditions -model fast -temperature 85 -voltage 1200
puts "-- Starting FMAX for design 'mult_add_pipeline'"
report_clock_fmax_summary
puts "-- FMAX finished for design 'mult_add_pipeline'"
    set clk_candidates {1 IN a_rsc_vld a_rsc_vld 2 IN b_rsc_vld b_rsc_vld 3 IN c_rsc_vld c_rsc_vld 6 OUT result_rsc_rdy result_rsc_rdy 5 IN gain_adjust_rsc_dat gain_adjust_rsc_dat 0 INOUT clk clk} 
    set i_candidates {1 IN a_rsc_vld a_rsc_vld 1 IN {a_rsc_dat[*]} a_rsc_dat 2 IN b_rsc_vld b_rsc_vld 2 IN {b_rsc_dat[*]} b_rsc_dat 3 IN c_rsc_vld c_rsc_vld 3 IN {c_rsc_dat[*]} c_rsc_dat 6 OUT result_rsc_rdy result_rsc_rdy 4 IN {gain_rsc_dat[*]} gain_rsc_dat 5 IN gain_adjust_rsc_dat gain_adjust_rsc_dat} 
    set o_candidates {1 IN a_rsc_rdy a_rsc_rdy 2 IN b_rsc_rdy b_rsc_rdy 3 IN c_rsc_rdy c_rsc_rdy 6 OUT result_rsc_vld result_rsc_vld 6 OUT {result_rsc_dat[*]} result_rsc_dat 4 IN gain_rsc_triosy_lz gain_rsc_triosy_lz 5 IN gain_adjust_rsc_triosy_lz gain_adjust_rsc_triosy_lz} 
    foreach { irsid irsmode iport ite } $i_candidates {
        foreach_in_collection tclk [all_clocks] {
            report_timing -from ${iport} -to_clock ${tclk} 
        }
    }
    foreach_in_collection fclk [all_clocks] {
        foreach_in_collection tclk [all_clocks] {
            report_timing -from_clock ${fclk} -setup -to_clock ${tclk} 
        }
    }
    foreach { orsid orsmode oport ote } $o_candidates {
        foreach_in_collection fclk [all_clocks] {
            report_timing -from_clock ${fclk} -to ${oport}
        }
    }
    foreach { orsid orsmode oport ote } $o_candidates {
        foreach { irsid irsmode iport ite } $i_candidates {
            report_timing -from ${iport} -to ${oport}
        }
    }
puts "-- STA finished for design 'mult_add_pipeline'"
