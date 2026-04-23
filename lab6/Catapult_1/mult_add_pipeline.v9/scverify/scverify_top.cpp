#include <string>
#include <fstream>
#include <iostream>
#include "mc_testbench.h"
#include <mc_reset.h>
#include <mc_transactors.h>
#include <mc_scverify.h>
#include <mc_stall_ctrl.h>
#include <ac_read_env.h>
#include "ccs_ioport_trans_rsc_v1.h"
#include <mc_monitor.h>
#include <mc_simulator_extensions.h>
#include "mc_dut_wrapper.h"
#include "ccs_probes.cpp"
#include <mt19937ar.c>
#ifndef TO_QUOTED_STRING
#define TO_QUOTED_STRING(x) TO_QUOTED_STRING1(x)
#define TO_QUOTED_STRING1(x) #x
#endif
#ifndef TOP_HDL_ENTITY
#define TOP_HDL_ENTITY mult_add_pipeline
#endif
// Hold time for the SCVerify testbench to account for the gate delay after downstream synthesis in pico second(s)
// Hold time value is obtained from 'top_gate_constraints.cpp', which is generated at the end of RTL synthesis
#ifdef CCS_DUT_GATE
extern double __scv_hold_time;
extern double __scv_hold_time_RSCID_1;
extern double __scv_hold_time_RSCID_2;
extern double __scv_hold_time_RSCID_3;
extern double __scv_hold_time_RSCID_4;
extern double __scv_hold_time_RSCID_5;
extern double __scv_hold_time_RSCID_6;
#else
double __scv_hold_time = 0.0; // default for non-gate simulation is zero
double __scv_hold_time_RSCID_1 = 0;
double __scv_hold_time_RSCID_2 = 0;
double __scv_hold_time_RSCID_3 = 0;
double __scv_hold_time_RSCID_4 = 0;
double __scv_hold_time_RSCID_5 = 0;
double __scv_hold_time_RSCID_6 = 0;
#endif

