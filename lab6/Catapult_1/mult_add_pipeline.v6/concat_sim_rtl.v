
//------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/ccs_in_wait_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_in_wait_v1 (idat, rdy, ivld, dat, irdy, vld);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  output             rdy;
  output             ivld;
  input  [width-1:0] dat;
  input              irdy;
  input              vld;

  wire   [width-1:0] idat;
  wire               rdy;
  wire               ivld;

  localparam stallOff = 0; 
  wire                  stall_ctrl;
  assign stall_ctrl = stallOff;

  assign idat = dat;
  assign rdy = irdy && !stall_ctrl;
  assign ivld = vld && !stall_ctrl;

endmodule


//------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/ccs_out_wait_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_out_wait_v1 (dat, irdy, vld, idat, rdy, ivld);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] dat;
  output             irdy;
  output             vld;
  input  [width-1:0] idat;
  input              rdy;
  input              ivld;

  wire   [width-1:0] dat;
  wire               irdy;
  wire               vld;

  localparam stallOff = 0; 
  wire stall_ctrl;
  assign stall_ctrl = stallOff;

  assign dat = idat;
  assign irdy = rdy && !stall_ctrl;
  assign vld = ivld && !stall_ctrl;

endmodule



//------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module mgc_io_sync_v2 (ld, lz);
    parameter valid = 0;

    input  ld;
    output lz;

    wire   lz;

    assign lz = ld;

endmodule


//------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/ccs_in_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_in_v1 (idat, dat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  input  [width-1:0] dat;

  wire   [width-1:0] idat;

  assign idat = dat;