class scverify_top : public sc_module
{
public:
  sc_signal<sc_logic>                                                   rst;
  sc_signal<sc_logic>                                                   rst_n;
  sc_signal<sc_logic>                                                   SIG_SC_LOGIC_0;
  sc_signal<sc_logic>                                                   SIG_SC_LOGIC_1;
  sc_signal<sc_logic>                                                   TLS_design_is_idle;
  sc_signal<bool>                                                       TLS_design_is_idle_reg;
  int                                                                   d_fapi_latency;
  float                                                                 d_clk_period;
  unsigned long                                                         d_max_sim_time;
  bool                                                                  d_extended;
  bool                                                                  env_SCVerify_DEADLOCK_DETECTION;
  bool                                                                  env_SCVerify_DISABLE_EMPTY_INPUTS;
  bool                                                                  env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  bool                                                                  env_SCVerify_ENABLE_RESET_TOGGLE;
  float                                                                 env_SCVerify_RESET_CYCLES;
  unsigned long                                                         env_SCVerify_MAX_SIM_TIME;
  bool                                                                  d_idle_sync_enabled;
  bool                                                                  d_disable_on_empty;
  sc_clock                                                              clk;
  mc_programmable_reset                                                 rst_driver;
  sc_signal<sc_logic>                                                   TLS_rst;
  sc_signal<sc_lv<11> >                                                 TLS_a_rsc_dat;
  sc_signal<sc_logic>                                                   TLS_a_rsc_vld;
  sc_signal<sc_logic>                                                   TLS_a_rsc_rdy;
  sc_signal<sc_lv<14> >                                                 TLS_b_rsc_dat;
  sc_signal<sc_logic>                                                   TLS_b_rsc_vld;
  sc_signal<sc_logic>                                                   TLS_b_rsc_rdy;
  sc_signal<sc_lv<25> >                                                 TLS_c_rsc_dat;
  sc_signal<sc_logic>                                                   TLS_c_rsc_vld;
  sc_signal<sc_logic>                                                   TLS_c_rsc_rdy;
  sc_signal<sc_lv<10> >                                                 TLS_gain_rsc_dat;
  sc_signal<sc_logic>                                                   TLS_gain_rsc_triosy_lz;
  sc_signal<sc_logic>                                                   TLS_gain_adjust_rsc_dat;
  sc_signal<sc_logic>                                                   TLS_gain_adjust_rsc_triosy_lz;
  sc_signal<sc_lv<30> >                                                 TLS_result_rsc_dat;
  sc_signal<sc_logic>                                                   TLS_result_rsc_vld;
  sc_signal<sc_logic>                                                   TLS_result_rsc_rdy;
  ccs_DUT_wrapper                                                       mult_add_pipeline_INST;
  ccs_in_wait_trans_rsc_v1<1,11 >                                       a_rsc_INST;
  ccs_in_wait_trans_rsc_v1<1,14 >                                       b_rsc_INST;
  ccs_in_wait_trans_rsc_v1<1,25 >                                       c_rsc_INST;
  ccs_out_wait_trans_rsc_v1<1,30 >                                      result_rsc_INST;
  ccs_in_trans_rsc_v1<1,10 >                                            gain_rsc_INST;
  sc_signal<sc_lv<1> >                                                  CCS_ADAPTOR_gain_adjust_rsc_dat;
  ccs_sc_lv1_to_sc_logic_adapter                                        CCS_ADAPTOR_TLS_gain_adjust_rsc_dat;
  ccs_in_trans_rsc_v1<1,1 >                                             gain_adjust_rsc_INST;
  tlm::tlm_fifo<ac_int<11, false > >                                    TLS_in_fifo_a;
  tlm::tlm_fifo<mc_wait_ctrl>                                           TLS_in_wait_ctrl_fifo_a;
  tlm::tlm_fifo<int>                                                    TLS_in_fifo_a_sizecount;
  sc_signal<sc_logic>                                                   TLS_a_rsc_trdone;
  mc_channel_input_transactor<ac_int<11, false >,11,false>              transactor_a;
  tlm::tlm_fifo<ac_int<14, false > >                                    TLS_in_fifo_b;
  tlm::tlm_fifo<mc_wait_ctrl>                                           TLS_in_wait_ctrl_fifo_b;
  tlm::tlm_fifo<int>                                                    TLS_in_fifo_b_sizecount;
  sc_signal<sc_logic>                                                   TLS_b_rsc_trdone;
  mc_channel_input_transactor<ac_int<14, false >,14,false>              transactor_b;
  tlm::tlm_fifo<ac_int<25, false > >                                    TLS_in_fifo_c;
  tlm::tlm_fifo<mc_wait_ctrl>                                           TLS_in_wait_ctrl_fifo_c;
  tlm::tlm_fifo<int>                                                    TLS_in_fifo_c_sizecount;
  sc_signal<sc_logic>                                                   TLS_c_rsc_trdone;
  mc_channel_input_transactor<ac_int<25, false >,25,false>              transactor_c;
  tlm::tlm_fifo<ac_int<30, false > >                                    TLS_out_fifo_result;
  tlm::tlm_fifo<mc_wait_ctrl>                                           TLS_out_wait_ctrl_fifo_result;
  sc_signal<sc_logic>                                                   TLS_result_rsc_trdone;
  mc_output_transactor<ac_int<30, false >,30,false>                     transactor_result;
  tlm::tlm_fifo<ac_fixed<10, 2, true, AC_TRN, AC_WRAP > >               TLS_in_fifo_gain;
  tlm::tlm_fifo<mc_wait_ctrl>                                           TLS_in_wait_ctrl_fifo_gain;
  mc_trios_input_monitor                                                trios_monitor_gain_rsc_triosy_lz_INST;
  mc_input_transactor<ac_fixed<10, 2, true, AC_TRN, AC_WRAP >,10,true>  transactor_gain;
  tlm::tlm_fifo<bool >                                                  TLS_in_fifo_gain_adjust;
  tlm::tlm_fifo<mc_wait_ctrl>                                           TLS_in_wait_ctrl_fifo_gain_adjust;
  mc_trios_input_monitor                                                trios_monitor_gain_adjust_rsc_triosy_lz_INST;
  mc_input_transactor<bool,1,false>                                     transactor_gain_adjust;
  mc_testbench                                                          testbench_INST;
  sc_signal<sc_logic>                                                   catapult_start;
  sc_signal<sc_logic>                                                   catapult_done;
  sc_signal<sc_logic>                                                   catapult_ready;
  sc_signal<sc_logic>                                                   in_sync;
  sc_signal<sc_logic>                                                   out_sync;
  sc_signal<sc_logic>                                                   inout_sync;
  sc_signal<unsigned>                                                   wait_for_init;
  sync_generator                                                        sync_generator_INST;
  catapult_monitor                                                      catapult_monitor_INST;
  ccs_probe_monitor                                                    *ccs_probe_monitor_INST;
  sc_event                                                              generate_reset_event;
  sc_event                                                              deadlock_event;
  sc_signal<sc_logic>                                                   deadlocked;
  sc_signal<sc_logic>                                                   maxsimtime;
  sc_event                                                              max_sim_time_event;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_staller_inst_core_wen;
  sc_signal<sc_logic>                                                   OFS_a_rsc_vld;
  sc_signal<sc_logic>                                                   OFS_b_rsc_vld;
  sc_signal<sc_logic>                                                   OFS_c_rsc_vld;
  sc_signal<sc_logic>                                                   OFS_result_rsc_rdy;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_a_rsci_inst_mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst_a_rsci_irdy_core_sct;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_a_rsci_inst_mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst_a_rsci_ivld;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_b_rsci_inst_mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst_b_rsci_irdy_core_sct;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_b_rsci_inst_mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst_b_rsci_ivld;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_c_rsci_inst_mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst_c_rsci_irdy_core_sct;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_c_rsci_inst_mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst_c_rsci_ivld;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_result_rsci_inst_mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst_result_rsci_irdy;
  sc_signal<sc_logic>                                                   OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_result_rsci_inst_mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst_result_rsci_ivld_core_sct;
  sc_signal<sc_logic>                                                   TLS_enable_stalls;
  sc_signal<unsigned short>                                             TLS_stall_coverage;
  bool                                                                  var_trdone;

  void read_env();
  void TLS_rst_method();
  void drive_TLS_a_rsc_trdone();
  void drive_TLS_b_rsc_trdone();
  void drive_TLS_c_rsc_trdone();
  void drive_TLS_result_rsc_trdone();
  void max_sim_time_notify();
  void start_of_simulation();
  void setup_debug();
  void debug(const char* varname, int flags, int count);
  void generate_reset();
  void install_observe_foreign_signals();
  void deadlock_watch();
  void deadlock_notify();
  void drive_idle_reg();
  void idle_watch();

  // Constructor
  SC_HAS_PROCESS(scverify_top);
  scverify_top(const sc_module_name& name)
    : rst("rst")
    , rst_n("rst_n")
    , SIG_SC_LOGIC_0("SIG_SC_LOGIC_0")
    , SIG_SC_LOGIC_1("SIG_SC_LOGIC_1")
    , TLS_design_is_idle("TLS_design_is_idle")
    , TLS_design_is_idle_reg("TLS_design_is_idle_reg")
    , CCS_CLK_CTOR(clk, "clk", 7.69, SC_NS, 0.5, 0, SC_NS, false)
    , rst_driver("rst_driver", ac_env::read_float("SCVerify_RESET_CYCLES")*7.690000, false)
    , TLS_rst("TLS_rst")
    , TLS_a_rsc_dat("TLS_a_rsc_dat")
    , TLS_a_rsc_vld("TLS_a_rsc_vld")
    , TLS_a_rsc_rdy("TLS_a_rsc_rdy")
    , TLS_b_rsc_dat("TLS_b_rsc_dat")
    , TLS_b_rsc_vld("TLS_b_rsc_vld")
    , TLS_b_rsc_rdy("TLS_b_rsc_rdy")
    , TLS_c_rsc_dat("TLS_c_rsc_dat")
    , TLS_c_rsc_vld("TLS_c_rsc_vld")
    , TLS_c_rsc_rdy("TLS_c_rsc_rdy")
    , TLS_gain_rsc_dat("TLS_gain_rsc_dat")
    , TLS_gain_rsc_triosy_lz("TLS_gain_rsc_triosy_lz")
    , TLS_gain_adjust_rsc_dat("TLS_gain_adjust_rsc_dat")
    , TLS_gain_adjust_rsc_triosy_lz("TLS_gain_adjust_rsc_triosy_lz")
    , TLS_result_rsc_dat("TLS_result_rsc_dat")
    , TLS_result_rsc_vld("TLS_result_rsc_vld")
    , TLS_result_rsc_rdy("TLS_result_rsc_rdy")
    , mult_add_pipeline_INST("rtl", TO_QUOTED_STRING(TOP_HDL_ENTITY))
    , a_rsc_INST("a_rsc", true)
    , b_rsc_INST("b_rsc", true)
    , c_rsc_INST("c_rsc", true)
    , result_rsc_INST("result_rsc", true)
    , gain_rsc_INST("gain_rsc", true)
    , CCS_ADAPTOR_TLS_gain_adjust_rsc_dat("CCS_ADAPTOR_TLS_gain_adjust_rsc_dat")
    , gain_adjust_rsc_INST("gain_adjust_rsc", true)
    , TLS_in_fifo_a("TLS_in_fifo_a", -1)
    , TLS_in_wait_ctrl_fifo_a("TLS_in_wait_ctrl_fifo_a", -1)
    , TLS_in_fifo_a_sizecount("TLS_in_fifo_a_sizecount", 1)
    , TLS_a_rsc_trdone("TLS_a_rsc_trdone")
    , transactor_a("transactor_a", 0, 11, 0, d_disable_on_empty)
    , TLS_in_fifo_b("TLS_in_fifo_b", -1)
    , TLS_in_wait_ctrl_fifo_b("TLS_in_wait_ctrl_fifo_b", -1)
    , TLS_in_fifo_b_sizecount("TLS_in_fifo_b_sizecount", 1)
    , TLS_b_rsc_trdone("TLS_b_rsc_trdone")
    , transactor_b("transactor_b", 0, 14, 0, d_disable_on_empty)
    , TLS_in_fifo_c("TLS_in_fifo_c", -1)
    , TLS_in_wait_ctrl_fifo_c("TLS_in_wait_ctrl_fifo_c", -1)
    , TLS_in_fifo_c_sizecount("TLS_in_fifo_c_sizecount", 1)
    , TLS_c_rsc_trdone("TLS_c_rsc_trdone")
    , transactor_c("transactor_c", 0, 25, 0, d_disable_on_empty)
    , TLS_out_fifo_result("TLS_out_fifo_result", -1)
    , TLS_out_wait_ctrl_fifo_result("TLS_out_wait_ctrl_fifo_result", -1)
    , TLS_result_rsc_trdone("TLS_result_rsc_trdone")
    , transactor_result("transactor_result", 0, 30, 0)
    , TLS_in_fifo_gain("TLS_in_fifo_gain", -1)
    , TLS_in_wait_ctrl_fifo_gain("TLS_in_wait_ctrl_fifo_gain", -1)
    , trios_monitor_gain_rsc_triosy_lz_INST("trios_monitor_gain_rsc_triosy_lz_INST")
    , transactor_gain("transactor_gain", 0, 10, 0, d_disable_on_empty)
    , TLS_in_fifo_gain_adjust("TLS_in_fifo_gain_adjust", -1)
    , TLS_in_wait_ctrl_fifo_gain_adjust("TLS_in_wait_ctrl_fifo_gain_adjust", -1)
    , trios_monitor_gain_adjust_rsc_triosy_lz_INST("trios_monitor_gain_adjust_rsc_triosy_lz_INST")
    , transactor_gain_adjust("transactor_gain_adjust", 0, 1, 0, d_disable_on_empty)
    , testbench_INST("user_tb")
    , catapult_start("catapult_start")
    , catapult_done("catapult_done")
    , catapult_ready("catapult_ready")
    , in_sync("in_sync")
    , out_sync("out_sync")
    , inout_sync("inout_sync")
    , wait_for_init("wait_for_init")
    , sync_generator_INST("sync_generator", true, false, false, false, 5, 5, 0)
    , catapult_monitor_INST("Monitor", clk, true, 5LL, 1LL)
    , ccs_probe_monitor_INST(NULL)
    , deadlocked("deadlocked")
    , maxsimtime("maxsimtime")
    , var_trdone(false)
  {
    read_env();

    rst_driver.reset_out(TLS_rst);

    mult_add_pipeline_INST.clk(clk);
    mult_add_pipeline_INST.rst(TLS_rst);
    mult_add_pipeline_INST.a_rsc_dat(TLS_a_rsc_dat);
    mult_add_pipeline_INST.a_rsc_vld(TLS_a_rsc_vld);
    mult_add_pipeline_INST.a_rsc_rdy(TLS_a_rsc_rdy);
    mult_add_pipeline_INST.b_rsc_dat(TLS_b_rsc_dat);
    mult_add_pipeline_INST.b_rsc_vld(TLS_b_rsc_vld);
    mult_add_pipeline_INST.b_rsc_rdy(TLS_b_rsc_rdy);
    mult_add_pipeline_INST.c_rsc_dat(TLS_c_rsc_dat);
    mult_add_pipeline_INST.c_rsc_vld(TLS_c_rsc_vld);
    mult_add_pipeline_INST.c_rsc_rdy(TLS_c_rsc_rdy);
    mult_add_pipeline_INST.gain_rsc_dat(TLS_gain_rsc_dat);
    mult_add_pipeline_INST.gain_rsc_triosy_lz(TLS_gain_rsc_triosy_lz);
    mult_add_pipeline_INST.gain_adjust_rsc_dat(TLS_gain_adjust_rsc_dat);
    mult_add_pipeline_INST.gain_adjust_rsc_triosy_lz(TLS_gain_adjust_rsc_triosy_lz);
    mult_add_pipeline_INST.result_rsc_dat(TLS_result_rsc_dat);
    mult_add_pipeline_INST.result_rsc_vld(TLS_result_rsc_vld);
    mult_add_pipeline_INST.result_rsc_rdy(TLS_result_rsc_rdy);

    a_rsc_INST.rdy(TLS_a_rsc_rdy);
    a_rsc_INST.vld(TLS_a_rsc_vld);
    a_rsc_INST.dat(TLS_a_rsc_dat);
    a_rsc_INST.clk(clk);
    a_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_1)));

    b_rsc_INST.rdy(TLS_b_rsc_rdy);
    b_rsc_INST.vld(TLS_b_rsc_vld);
    b_rsc_INST.dat(TLS_b_rsc_dat);
    b_rsc_INST.clk(clk);
    b_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_2)));

    c_rsc_INST.rdy(TLS_c_rsc_rdy);
    c_rsc_INST.vld(TLS_c_rsc_vld);
    c_rsc_INST.dat(TLS_c_rsc_dat);
    c_rsc_INST.clk(clk);
    c_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_3)));

    result_rsc_INST.rdy(TLS_result_rsc_rdy);
    result_rsc_INST.vld(TLS_result_rsc_vld);
    result_rsc_INST.dat(TLS_result_rsc_dat);
    result_rsc_INST.clk(clk);
    result_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_6)));

    gain_rsc_INST.dat(TLS_gain_rsc_dat);
    gain_rsc_INST.clk(clk);
    gain_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_4)));

    CCS_ADAPTOR_TLS_gain_adjust_rsc_dat.inVECTOR(CCS_ADAPTOR_gain_adjust_rsc_dat);
    CCS_ADAPTOR_TLS_gain_adjust_rsc_dat.outSCALAR(TLS_gain_adjust_rsc_dat);

    gain_adjust_rsc_INST.dat(CCS_ADAPTOR_gain_adjust_rsc_dat);
    gain_adjust_rsc_INST.clk(clk);
    gain_adjust_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_5)));

    transactor_a.in_fifo(TLS_in_fifo_a);
    transactor_a.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_a);
    transactor_a.sizecount_fifo(TLS_in_fifo_a_sizecount);
    transactor_a.set_disable_on_empty(d_disable_on_empty);
    transactor_a.bind_clk(clk, true, rst);
    transactor_a.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_a.register_block(&a_rsc_INST, a_rsc_INST.basename(), TLS_a_rsc_trdone, 0, 0, 1);

    transactor_b.in_fifo(TLS_in_fifo_b);
    transactor_b.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_b);
    transactor_b.sizecount_fifo(TLS_in_fifo_b_sizecount);
    transactor_b.set_disable_on_empty(d_disable_on_empty);
    transactor_b.bind_clk(clk, true, rst);
    transactor_b.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_b.register_block(&b_rsc_INST, b_rsc_INST.basename(), TLS_b_rsc_trdone, 0, 0, 1);

    transactor_c.in_fifo(TLS_in_fifo_c);
    transactor_c.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_c);
    transactor_c.sizecount_fifo(TLS_in_fifo_c_sizecount);
    transactor_c.set_disable_on_empty(d_disable_on_empty);
    transactor_c.bind_clk(clk, true, rst);
    transactor_c.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_c.register_block(&c_rsc_INST, c_rsc_INST.basename(), TLS_c_rsc_trdone, 0, 0, 1);

    transactor_result.out_fifo(TLS_out_fifo_result);
    transactor_result.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_result);
    transactor_result.bind_clk(clk, true, rst);
    transactor_result.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_result.register_block(&result_rsc_INST, result_rsc_INST.basename(), TLS_result_rsc_trdone, 0, 0,
        1);

    trios_monitor_gain_rsc_triosy_lz_INST.trios(TLS_gain_rsc_triosy_lz);
    trios_monitor_gain_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_gain.in_fifo(TLS_in_fifo_gain);
    transactor_gain.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_gain);
    transactor_gain.set_disable_on_empty(d_disable_on_empty);
    transactor_gain.bind_clk(clk, true, rst);
    transactor_gain.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_gain.register_block(&gain_rsc_INST, gain_rsc_INST.basename(), TLS_gain_rsc_triosy_lz, 0, 0, 1);

    trios_monitor_gain_adjust_rsc_triosy_lz_INST.trios(TLS_gain_adjust_rsc_triosy_lz);
    trios_monitor_gain_adjust_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_gain_adjust.in_fifo(TLS_in_fifo_gain_adjust);
    transactor_gain_adjust.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_gain_adjust);
    transactor_gain_adjust.set_disable_on_empty(d_disable_on_empty);
    transactor_gain_adjust.bind_clk(clk, true, rst);
    transactor_gain_adjust.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_gain_adjust.register_block(&gain_adjust_rsc_INST, gain_adjust_rsc_INST.basename(), TLS_gain_adjust_rsc_triosy_lz,
        0, 0, 1);

    testbench_INST.clk(clk);
    testbench_INST.ccs_a(TLS_in_fifo_a);
    testbench_INST.ccs_wait_ctrl_a(TLS_in_wait_ctrl_fifo_a);
    testbench_INST.ccs_sizecount_a(TLS_in_fifo_a_sizecount);
    testbench_INST.ccs_b(TLS_in_fifo_b);
    testbench_INST.ccs_wait_ctrl_b(TLS_in_wait_ctrl_fifo_b);
    testbench_INST.ccs_sizecount_b(TLS_in_fifo_b_sizecount);
    testbench_INST.ccs_c(TLS_in_fifo_c);
    testbench_INST.ccs_wait_ctrl_c(TLS_in_wait_ctrl_fifo_c);
    testbench_INST.ccs_sizecount_c(TLS_in_fifo_c_sizecount);
    testbench_INST.ccs_result(TLS_out_fifo_result);
    testbench_INST.ccs_wait_ctrl_result(TLS_out_wait_ctrl_fifo_result);
    testbench_INST.ccs_gain(TLS_in_fifo_gain);
    testbench_INST.ccs_wait_ctrl_gain(TLS_in_wait_ctrl_fifo_gain);
    testbench_INST.ccs_gain_adjust(TLS_in_fifo_gain_adjust);
    testbench_INST.ccs_wait_ctrl_gain_adjust(TLS_in_wait_ctrl_fifo_gain_adjust);
    testbench_INST.design_is_idle(TLS_design_is_idle_reg);
    testbench_INST.enable_stalls(TLS_enable_stalls);
    testbench_INST.stall_coverage(TLS_stall_coverage);

    sync_generator_INST.clk(clk);
    sync_generator_INST.rst(rst);
    sync_generator_INST.in_sync(in_sync);
    sync_generator_INST.out_sync(out_sync);
    sync_generator_INST.inout_sync(inout_sync);
    sync_generator_INST.wait_for_init(wait_for_init);
    sync_generator_INST.catapult_start(catapult_start);
    sync_generator_INST.catapult_ready(catapult_ready);
    sync_generator_INST.catapult_done(catapult_done);

    catapult_monitor_INST.rst(rst);


    SC_METHOD(TLS_rst_method);
      sensitive_pos << TLS_rst;
      dont_initialize();

    SC_METHOD(drive_TLS_a_rsc_trdone);
      sensitive << TLS_a_rsc_rdy;
      sensitive << TLS_a_rsc_vld;
      sensitive << rst;

    SC_METHOD(drive_TLS_b_rsc_trdone);
      sensitive << TLS_b_rsc_rdy;
      sensitive << TLS_b_rsc_vld;
      sensitive << rst;

    SC_METHOD(drive_TLS_c_rsc_trdone);
      sensitive << TLS_c_rsc_rdy;
      sensitive << TLS_c_rsc_vld;
      sensitive << rst;

    SC_METHOD(drive_TLS_result_rsc_trdone);
      sensitive << TLS_result_rsc_vld;
      sensitive << TLS_result_rsc_rdy;

    SC_METHOD(max_sim_time_notify);
      sensitive << max_sim_time_event;
      dont_initialize();

    SC_METHOD(generate_reset);
      sensitive << generate_reset_event;
      sensitive << testbench_INST.reset_request_event;

    SC_METHOD(deadlock_watch);
      sensitive << clk;
      sensitive << OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_staller_inst_core_wen;
      dont_initialize();

    SC_METHOD(deadlock_notify);
      sensitive << deadlock_event;
      dont_initialize();

    SC_METHOD(drive_idle_reg);
      sensitive << clk;

    SC_METHOD(idle_watch);
      sensitive << OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_staller_inst_core_wen;
      sensitive << TLS_gain_rsc_triosy_lz;
      sensitive << TLS_gain_adjust_rsc_triosy_lz;
      dont_initialize();


    #if defined(CCS_SCVERIFY) && defined(CCS_DUT_RTL) && !defined(CCS_DUT_SYSC) && !defined(CCS_SYSC) && !defined(CCS_DUT_POWER)
        ccs_probe_monitor_INST = new ccs_probe_monitor("ccs_probe_monitor");
    ccs_probe_monitor_INST->clk(clk);
    ccs_probe_monitor_INST->rst(rst);
    #endif
    SIG_SC_LOGIC_0.write(SC_LOGIC_0);
    SIG_SC_LOGIC_1.write(SC_LOGIC_1);
    mt19937_init_genrand(19650218UL);
    install_observe_foreign_signals();
  }
};
void scverify_top::read_env() {
  d_fapi_latency = 3;
  env_SCVerify_DEADLOCK_DETECTION = ac_env::read_bool("SCVerify_DEADLOCK_DETECTION",false);
  env_SCVerify_DISABLE_EMPTY_INPUTS = ac_env::read_bool("SCVerify_DISABLE_EMPTY_INPUTS",false);
  env_SCVerify_IDLE_SYNCHRONIZATION_MODE = ac_env::read_bool("SCVerify_IDLE_SYNCHRONIZATION_MODE",false);
  env_SCVerify_ENABLE_RESET_TOGGLE = ac_env::read_bool("SCVerify_ENABLE_RESET_TOGGLE",false);
  env_SCVerify_RESET_CYCLES = ac_env::read_float("SCVerify_RESET_CYCLES",2.0);
  env_SCVerify_MAX_SIM_TIME = ac_env::read_int("SCVerify_MAX_SIM_TIME",0);
  d_idle_sync_enabled = env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  d_disable_on_empty = env_SCVerify_DISABLE_EMPTY_INPUTS || env_SCVerify_IDLE_SYNCHRONIZATION_MODE;
  d_clk_period = 7.690000;
  unsigned long trcnt = 1;
  if (env_SCVerify_ENABLE_RESET_TOGGLE) { trcnt = ceil(env_SCVerify_RESET_CYCLES+0.5)*3; }
  d_max_sim_time = env_SCVerify_MAX_SIM_TIME;
  unsigned long wait_for_cycles = (d_fapi_latency ? d_fapi_latency : 1) * 9 + trcnt;
  unsigned long wait_time = ceil(d_clk_period) * wait_for_cycles;
  d_extended = false;
  if ((d_max_sim_time > 0) && (wait_time > d_max_sim_time)) {
  d_max_sim_time = wait_time;
  d_extended = true;
  }
}