endmodule


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2021.1/950854 Production Release
//  HLS Date:       Mon Aug  2 21:36:02 PDT 2021
// 
//  Generated by:   serik.perez@c5c6
//  Generated date: Thu Apr 23 17:44:48 2026
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module mult_add_pipeline_core_core_fsm (
  clk, rst, core_wen, fsm_output
);
  input clk;
  input rst;
  input core_wen;
  output [1:0] fsm_output;
  reg [1:0] fsm_output;


  // FSM State Type Declaration for mult_add_pipeline_core_core_fsm_1
  parameter
    core_rlp_C_0 = 1'd0,
    main_C_0 = 1'd1;

  reg  state_var;
  reg  state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : mult_add_pipeline_core_core_fsm_1
    case (state_var)
      main_C_0 : begin
        fsm_output = 2'b10;
        state_var_NS = main_C_0;
      end
      // core_rlp_C_0
      default : begin
        fsm_output = 2'b01;
        state_var_NS = main_C_0;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= core_rlp_C_0;
    end
    else if ( core_wen ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_staller
// ------------------------------------------------------------------


module mult_add_pipeline_core_staller (
  clk, rst, core_wen, core_wten, a_rsci_wen_comp, b_rsci_wen_comp, c_rsci_wen_comp,
      result_rsci_wen_comp
);
  input clk;
  input rst;
  output core_wen;
  output core_wten;
  reg core_wten;
  input a_rsci_wen_comp;
  input b_rsci_wen_comp;
  input c_rsci_wen_comp;
  input result_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  assign core_wen = a_rsci_wen_comp & b_rsci_wen_comp & c_rsci_wen_comp & result_rsci_wen_comp;
  always @(posedge clk) begin
    if ( rst ) begin
      core_wten <= 1'b0;
    end
    else begin
      core_wten <= ~ core_wen;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
    (
  core_wten, gain_adjust_rsc_triosy_obj_iswt0, gain_adjust_rsc_triosy_obj_biwt
);
  input core_wten;
  input gain_adjust_rsc_triosy_obj_iswt0;
  output gain_adjust_rsc_triosy_obj_biwt;



  // Interconnect Declarations for Component Instantiations 
  assign gain_adjust_rsc_triosy_obj_biwt = (~ core_wten) & gain_adjust_rsc_triosy_obj_iswt0;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl (
  core_wten, gain_rsc_triosy_obj_iswt0, gain_rsc_triosy_obj_biwt
);
  input core_wten;
  input gain_rsc_triosy_obj_iswt0;
  output gain_rsc_triosy_obj_biwt;



  // Interconnect Declarations for Component Instantiations 
  assign gain_rsc_triosy_obj_biwt = (~ core_wten) & gain_rsc_triosy_obj_iswt0;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_result_rsci_result_wait_dp
// ------------------------------------------------------------------


module mult_add_pipeline_core_result_rsci_result_wait_dp (
  clk, rst, result_rsci_oswt, result_rsci_wen_comp, result_rsci_biwt, result_rsci_bdwt,
      result_rsci_bcwt
);
  input clk;
  input rst;
  input result_rsci_oswt;
  output result_rsci_wen_comp;
  input result_rsci_biwt;
  input result_rsci_bdwt;
  output result_rsci_bcwt;
  reg result_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign result_rsci_wen_comp = (~ result_rsci_oswt) | result_rsci_biwt | result_rsci_bcwt;
  always @(posedge clk) begin
    if ( rst ) begin
      result_rsci_bcwt <= 1'b0;
    end
    else begin
      result_rsci_bcwt <= ~((~(result_rsci_bcwt | result_rsci_biwt)) | result_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_result_rsci_result_wait_ctrl
// ------------------------------------------------------------------


module mult_add_pipeline_core_result_rsci_result_wait_ctrl (
  core_wen, result_rsci_oswt, result_rsci_biwt, result_rsci_bdwt, result_rsci_bcwt,
      result_rsci_irdy, result_rsci_ivld_core_sct
);
  input core_wen;
  input result_rsci_oswt;
  output result_rsci_biwt;
  output result_rsci_bdwt;
  input result_rsci_bcwt;
  input result_rsci_irdy;
  output result_rsci_ivld_core_sct;


  // Interconnect Declarations
  wire result_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign result_rsci_bdwt = result_rsci_oswt & core_wen;
  assign result_rsci_biwt = result_rsci_ogwt & result_rsci_irdy;
  assign result_rsci_ogwt = result_rsci_oswt & (~ result_rsci_bcwt);
  assign result_rsci_ivld_core_sct = result_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_c_rsci_c_wait_dp
// ------------------------------------------------------------------


module mult_add_pipeline_core_c_rsci_c_wait_dp (
  clk, rst, c_rsci_oswt, c_rsci_wen_comp, c_rsci_idat_mxwt, c_rsci_biwt, c_rsci_bdwt,
      c_rsci_bcwt, c_rsci_idat
);
  input clk;
  input rst;
  input c_rsci_oswt;
  output c_rsci_wen_comp;
  output [24:0] c_rsci_idat_mxwt;
  input c_rsci_biwt;
  input c_rsci_bdwt;
  output c_rsci_bcwt;
  reg c_rsci_bcwt;
  input [24:0] c_rsci_idat;


  // Interconnect Declarations
  reg [24:0] c_rsci_idat_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign c_rsci_wen_comp = (~ c_rsci_oswt) | c_rsci_biwt | c_rsci_bcwt;
  assign c_rsci_idat_mxwt = MUX_v_25_2_2(c_rsci_idat, c_rsci_idat_bfwt, c_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      c_rsci_bcwt <= 1'b0;
    end
    else begin
      c_rsci_bcwt <= ~((~(c_rsci_bcwt | c_rsci_biwt)) | c_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      c_rsci_idat_bfwt <= 25'b0000000000000000000000000;
    end
    else if ( c_rsci_biwt ) begin
      c_rsci_idat_bfwt <= c_rsci_idat;
    end
  end

  function automatic [24:0] MUX_v_25_2_2;
    input [24:0] input_0;
    input [24:0] input_1;
    input  sel;
    reg [24:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_25_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_c_rsci_c_wait_ctrl
// ------------------------------------------------------------------


module mult_add_pipeline_core_c_rsci_c_wait_ctrl (
  core_wen, c_rsci_oswt, c_rsci_biwt, c_rsci_bdwt, c_rsci_bcwt, c_rsci_irdy_core_sct,
      c_rsci_ivld
);
  input core_wen;
  input c_rsci_oswt;
  output c_rsci_biwt;
  output c_rsci_bdwt;
  input c_rsci_bcwt;
  output c_rsci_irdy_core_sct;
  input c_rsci_ivld;


  // Interconnect Declarations
  wire c_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign c_rsci_bdwt = c_rsci_oswt & core_wen;
  assign c_rsci_biwt = c_rsci_ogwt & c_rsci_ivld;
  assign c_rsci_ogwt = c_rsci_oswt & (~ c_rsci_bcwt);
  assign c_rsci_irdy_core_sct = c_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_b_rsci_b_wait_dp
// ------------------------------------------------------------------


module mult_add_pipeline_core_b_rsci_b_wait_dp (
  clk, rst, b_rsci_oswt, b_rsci_wen_comp, b_rsci_idat_mxwt, b_rsci_biwt, b_rsci_bdwt,
      b_rsci_bcwt, b_rsci_idat
);
  input clk;
  input rst;
  input b_rsci_oswt;
  output b_rsci_wen_comp;
  output [13:0] b_rsci_idat_mxwt;
  input b_rsci_biwt;
  input b_rsci_bdwt;
  output b_rsci_bcwt;
  reg b_rsci_bcwt;
  input [13:0] b_rsci_idat;


  // Interconnect Declarations
  reg [13:0] b_rsci_idat_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign b_rsci_wen_comp = (~ b_rsci_oswt) | b_rsci_biwt | b_rsci_bcwt;
  assign b_rsci_idat_mxwt = MUX_v_14_2_2(b_rsci_idat, b_rsci_idat_bfwt, b_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      b_rsci_bcwt <= 1'b0;
    end
    else begin
      b_rsci_bcwt <= ~((~(b_rsci_bcwt | b_rsci_biwt)) | b_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      b_rsci_idat_bfwt <= 14'b00000000000000;
    end
    else if ( b_rsci_biwt ) begin
      b_rsci_idat_bfwt <= b_rsci_idat;
    end
  end

  function automatic [13:0] MUX_v_14_2_2;
    input [13:0] input_0;
    input [13:0] input_1;
    input  sel;
    reg [13:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_14_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_b_rsci_b_wait_ctrl
// ------------------------------------------------------------------


module mult_add_pipeline_core_b_rsci_b_wait_ctrl (
  core_wen, b_rsci_oswt, b_rsci_biwt, b_rsci_bdwt, b_rsci_bcwt, b_rsci_irdy_core_sct,
      b_rsci_ivld
);
  input core_wen;
  input b_rsci_oswt;
  output b_rsci_biwt;
  output b_rsci_bdwt;
  input b_rsci_bcwt;
  output b_rsci_irdy_core_sct;
  input b_rsci_ivld;


  // Interconnect Declarations
  wire b_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign b_rsci_bdwt = b_rsci_oswt & core_wen;
  assign b_rsci_biwt = b_rsci_ogwt & b_rsci_ivld;
  assign b_rsci_ogwt = b_rsci_oswt & (~ b_rsci_bcwt);
  assign b_rsci_irdy_core_sct = b_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_a_rsci_a_wait_dp
// ------------------------------------------------------------------


module mult_add_pipeline_core_a_rsci_a_wait_dp (
  clk, rst, a_rsci_oswt, a_rsci_wen_comp, a_rsci_idat_mxwt, a_rsci_biwt, a_rsci_bdwt,
      a_rsci_bcwt, a_rsci_idat
);
  input clk;
  input rst;
  input a_rsci_oswt;
  output a_rsci_wen_comp;
  output [10:0] a_rsci_idat_mxwt;
  input a_rsci_biwt;
  input a_rsci_bdwt;
  output a_rsci_bcwt;
  reg a_rsci_bcwt;
  input [10:0] a_rsci_idat;


  // Interconnect Declarations
  reg [10:0] a_rsci_idat_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign a_rsci_wen_comp = (~ a_rsci_oswt) | a_rsci_biwt | a_rsci_bcwt;
  assign a_rsci_idat_mxwt = MUX_v_11_2_2(a_rsci_idat, a_rsci_idat_bfwt, a_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      a_rsci_bcwt <= 1'b0;
    end
    else begin
      a_rsci_bcwt <= ~((~(a_rsci_bcwt | a_rsci_biwt)) | a_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      a_rsci_idat_bfwt <= 11'b00000000000;
    end
    else if ( a_rsci_biwt ) begin
      a_rsci_idat_bfwt <= a_rsci_idat;
    end
  end

  function automatic [10:0] MUX_v_11_2_2;
    input [10:0] input_0;
    input [10:0] input_1;
    input  sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_11_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_a_rsci_a_wait_ctrl
// ------------------------------------------------------------------


module mult_add_pipeline_core_a_rsci_a_wait_ctrl (
  core_wen, a_rsci_oswt, a_rsci_biwt, a_rsci_bdwt, a_rsci_bcwt, a_rsci_irdy_core_sct,
      a_rsci_ivld
);
  input core_wen;
  input a_rsci_oswt;
  output a_rsci_biwt;
  output a_rsci_bdwt;
  input a_rsci_bcwt;
  output a_rsci_irdy_core_sct;
  input a_rsci_ivld;


  // Interconnect Declarations
  wire a_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign a_rsci_bdwt = a_rsci_oswt & core_wen;
  assign a_rsci_biwt = a_rsci_ogwt & a_rsci_ivld;
  assign a_rsci_ogwt = a_rsci_oswt & (~ a_rsci_bcwt);
  assign a_rsci_irdy_core_sct = a_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_gain_adjust_rsc_triosy_obj
// ------------------------------------------------------------------


module mult_add_pipeline_core_gain_adjust_rsc_triosy_obj (
  gain_adjust_rsc_triosy_lz, core_wten, gain_adjust_rsc_triosy_obj_iswt0
);
  output gain_adjust_rsc_triosy_lz;
  input core_wten;
  input gain_adjust_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire gain_adjust_rsc_triosy_obj_biwt;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) gain_adjust_rsc_triosy_obj (
      .ld(gain_adjust_rsc_triosy_obj_biwt),
      .lz(gain_adjust_rsc_triosy_lz)
    );
  mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
      mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .gain_adjust_rsc_triosy_obj_iswt0(gain_adjust_rsc_triosy_obj_iswt0),
      .gain_adjust_rsc_triosy_obj_biwt(gain_adjust_rsc_triosy_obj_biwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_gain_rsc_triosy_obj
// ------------------------------------------------------------------


module mult_add_pipeline_core_gain_rsc_triosy_obj (
  gain_rsc_triosy_lz, core_wten, gain_rsc_triosy_obj_iswt0
);
  output gain_rsc_triosy_lz;
  input core_wten;
  input gain_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire gain_rsc_triosy_obj_biwt;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) gain_rsc_triosy_obj (
      .ld(gain_rsc_triosy_obj_biwt),
      .lz(gain_rsc_triosy_lz)
    );
  mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .gain_rsc_triosy_obj_iswt0(gain_rsc_triosy_obj_iswt0),
      .gain_rsc_triosy_obj_biwt(gain_rsc_triosy_obj_biwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_result_rsci
// ------------------------------------------------------------------


module mult_add_pipeline_core_result_rsci (
  clk, rst, result_rsc_dat, result_rsc_vld, result_rsc_rdy, core_wen, result_rsci_oswt,
      result_rsci_wen_comp, result_rsci_idat
);
  input clk;
  input rst;
  output [29:0] result_rsc_dat;
  output result_rsc_vld;
  input result_rsc_rdy;
  input core_wen;
  input result_rsci_oswt;
  output result_rsci_wen_comp;
  input [29:0] result_rsci_idat;


  // Interconnect Declarations
  wire result_rsci_biwt;
  wire result_rsci_bdwt;
  wire result_rsci_bcwt;
  wire result_rsci_irdy;
  wire result_rsci_ivld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  wire [29:0] nl_result_rsci_idat;
  assign nl_result_rsci_idat = {(result_rsci_idat[29:4]) , 4'b0000};
  ccs_out_wait_v1 #(.rscid(32'sd6),
  .width(32'sd30)) result_rsci (
      .irdy(result_rsci_irdy),
      .ivld(result_rsci_ivld_core_sct),
      .idat(nl_result_rsci_idat[29:0]),
      .rdy(result_rsc_rdy),
      .vld(result_rsc_vld),
      .dat(result_rsc_dat)
    );
  mult_add_pipeline_core_result_rsci_result_wait_ctrl mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .result_rsci_oswt(result_rsci_oswt),
      .result_rsci_biwt(result_rsci_biwt),
      .result_rsci_bdwt(result_rsci_bdwt),
      .result_rsci_bcwt(result_rsci_bcwt),
      .result_rsci_irdy(result_rsci_irdy),
      .result_rsci_ivld_core_sct(result_rsci_ivld_core_sct)
    );
  mult_add_pipeline_core_result_rsci_result_wait_dp mult_add_pipeline_core_result_rsci_result_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .result_rsci_oswt(result_rsci_oswt),
      .result_rsci_wen_comp(result_rsci_wen_comp),
      .result_rsci_biwt(result_rsci_biwt),
      .result_rsci_bdwt(result_rsci_bdwt),
      .result_rsci_bcwt(result_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_c_rsci
// ------------------------------------------------------------------


module mult_add_pipeline_core_c_rsci (
  clk, rst, c_rsc_dat, c_rsc_vld, c_rsc_rdy, core_wen, c_rsci_oswt, c_rsci_wen_comp,
      c_rsci_idat_mxwt
);
  input clk;
  input rst;
  input [24:0] c_rsc_dat;
  input c_rsc_vld;
  output c_rsc_rdy;
  input core_wen;
  input c_rsci_oswt;
  output c_rsci_wen_comp;
  output [24:0] c_rsci_idat_mxwt;


  // Interconnect Declarations
  wire c_rsci_biwt;
  wire c_rsci_bdwt;
  wire c_rsci_bcwt;
  wire c_rsci_irdy_core_sct;
  wire c_rsci_ivld;
  wire [24:0] c_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_v1 #(.rscid(32'sd3),
  .width(32'sd25)) c_rsci (
      .rdy(c_rsc_rdy),
      .vld(c_rsc_vld),
      .dat(c_rsc_dat),
      .irdy(c_rsci_irdy_core_sct),
      .ivld(c_rsci_ivld),
      .idat(c_rsci_idat)
    );
  mult_add_pipeline_core_c_rsci_c_wait_ctrl mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .c_rsci_oswt(c_rsci_oswt),
      .c_rsci_biwt(c_rsci_biwt),
      .c_rsci_bdwt(c_rsci_bdwt),
      .c_rsci_bcwt(c_rsci_bcwt),
      .c_rsci_irdy_core_sct(c_rsci_irdy_core_sct),
      .c_rsci_ivld(c_rsci_ivld)
    );
  mult_add_pipeline_core_c_rsci_c_wait_dp mult_add_pipeline_core_c_rsci_c_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .c_rsci_oswt(c_rsci_oswt),
      .c_rsci_wen_comp(c_rsci_wen_comp),
      .c_rsci_idat_mxwt(c_rsci_idat_mxwt),
      .c_rsci_biwt(c_rsci_biwt),
      .c_rsci_bdwt(c_rsci_bdwt),
      .c_rsci_bcwt(c_rsci_bcwt),
      .c_rsci_idat(c_rsci_idat)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_b_rsci
// ------------------------------------------------------------------


module mult_add_pipeline_core_b_rsci (
  clk, rst, b_rsc_dat, b_rsc_vld, b_rsc_rdy, core_wen, b_rsci_oswt, b_rsci_wen_comp,
      b_rsci_idat_mxwt
);
  input clk;
  input rst;
  input [13:0] b_rsc_dat;
  input b_rsc_vld;
  output b_rsc_rdy;
  input core_wen;
  input b_rsci_oswt;
  output b_rsci_wen_comp;
  output [13:0] b_rsci_idat_mxwt;


  // Interconnect Declarations
  wire b_rsci_biwt;
  wire b_rsci_bdwt;
  wire b_rsci_bcwt;
  wire b_rsci_irdy_core_sct;
  wire b_rsci_ivld;
  wire [13:0] b_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_v1 #(.rscid(32'sd2),
  .width(32'sd14)) b_rsci (
      .rdy(b_rsc_rdy),
      .vld(b_rsc_vld),
      .dat(b_rsc_dat),
      .irdy(b_rsci_irdy_core_sct),
      .ivld(b_rsci_ivld),
      .idat(b_rsci_idat)
    );
  mult_add_pipeline_core_b_rsci_b_wait_ctrl mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .b_rsci_oswt(b_rsci_oswt),
      .b_rsci_biwt(b_rsci_biwt),
      .b_rsci_bdwt(b_rsci_bdwt),
      .b_rsci_bcwt(b_rsci_bcwt),
      .b_rsci_irdy_core_sct(b_rsci_irdy_core_sct),
      .b_rsci_ivld(b_rsci_ivld)
    );
  mult_add_pipeline_core_b_rsci_b_wait_dp mult_add_pipeline_core_b_rsci_b_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .b_rsci_oswt(b_rsci_oswt),
      .b_rsci_wen_comp(b_rsci_wen_comp),
      .b_rsci_idat_mxwt(b_rsci_idat_mxwt),
      .b_rsci_biwt(b_rsci_biwt),
      .b_rsci_bdwt(b_rsci_bdwt),
      .b_rsci_bcwt(b_rsci_bcwt),
      .b_rsci_idat(b_rsci_idat)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core_a_rsci
// ------------------------------------------------------------------


module mult_add_pipeline_core_a_rsci (
  clk, rst, a_rsc_dat, a_rsc_vld, a_rsc_rdy, core_wen, a_rsci_oswt, a_rsci_wen_comp,
      a_rsci_idat_mxwt
);
  input clk;
  input rst;
  input [10:0] a_rsc_dat;
  input a_rsc_vld;
  output a_rsc_rdy;
  input core_wen;
  input a_rsci_oswt;
  output a_rsci_wen_comp;
  output [10:0] a_rsci_idat_mxwt;


  // Interconnect Declarations
  wire a_rsci_biwt;
  wire a_rsci_bdwt;
  wire a_rsci_bcwt;
  wire a_rsci_irdy_core_sct;
  wire a_rsci_ivld;
  wire [10:0] a_rsci_idat;


  // Interconnect Declarations for Component Instantiations 
  ccs_in_wait_v1 #(.rscid(32'sd1),
  .width(32'sd11)) a_rsci (
      .rdy(a_rsc_rdy),
      .vld(a_rsc_vld),
      .dat(a_rsc_dat),
      .irdy(a_rsci_irdy_core_sct),
      .ivld(a_rsci_ivld),
      .idat(a_rsci_idat)
    );
  mult_add_pipeline_core_a_rsci_a_wait_ctrl mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .a_rsci_oswt(a_rsci_oswt),
      .a_rsci_biwt(a_rsci_biwt),
      .a_rsci_bdwt(a_rsci_bdwt),
      .a_rsci_bcwt(a_rsci_bcwt),
      .a_rsci_irdy_core_sct(a_rsci_irdy_core_sct),
      .a_rsci_ivld(a_rsci_ivld)
    );
  mult_add_pipeline_core_a_rsci_a_wait_dp mult_add_pipeline_core_a_rsci_a_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .a_rsci_oswt(a_rsci_oswt),
      .a_rsci_wen_comp(a_rsci_wen_comp),
      .a_rsci_idat_mxwt(a_rsci_idat_mxwt),
      .a_rsci_biwt(a_rsci_biwt),
      .a_rsci_bdwt(a_rsci_bdwt),
      .a_rsci_bcwt(a_rsci_bcwt),
      .a_rsci_idat(a_rsci_idat)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline_core
// ------------------------------------------------------------------


module mult_add_pipeline_core (
  clk, rst, a_rsc_dat, a_rsc_vld, a_rsc_rdy, b_rsc_dat, b_rsc_vld, b_rsc_rdy, c_rsc_dat,
      c_rsc_vld, c_rsc_rdy, gain_rsc_dat, gain_rsc_triosy_lz, gain_adjust_rsc_dat,
      gain_adjust_rsc_triosy_lz, result_rsc_dat, result_rsc_vld, result_rsc_rdy
);
  input clk;
  input rst;
  input [10:0] a_rsc_dat;
  input a_rsc_vld;
  output a_rsc_rdy;
  input [13:0] b_rsc_dat;
  input b_rsc_vld;
  output b_rsc_rdy;
  input [24:0] c_rsc_dat;
  input c_rsc_vld;
  output c_rsc_rdy;
  input [9:0] gain_rsc_dat;
  output gain_rsc_triosy_lz;
  input gain_adjust_rsc_dat;
  output gain_adjust_rsc_triosy_lz;
  output [29:0] result_rsc_dat;
  output result_rsc_vld;
  input result_rsc_rdy;


  // Interconnect Declarations
  wire core_wen;
  wire core_wten;
  wire a_rsci_wen_comp;
  wire [10:0] a_rsci_idat_mxwt;
  wire b_rsci_wen_comp;
  wire [13:0] b_rsci_idat_mxwt;
  wire c_rsci_wen_comp;
  wire [24:0] c_rsci_idat_mxwt;
  wire [9:0] gain_rsci_idat;
  wire gain_adjust_rsci_idat;
  wire result_rsci_wen_comp;
  reg [25:0] result_rsci_idat_29_4;
  wire [1:0] fsm_output;
  reg reg_gain_adjust_rsc_triosy_obj_iswt0_cse;
  reg reg_c_rsci_iswt0_cse;
  wire result_rsci_idat_29_4_mx0c1;
  wire [25:0] sum_sva_1;
  wire [26:0] nl_sum_sva_1;

  wire[33:0] operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl;
  wire signed [36:0] nl_operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl;
  wire[24:0] product_mul_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [29:0] nl_mult_add_pipeline_core_result_rsci_inst_result_rsci_idat;
  assign nl_mult_add_pipeline_core_result_rsci_inst_result_rsci_idat = {result_rsci_idat_29_4
      , 4'b0000};
  ccs_in_v1 #(.rscid(32'sd4),
  .width(32'sd10)) gain_rsci (
      .dat(gain_rsc_dat),
      .idat(gain_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd5),
  .width(32'sd1)) gain_adjust_rsci (
      .dat(gain_adjust_rsc_dat),
      .idat(gain_adjust_rsci_idat)
    );
  mult_add_pipeline_core_a_rsci mult_add_pipeline_core_a_rsci_inst (
      .clk(clk),
      .rst(rst),
      .a_rsc_dat(a_rsc_dat),
      .a_rsc_vld(a_rsc_vld),
      .a_rsc_rdy(a_rsc_rdy),
      .core_wen(core_wen),
      .a_rsci_oswt(reg_c_rsci_iswt0_cse),
      .a_rsci_wen_comp(a_rsci_wen_comp),
      .a_rsci_idat_mxwt(a_rsci_idat_mxwt)
    );
  mult_add_pipeline_core_b_rsci mult_add_pipeline_core_b_rsci_inst (
      .clk(clk),
      .rst(rst),
      .b_rsc_dat(b_rsc_dat),
      .b_rsc_vld(b_rsc_vld),
      .b_rsc_rdy(b_rsc_rdy),
      .core_wen(core_wen),
      .b_rsci_oswt(reg_c_rsci_iswt0_cse),
      .b_rsci_wen_comp(b_rsci_wen_comp),
      .b_rsci_idat_mxwt(b_rsci_idat_mxwt)
    );
  mult_add_pipeline_core_c_rsci mult_add_pipeline_core_c_rsci_inst (
      .clk(clk),
      .rst(rst),
      .c_rsc_dat(c_rsc_dat),
      .c_rsc_vld(c_rsc_vld),
      .c_rsc_rdy(c_rsc_rdy),
      .core_wen(core_wen),
      .c_rsci_oswt(reg_c_rsci_iswt0_cse),
      .c_rsci_wen_comp(c_rsci_wen_comp),
      .c_rsci_idat_mxwt(c_rsci_idat_mxwt)
    );
  mult_add_pipeline_core_result_rsci mult_add_pipeline_core_result_rsci_inst (
      .clk(clk),
      .rst(rst),
      .result_rsc_dat(result_rsc_dat),
      .result_rsc_vld(result_rsc_vld),
      .result_rsc_rdy(result_rsc_rdy),
      .core_wen(core_wen),
      .result_rsci_oswt(reg_gain_adjust_rsc_triosy_obj_iswt0_cse),
      .result_rsci_wen_comp(result_rsci_wen_comp),
      .result_rsci_idat(nl_mult_add_pipeline_core_result_rsci_inst_result_rsci_idat[29:0])
    );
  mult_add_pipeline_core_gain_rsc_triosy_obj mult_add_pipeline_core_gain_rsc_triosy_obj_inst
      (
      .gain_rsc_triosy_lz(gain_rsc_triosy_lz),
      .core_wten(core_wten),
      .gain_rsc_triosy_obj_iswt0(reg_gain_adjust_rsc_triosy_obj_iswt0_cse)
    );
  mult_add_pipeline_core_gain_adjust_rsc_triosy_obj mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_inst
      (
      .gain_adjust_rsc_triosy_lz(gain_adjust_rsc_triosy_lz),
      .core_wten(core_wten),
      .gain_adjust_rsc_triosy_obj_iswt0(reg_gain_adjust_rsc_triosy_obj_iswt0_cse)
    );
  mult_add_pipeline_core_staller mult_add_pipeline_core_staller_inst (
      .clk(clk),
      .rst(rst),
      .core_wen(core_wen),
      .core_wten(core_wten),
      .a_rsci_wen_comp(a_rsci_wen_comp),
      .b_rsci_wen_comp(b_rsci_wen_comp),
      .c_rsci_wen_comp(c_rsci_wen_comp),
      .result_rsci_wen_comp(result_rsci_wen_comp)
    );
  mult_add_pipeline_core_core_fsm mult_add_pipeline_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .core_wen(core_wen),
      .fsm_output(fsm_output)
    );
  assign product_mul_nl = conv_u2u_25_25(a_rsci_idat_mxwt * b_rsci_idat_mxwt);
  assign nl_sum_sva_1 = conv_u2u_25_26(product_mul_nl) + conv_u2u_25_26(c_rsci_idat_mxwt);
  assign sum_sva_1 = nl_sum_sva_1[25:0];
  assign result_rsci_idat_29_4_mx0c1 = (~ gain_adjust_rsci_idat) & (fsm_output[1]);
  always @(posedge clk) begin
    if ( rst ) begin
      result_rsci_idat_29_4 <= 26'b00000000000000000000000000;
    end
    else if ( core_wen & ((gain_adjust_rsci_idat & (fsm_output[1])) | result_rsci_idat_29_4_mx0c1)
        ) begin
      result_rsci_idat_29_4 <= MUX_v_26_2_2((readslicef_34_26_8(operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl)),
          sum_sva_1, result_rsci_idat_29_4_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_gain_adjust_rsc_triosy_obj_iswt0_cse <= 1'b0;
      reg_c_rsci_iswt0_cse <= 1'b0;
    end
    else if ( core_wen ) begin
      reg_gain_adjust_rsc_triosy_obj_iswt0_cse <= fsm_output[1];
      reg_c_rsci_iswt0_cse <= 1'b1;
    end
  end
  assign nl_operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl = $signed(conv_u2s_26_27(sum_sva_1))
      * $signed((gain_rsci_idat));
  assign operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl = nl_operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl[33:0];

  function automatic [25:0] MUX_v_26_2_2;
    input [25:0] input_0;
    input [25:0] input_1;
    input  sel;
    reg [25:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_26_2_2 = result;
  end
  endfunction


  function automatic [25:0] readslicef_34_26_8;
    input [33:0] vector;
    reg [33:0] tmp;
  begin
    tmp = vector >> 8;
    readslicef_34_26_8 = tmp[25:0];
  end
  endfunction


  function automatic [26:0] conv_u2s_26_27 ;
    input [25:0]  vector ;
  begin
    conv_u2s_26_27 =  {1'b0, vector};
  end
  endfunction


  function automatic [24:0] conv_u2u_25_25 ;
    input [24:0]  vector ;
  begin
    conv_u2u_25_25 = vector;
  end
  endfunction


  function automatic [25:0] conv_u2u_25_26 ;
    input [24:0]  vector ;
  begin
    conv_u2u_25_26 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_add_pipeline
// ------------------------------------------------------------------


module mult_add_pipeline (
  clk, rst, a_rsc_dat, a_rsc_vld, a_rsc_rdy, b_rsc_dat, b_rsc_vld, b_rsc_rdy, c_rsc_dat,
      c_rsc_vld, c_rsc_rdy, gain_rsc_dat, gain_rsc_triosy_lz, gain_adjust_rsc_dat,
      gain_adjust_rsc_triosy_lz, result_rsc_dat, result_rsc_vld, result_rsc_rdy
);
  input clk;
  input rst;
  input [10:0] a_rsc_dat;
  input a_rsc_vld;
  output a_rsc_rdy;
  input [13:0] b_rsc_dat;
  input b_rsc_vld;
  output b_rsc_rdy;
  input [24:0] c_rsc_dat;
  input c_rsc_vld;
  output c_rsc_rdy;
  input [9:0] gain_rsc_dat;
  output gain_rsc_triosy_lz;
  input gain_adjust_rsc_dat;
  output gain_adjust_rsc_triosy_lz;
  output [29:0] result_rsc_dat;
  output result_rsc_vld;
  input result_rsc_rdy;



  // Interconnect Declarations for Component Instantiations 
  mult_add_pipeline_core mult_add_pipeline_core_inst (
      .clk(clk),
      .rst(rst),
      .a_rsc_dat(a_rsc_dat),
      .a_rsc_vld(a_rsc_vld),
      .a_rsc_rdy(a_rsc_rdy),
      .b_rsc_dat(b_rsc_dat),
      .b_rsc_vld(b_rsc_vld),
      .b_rsc_rdy(b_rsc_rdy),
      .c_rsc_dat(c_rsc_dat),
      .c_rsc_vld(c_rsc_vld),
      .c_rsc_rdy(c_rsc_rdy),
      .gain_rsc_dat(gain_rsc_dat),
      .gain_rsc_triosy_lz(gain_rsc_triosy_lz),
      .gain_adjust_rsc_dat(gain_adjust_rsc_dat),
      .gain_adjust_rsc_triosy_lz(gain_adjust_rsc_triosy_lz),
      .result_rsc_dat(result_rsc_dat),
      .result_rsc_vld(result_rsc_vld),
      .result_rsc_rdy(result_rsc_rdy)
    );
endmodule