void scverify_top::TLS_rst_method() {
  std::ostringstream msg;
  msg << "TLS_rst active @ " << sc_time_stamp();
  SC_REPORT_INFO("HW reset", msg.str().c_str());
  a_rsc_INST.clear();
  b_rsc_INST.clear();
  c_rsc_INST.clear();
  result_rsc_INST.clear();
  gain_rsc_INST.clear();
  gain_adjust_rsc_INST.clear();
}

void scverify_top::drive_TLS_a_rsc_trdone() {
  if (rst.read()==sc_dt::Log_1) { assert(TLS_a_rsc_rdy.read()!= SC_LOGIC_1); }
  TLS_a_rsc_trdone.write(TLS_a_rsc_rdy.read() & TLS_a_rsc_vld.read() & ~rst.read());
}

void scverify_top::drive_TLS_b_rsc_trdone() {
  if (rst.read()==sc_dt::Log_1) { assert(TLS_b_rsc_rdy.read()!= SC_LOGIC_1); }
  TLS_b_rsc_trdone.write(TLS_b_rsc_rdy.read() & TLS_b_rsc_vld.read() & ~rst.read());
}

void scverify_top::drive_TLS_c_rsc_trdone() {
  if (rst.read()==sc_dt::Log_1) { assert(TLS_c_rsc_rdy.read()!= SC_LOGIC_1); }
  TLS_c_rsc_trdone.write(TLS_c_rsc_rdy.read() & TLS_c_rsc_vld.read() & ~rst.read());
}

void scverify_top::drive_TLS_result_rsc_trdone() {
  if (rst.read()==sc_dt::Log_1) { assert(TLS_result_rsc_vld.read()!= SC_LOGIC_1); }
  TLS_result_rsc_trdone.write(TLS_result_rsc_vld.read() & TLS_result_rsc_rdy.read());
}

void scverify_top::max_sim_time_notify() {
  testbench_INST.set_failed(true);
  testbench_INST.check_results();
  SC_REPORT_ERROR("System", "Specified maximum simulation time reached");
  sc_stop();
}

void scverify_top::start_of_simulation() {
  char *SCVerify_AUTOWAIT = getenv("SCVerify_AUTOWAIT");
  if (SCVerify_AUTOWAIT) {
    int l = atoi(SCVerify_AUTOWAIT);
    transactor_a.set_auto_wait_limit(l);
    transactor_b.set_auto_wait_limit(l);
    transactor_c.set_auto_wait_limit(l);
    transactor_result.set_auto_wait_limit(l);
    transactor_gain.set_auto_wait_limit(l);
    transactor_gain_adjust.set_auto_wait_limit(l);
  }
  if (d_max_sim_time>0) max_sim_time_event.notify(d_max_sim_time,SC_NS);
}

void scverify_top::setup_debug() {
#ifdef MC_DEFAULT_TRANSACTOR_LOG
  static int transactor_a_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_b_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_c_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_result_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_gain_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_gain_adjust_flags = MC_DEFAULT_TRANSACTOR_LOG;
#else
  static int transactor_a_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_b_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_c_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_result_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_gain_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
  static int transactor_gain_adjust_flags = (d_disable_on_empty ? 0 : MC_TRANSACTOR_UNDERFLOW) | MC_TRANSACTOR_WAIT;
#endif
  static int transactor_a_count = -1;
  static int transactor_b_count = -1;
  static int transactor_c_count = -1;
  static int transactor_result_count = -1;
  static int transactor_gain_count = -1;
  static int transactor_gain_adjust_count = -1;

  // At the breakpoint, modify the local variables
  // above to turn on/off different levels of transaction
  // logging for each variable. Available flags are:
  //   MC_TRANSACTOR_EMPTY       - log empty FIFOs (on by default)
  //   MC_TRANSACTOR_UNDERFLOW   - log FIFOs that run empty and then are loaded again (off)
  //   MC_TRANSACTOR_READ        - log all read events
  //   MC_TRANSACTOR_WRITE       - log all write events
  //   MC_TRANSACTOR_LOAD        - log all FIFO load events
  //   MC_TRANSACTOR_DUMP        - log all FIFO dump events
  //   MC_TRANSACTOR_STREAMCNT   - log all streamed port index counter events
  //   MC_TRANSACTOR_WAIT        - log user specified handshake waits
  //   MC_TRANSACTOR_SIZE        - log input FIFO size updates

  std::ifstream debug_cmds;
  debug_cmds.open("scverify.cmd",std::fstream::in);
  if (debug_cmds.is_open()) {
    std::cout << "Reading SCVerify debug commands from file 'scverify.cmd'" << std::endl;
    std::string line;
    while (getline(debug_cmds,line)) {
      std::size_t pos1 = line.find(" ");
      if (pos1 == std::string::npos) continue;
      std::size_t pos2 = line.find(" ", pos1+1);
      std::string varname = line.substr(0,pos1);
      std::string flags = line.substr(pos1+1,pos2-pos1-1);
      std::string count = line.substr(pos2+1);
      debug(varname.c_str(),std::atoi(flags.c_str()),std::atoi(count.c_str()));
    }
    debug_cmds.close();
  } else {
    debug("transactor_a",transactor_a_flags,transactor_a_count);
    debug("transactor_b",transactor_b_flags,transactor_b_count);
    debug("transactor_c",transactor_c_flags,transactor_c_count);
    debug("transactor_result",transactor_result_flags,transactor_result_count);
    debug("transactor_gain",transactor_gain_flags,transactor_gain_count);
    debug("transactor_gain_adjust",transactor_gain_adjust_flags,transactor_gain_adjust_count);
  }
}

void scverify_top::debug(const char* varname, int flags, int count) {
  sc_module *xlator_p = 0;
  sc_attr_base *debug_attr_p = 0;
  if (strcmp(varname,"transactor_a") == 0)
    xlator_p = &transactor_a;
  if (strcmp(varname,"transactor_b") == 0)
    xlator_p = &transactor_b;
  if (strcmp(varname,"transactor_c") == 0)
    xlator_p = &transactor_c;
  if (strcmp(varname,"transactor_result") == 0)
    xlator_p = &transactor_result;
  if (strcmp(varname,"transactor_gain") == 0)
    xlator_p = &transactor_gain;
  if (strcmp(varname,"transactor_gain_adjust") == 0)
    xlator_p = &transactor_gain_adjust;
  if (xlator_p) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_EVENT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_EVENT",flags);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = flags;
  }

  if (count>=0) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_COUNT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_COUNT",count);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = count;
  }
}

// Process: SC_METHOD generate_reset
void scverify_top::generate_reset() {
  static bool activate_reset = true;
  static bool toggle_hw_reset = ac_env::read_bool("SCVerify_ENABLE_RESET_TOGGLE");
  if (activate_reset || sc_time_stamp() == SC_ZERO_TIME) {
    setup_debug();
    activate_reset = false;
    rst.write(SC_LOGIC_1);
    rst_driver.reset_driver();
    generate_reset_event.notify(env_SCVerify_RESET_CYCLES*7.690000, SC_NS);
  } else {
    if (toggle_hw_reset) {
      toggle_hw_reset = false;
      generate_reset_event.notify(env_SCVerify_RESET_CYCLES*7.690000, SC_NS);
    } else {
      transactor_a.reset_streams();
      transactor_b.reset_streams();
      transactor_c.reset_streams();
      transactor_result.reset_streams();
      transactor_gain.reset_streams();
      transactor_gain_adjust.reset_streams();
      rst.write(SC_LOGIC_0);
    }
    activate_reset = true;
  }
}

void scverify_top::install_observe_foreign_signals() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_staller_inst_core_wen, /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_staller_inst/core_wen);
  OBSERVE_FOREIGN_SIGNAL(OFS_a_rsc_vld, /scverify_top/rtl/a_rsc_vld);
  OBSERVE_FOREIGN_SIGNAL(OFS_b_rsc_vld, /scverify_top/rtl/b_rsc_vld);
  OBSERVE_FOREIGN_SIGNAL(OFS_c_rsc_vld, /scverify_top/rtl/c_rsc_vld);
  OBSERVE_FOREIGN_SIGNAL(OFS_result_rsc_rdy, /scverify_top/rtl/result_rsc_rdy);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_a_rsci_inst_mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst_a_rsci_irdy_core_sct,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_a_rsci_inst/mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst/a_rsci_irdy_core_sct);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_a_rsci_inst_mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst_a_rsci_ivld,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_a_rsci_inst/mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst/a_rsci_ivld);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_b_rsci_inst_mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst_b_rsci_irdy_core_sct,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_b_rsci_inst/mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst/b_rsci_irdy_core_sct);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_b_rsci_inst_mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst_b_rsci_ivld,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_b_rsci_inst/mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst/b_rsci_ivld);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_c_rsci_inst_mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst_c_rsci_irdy_core_sct,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_c_rsci_inst/mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst/c_rsci_irdy_core_sct);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_c_rsci_inst_mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst_c_rsci_ivld,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_c_rsci_inst/mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst/c_rsci_ivld);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_result_rsci_inst_mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst_result_rsci_irdy,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_result_rsci_inst/mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst/result_rsci_irdy);
  OBSERVE_FOREIGN_SIGNAL(OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_result_rsci_inst_mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst_result_rsci_ivld_core_sct,
      /scverify_top/rtl/mult_add_pipeline_core_inst/mult_add_pipeline_core_result_rsci_inst/mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst/result_rsci_ivld_core_sct);
#endif
#endif
}

void scverify_top::deadlock_watch() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  if (!clk) {
    if (rst == SC_LOGIC_0 &&
      (OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_staller_inst_core_wen.read() == SC_LOGIC_0)
      && (OFS_a_rsc_vld.read() == SC_LOGIC_1)
      && (OFS_b_rsc_vld.read() == SC_LOGIC_1)
      && (OFS_c_rsc_vld.read() == SC_LOGIC_1)
      && (OFS_result_rsc_rdy.read() == SC_LOGIC_1)
    ) {
      deadlocked.write(SC_LOGIC_1);
      deadlock_event.notify(224, SC_NS);
    } else {
      if (deadlocked.read() == SC_LOGIC_1)
        deadlock_event.cancel();
      deadlocked.write(SC_LOGIC_0);
    }
  }
#endif
#endif
#endif
}

void scverify_top::deadlock_notify() {
  if (deadlocked.read() == SC_LOGIC_1) {
    testbench_INST.check_results();
    SC_REPORT_ERROR("System", "Simulation deadlock detected");
    sc_stop();
  }
}

void scverify_top::drive_idle_reg() {
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  static unsigned short wait_for_idle_buf;
  if (clk.read() == SC_LOGIC_1 && rst.read() == SC_LOGIC_0) {
    if (TLS_design_is_idle.read() == SC_LOGIC_1) {
      wait_for_idle_buf++;
    } else {
      wait_for_idle_buf = 0;
    }
    if (wait_for_idle_buf >= testbench::idle_sync_stable_cycles) {
      TLS_design_is_idle_reg.write(true);
      if (var_trdone) var_trdone = false;
      wait_for_idle_buf = 0;
    } else {
      TLS_design_is_idle_reg.write(false);
    }
  }
#endif
}

void scverify_top::idle_watch() {
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
  bool X = (OFS_mult_add_pipeline_core_inst_mult_add_pipeline_core_staller_inst_core_wen.read()==0);
  bool Y = (TLS_gain_rsc_triosy_lz.read()==SC_LOGIC_1) || (TLS_gain_adjust_rsc_triosy_lz.read()==SC_LOGIC_1);
  var_trdone = X || Y;
  TLS_design_is_idle.write(var_trdone ? SC_LOGIC_1 : SC_LOGIC_0);
#endif
}

#if defined(MC_SIMULATOR_OSCI) || defined(MC_SIMULATOR_VCS)
int sc_main(int argc, char *argv[]) {
  sc_report_handler::set_actions("/IEEE_Std_1666/deprecated", SC_DO_NOTHING);
  scverify_top scverify_top("scverify_top");
  sc_start();
  return scverify_top.testbench_INST.failed();
}
#else
MC_MODULE_EXPORT(scverify_top);
#endif
