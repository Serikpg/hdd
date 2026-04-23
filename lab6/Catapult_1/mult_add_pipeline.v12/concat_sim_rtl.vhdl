
--------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/ccs_in_wait_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_in_wait_pkg_v1 IS

COMPONENT ccs_in_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    idat   : OUT std_logic_vector(width-1 DOWNTO 0);
    rdy    : OUT std_logic;
    ivld   : OUT std_logic;
    dat    : IN  std_logic_vector(width-1 DOWNTO 0);
    irdy   : IN  std_logic;
    vld    : IN  std_logic
   );
END COMPONENT;

END ccs_in_wait_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_in_wait_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    idat  : OUT std_logic_vector(width-1 DOWNTO 0);
    rdy   : OUT std_logic;
    ivld  : OUT std_logic;
    dat   : IN  std_logic_vector(width-1 DOWNTO 0);
    irdy  : IN  std_logic;
    vld   : IN  std_logic
  );
END ccs_in_wait_v1;

ARCHITECTURE beh OF ccs_in_wait_v1 IS
  constant stall_const : std_logic := '0';
  SIGNAL stall_ctrl : std_logic;
BEGIN
  stall_ctrl <= stall_const;

  idat <= dat;
  rdy  <= irdy and not stall_ctrl;
  ivld <= vld and not stall_ctrl;

END beh;


--------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/ccs_out_wait_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_out_wait_pkg_v1 IS

COMPONENT ccs_out_wait_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    dat    : OUT std_logic_vector(width-1 DOWNTO 0);
    irdy   : OUT std_logic;
    vld    : OUT std_logic;
    idat   : IN  std_logic_vector(width-1 DOWNTO 0);
    rdy    : IN  std_logic;
    ivld   : IN  std_logic
  );
END COMPONENT;

END ccs_out_wait_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_out_wait_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    dat   : OUT std_logic_vector(width-1 DOWNTO 0);
    irdy  : OUT std_logic;
    vld   : OUT std_logic;
    idat  : IN  std_logic_vector(width-1 DOWNTO 0);
    rdy   : IN  std_logic;
    ivld  : IN  std_logic
  );
END ccs_out_wait_v1;

ARCHITECTURE beh OF ccs_out_wait_v1 IS
  constant stall_const : std_logic := '0';
  SIGNAL stall_ctrl : std_logic;
BEGIN
  stall_ctrl <= stall_const;

  dat  <= idat;
  irdy <= rdy and not stall_ctrl;
  vld  <= ivld and not stall_ctrl;

END beh;


--------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
PACKAGE mgc_io_sync_pkg_v2 IS

COMPONENT mgc_io_sync_v2
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END COMPONENT;

END mgc_io_sync_pkg_v2;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY mgc_io_sync_v2 IS
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END mgc_io_sync_v2;

ARCHITECTURE beh OF mgc_io_sync_v2 IS
BEGIN

  lz <= ld;

END beh;


--------> /tools/Siemens_EDA/Catapult/2021.1/Mgc_home/pkgs/siflibs/ccs_in_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_in_pkg_v1 IS

COMPONENT ccs_in_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    idat   : OUT std_logic_vector(width-1 DOWNTO 0);
    dat    : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

END ccs_in_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_in_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    idat  : OUT std_logic_vector(width-1 DOWNTO 0);
    dat   : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END ccs_in_v1;

ARCHITECTURE beh OF ccs_in_v1 IS
BEGIN

  idat <= dat;

END beh;


--------> ./rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    2021.1/950854 Production Release
--  HLS Date:       Mon Aug  2 21:36:02 PDT 2021
-- 
--  Generated by:   serik.perez@c5c6
--  Generated date: Thu Apr 23 17:47:09 2026
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
  );
END mult_add_pipeline_core_core_fsm;

ARCHITECTURE v12 OF mult_add_pipeline_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for mult_add_pipeline_core_core_fsm_1
  TYPE mult_add_pipeline_core_core_fsm_1_ST IS (core_rlp_C_0, main_C_0);

  SIGNAL state_var : mult_add_pipeline_core_core_fsm_1_ST;
  SIGNAL state_var_NS : mult_add_pipeline_core_core_fsm_1_ST;

BEGIN
  mult_add_pipeline_core_core_fsm_1 : PROCESS (state_var)
  BEGIN
    CASE state_var IS
      WHEN main_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "10");
        state_var_NS <= main_C_0;
      -- core_rlp_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "01");
        state_var_NS <= main_C_0;
    END CASE;
  END PROCESS mult_add_pipeline_core_core_fsm_1;

  mult_add_pipeline_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= core_rlp_C_0;
      ELSE
        IF ( core_wen = '1' ) THEN
          state_var <= state_var_NS;
        END IF;
      END IF;
    END IF;
  END PROCESS mult_add_pipeline_core_core_fsm_1_REG;

END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_staller
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_staller IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    core_wen : OUT STD_LOGIC;
    core_wten : OUT STD_LOGIC;
    a_rsci_wen_comp : IN STD_LOGIC;
    b_rsci_wen_comp : IN STD_LOGIC;
    c_rsci_wen_comp : IN STD_LOGIC;
    result_rsci_wen_comp : IN STD_LOGIC
  );
END mult_add_pipeline_core_staller;

ARCHITECTURE v12 OF mult_add_pipeline_core_staller IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL core_wen_drv : STD_LOGIC;

BEGIN
  -- Output Reader Assignments
  core_wen <= core_wen_drv;

  core_wen_drv <= a_rsci_wen_comp AND b_rsci_wen_comp AND c_rsci_wen_comp AND result_rsci_wen_comp;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        core_wten <= '0';
      ELSE
        core_wten <= NOT core_wen_drv;
      END IF;
    END IF;
  END PROCESS;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
    IS
  PORT(
    core_wten : IN STD_LOGIC;
    gain_adjust_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
    gain_adjust_rsc_triosy_obj_biwt : OUT STD_LOGIC
  );
END mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl;

ARCHITECTURE v12 OF mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
    IS
  -- Default Constants

BEGIN
  gain_adjust_rsc_triosy_obj_biwt <= (NOT core_wten) AND gain_adjust_rsc_triosy_obj_iswt0;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl IS
  PORT(
    core_wten : IN STD_LOGIC;
    gain_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
    gain_rsc_triosy_obj_biwt : OUT STD_LOGIC
  );
END mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl;

ARCHITECTURE v12 OF mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl
    IS
  -- Default Constants

BEGIN
  gain_rsc_triosy_obj_biwt <= (NOT core_wten) AND gain_rsc_triosy_obj_iswt0;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_result_rsci_result_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_result_rsci_result_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    result_rsci_oswt : IN STD_LOGIC;
    result_rsci_wen_comp : OUT STD_LOGIC;
    result_rsci_biwt : IN STD_LOGIC;
    result_rsci_bdwt : IN STD_LOGIC;
    result_rsci_bcwt : OUT STD_LOGIC
  );
END mult_add_pipeline_core_result_rsci_result_wait_dp;

ARCHITECTURE v12 OF mult_add_pipeline_core_result_rsci_result_wait_dp IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL result_rsci_bcwt_drv : STD_LOGIC;

BEGIN
  -- Output Reader Assignments
  result_rsci_bcwt <= result_rsci_bcwt_drv;

  result_rsci_wen_comp <= (NOT result_rsci_oswt) OR result_rsci_biwt OR result_rsci_bcwt_drv;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        result_rsci_bcwt_drv <= '0';
      ELSE
        result_rsci_bcwt_drv <= NOT((NOT(result_rsci_bcwt_drv OR result_rsci_biwt))
            OR result_rsci_bdwt);
      END IF;
    END IF;
  END PROCESS;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_result_rsci_result_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_result_rsci_result_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    result_rsci_oswt : IN STD_LOGIC;
    result_rsci_biwt : OUT STD_LOGIC;
    result_rsci_bdwt : OUT STD_LOGIC;
    result_rsci_bcwt : IN STD_LOGIC;
    result_rsci_irdy : IN STD_LOGIC;
    result_rsci_ivld_core_sct : OUT STD_LOGIC
  );
END mult_add_pipeline_core_result_rsci_result_wait_ctrl;

ARCHITECTURE v12 OF mult_add_pipeline_core_result_rsci_result_wait_ctrl IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL result_rsci_ogwt : STD_LOGIC;

BEGIN
  result_rsci_bdwt <= result_rsci_oswt AND core_wen;
  result_rsci_biwt <= result_rsci_ogwt AND result_rsci_irdy;
  result_rsci_ogwt <= result_rsci_oswt AND (NOT result_rsci_bcwt);
  result_rsci_ivld_core_sct <= result_rsci_ogwt;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_c_rsci_c_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_c_rsci_c_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    c_rsci_oswt : IN STD_LOGIC;
    c_rsci_wen_comp : OUT STD_LOGIC;
    c_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
    c_rsci_biwt : IN STD_LOGIC;
    c_rsci_bdwt : IN STD_LOGIC;
    c_rsci_bcwt : OUT STD_LOGIC;
    c_rsci_idat : IN STD_LOGIC_VECTOR (24 DOWNTO 0)
  );
END mult_add_pipeline_core_c_rsci_c_wait_dp;

ARCHITECTURE v12 OF mult_add_pipeline_core_c_rsci_c_wait_dp IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL c_rsci_bcwt_drv : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL c_rsci_idat_bfwt : STD_LOGIC_VECTOR (24 DOWNTO 0);

  FUNCTION MUX_v_25_2_2(input_0 : STD_LOGIC_VECTOR(24 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(24 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(24 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Output Reader Assignments
  c_rsci_bcwt <= c_rsci_bcwt_drv;

  c_rsci_wen_comp <= (NOT c_rsci_oswt) OR c_rsci_biwt OR c_rsci_bcwt_drv;
  c_rsci_idat_mxwt <= MUX_v_25_2_2(c_rsci_idat, c_rsci_idat_bfwt, c_rsci_bcwt_drv);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        c_rsci_bcwt_drv <= '0';
      ELSE
        c_rsci_bcwt_drv <= NOT((NOT(c_rsci_bcwt_drv OR c_rsci_biwt)) OR c_rsci_bdwt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        c_rsci_idat_bfwt <= STD_LOGIC_VECTOR'( "0000000000000000000000000");
      ELSIF ( c_rsci_biwt = '1' ) THEN
        c_rsci_idat_bfwt <= c_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_c_rsci_c_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_c_rsci_c_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    c_rsci_oswt : IN STD_LOGIC;
    c_rsci_biwt : OUT STD_LOGIC;
    c_rsci_bdwt : OUT STD_LOGIC;
    c_rsci_bcwt : IN STD_LOGIC;
    c_rsci_irdy_core_sct : OUT STD_LOGIC;
    c_rsci_ivld : IN STD_LOGIC
  );
END mult_add_pipeline_core_c_rsci_c_wait_ctrl;

ARCHITECTURE v12 OF mult_add_pipeline_core_c_rsci_c_wait_ctrl IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL c_rsci_ogwt : STD_LOGIC;

BEGIN
  c_rsci_bdwt <= c_rsci_oswt AND core_wen;
  c_rsci_biwt <= c_rsci_ogwt AND c_rsci_ivld;
  c_rsci_ogwt <= c_rsci_oswt AND (NOT c_rsci_bcwt);
  c_rsci_irdy_core_sct <= c_rsci_ogwt;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_b_rsci_b_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_b_rsci_b_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    b_rsci_oswt : IN STD_LOGIC;
    b_rsci_wen_comp : OUT STD_LOGIC;
    b_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
    b_rsci_biwt : IN STD_LOGIC;
    b_rsci_bdwt : IN STD_LOGIC;
    b_rsci_bcwt : OUT STD_LOGIC;
    b_rsci_idat : IN STD_LOGIC_VECTOR (13 DOWNTO 0)
  );
END mult_add_pipeline_core_b_rsci_b_wait_dp;

ARCHITECTURE v12 OF mult_add_pipeline_core_b_rsci_b_wait_dp IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL b_rsci_bcwt_drv : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL b_rsci_idat_bfwt : STD_LOGIC_VECTOR (13 DOWNTO 0);

  FUNCTION MUX_v_14_2_2(input_0 : STD_LOGIC_VECTOR(13 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(13 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(13 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Output Reader Assignments
  b_rsci_bcwt <= b_rsci_bcwt_drv;

  b_rsci_wen_comp <= (NOT b_rsci_oswt) OR b_rsci_biwt OR b_rsci_bcwt_drv;
  b_rsci_idat_mxwt <= MUX_v_14_2_2(b_rsci_idat, b_rsci_idat_bfwt, b_rsci_bcwt_drv);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        b_rsci_bcwt_drv <= '0';
      ELSE
        b_rsci_bcwt_drv <= NOT((NOT(b_rsci_bcwt_drv OR b_rsci_biwt)) OR b_rsci_bdwt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        b_rsci_idat_bfwt <= STD_LOGIC_VECTOR'( "00000000000000");
      ELSIF ( b_rsci_biwt = '1' ) THEN
        b_rsci_idat_bfwt <= b_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_b_rsci_b_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_b_rsci_b_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    b_rsci_oswt : IN STD_LOGIC;
    b_rsci_biwt : OUT STD_LOGIC;
    b_rsci_bdwt : OUT STD_LOGIC;
    b_rsci_bcwt : IN STD_LOGIC;
    b_rsci_irdy_core_sct : OUT STD_LOGIC;
    b_rsci_ivld : IN STD_LOGIC
  );
END mult_add_pipeline_core_b_rsci_b_wait_ctrl;

ARCHITECTURE v12 OF mult_add_pipeline_core_b_rsci_b_wait_ctrl IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL b_rsci_ogwt : STD_LOGIC;

BEGIN
  b_rsci_bdwt <= b_rsci_oswt AND core_wen;
  b_rsci_biwt <= b_rsci_ogwt AND b_rsci_ivld;
  b_rsci_ogwt <= b_rsci_oswt AND (NOT b_rsci_bcwt);
  b_rsci_irdy_core_sct <= b_rsci_ogwt;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_a_rsci_a_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_a_rsci_a_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    a_rsci_oswt : IN STD_LOGIC;
    a_rsci_wen_comp : OUT STD_LOGIC;
    a_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
    a_rsci_biwt : IN STD_LOGIC;
    a_rsci_bdwt : IN STD_LOGIC;
    a_rsci_bcwt : OUT STD_LOGIC;
    a_rsci_idat : IN STD_LOGIC_VECTOR (10 DOWNTO 0)
  );
END mult_add_pipeline_core_a_rsci_a_wait_dp;

ARCHITECTURE v12 OF mult_add_pipeline_core_a_rsci_a_wait_dp IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL a_rsci_bcwt_drv : STD_LOGIC;

  -- Interconnect Declarations
  SIGNAL a_rsci_idat_bfwt : STD_LOGIC_VECTOR (10 DOWNTO 0);

  FUNCTION MUX_v_11_2_2(input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  -- Output Reader Assignments
  a_rsci_bcwt <= a_rsci_bcwt_drv;

  a_rsci_wen_comp <= (NOT a_rsci_oswt) OR a_rsci_biwt OR a_rsci_bcwt_drv;
  a_rsci_idat_mxwt <= MUX_v_11_2_2(a_rsci_idat, a_rsci_idat_bfwt, a_rsci_bcwt_drv);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        a_rsci_bcwt_drv <= '0';
      ELSE
        a_rsci_bcwt_drv <= NOT((NOT(a_rsci_bcwt_drv OR a_rsci_biwt)) OR a_rsci_bdwt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        a_rsci_idat_bfwt <= STD_LOGIC_VECTOR'( "00000000000");
      ELSIF ( a_rsci_biwt = '1' ) THEN
        a_rsci_idat_bfwt <= a_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_a_rsci_a_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_a_rsci_a_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    a_rsci_oswt : IN STD_LOGIC;
    a_rsci_biwt : OUT STD_LOGIC;
    a_rsci_bdwt : OUT STD_LOGIC;
    a_rsci_bcwt : IN STD_LOGIC;
    a_rsci_irdy_core_sct : OUT STD_LOGIC;
    a_rsci_ivld : IN STD_LOGIC
  );
END mult_add_pipeline_core_a_rsci_a_wait_ctrl;

ARCHITECTURE v12 OF mult_add_pipeline_core_a_rsci_a_wait_ctrl IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL a_rsci_ogwt : STD_LOGIC;

BEGIN
  a_rsci_bdwt <= a_rsci_oswt AND core_wen;
  a_rsci_biwt <= a_rsci_ogwt AND a_rsci_ivld;
  a_rsci_ogwt <= a_rsci_oswt AND (NOT a_rsci_bcwt);
  a_rsci_irdy_core_sct <= a_rsci_ogwt;
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_gain_adjust_rsc_triosy_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_gain_adjust_rsc_triosy_obj IS
  PORT(
    gain_adjust_rsc_triosy_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    gain_adjust_rsc_triosy_obj_iswt0 : IN STD_LOGIC
  );
END mult_add_pipeline_core_gain_adjust_rsc_triosy_obj;

ARCHITECTURE v12 OF mult_add_pipeline_core_gain_adjust_rsc_triosy_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL gain_adjust_rsc_triosy_obj_biwt : STD_LOGIC;

  COMPONENT mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      gain_adjust_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
      gain_adjust_rsc_triosy_obj_biwt : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  gain_adjust_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => gain_adjust_rsc_triosy_obj_biwt,
      lz => gain_adjust_rsc_triosy_lz
    );
  mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl_inst
      : mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_gain_adjust_rsc_triosy_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      gain_adjust_rsc_triosy_obj_iswt0 => gain_adjust_rsc_triosy_obj_iswt0,
      gain_adjust_rsc_triosy_obj_biwt => gain_adjust_rsc_triosy_obj_biwt
    );
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_gain_rsc_triosy_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_gain_rsc_triosy_obj IS
  PORT(
    gain_rsc_triosy_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    gain_rsc_triosy_obj_iswt0 : IN STD_LOGIC
  );
END mult_add_pipeline_core_gain_rsc_triosy_obj;

ARCHITECTURE v12 OF mult_add_pipeline_core_gain_rsc_triosy_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL gain_rsc_triosy_obj_biwt : STD_LOGIC;

  COMPONENT mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      gain_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
      gain_rsc_triosy_obj_biwt : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  gain_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => gain_rsc_triosy_obj_biwt,
      lz => gain_rsc_triosy_lz
    );
  mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl_inst : mult_add_pipeline_core_gain_rsc_triosy_obj_gain_rsc_triosy_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      gain_rsc_triosy_obj_iswt0 => gain_rsc_triosy_obj_iswt0,
      gain_rsc_triosy_obj_biwt => gain_rsc_triosy_obj_biwt
    );
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_result_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_result_rsci IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    result_rsc_dat : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
    result_rsc_vld : OUT STD_LOGIC;
    result_rsc_rdy : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    result_rsci_oswt : IN STD_LOGIC;
    result_rsci_wen_comp : OUT STD_LOGIC;
    result_rsci_idat : IN STD_LOGIC_VECTOR (29 DOWNTO 0)
  );
END mult_add_pipeline_core_result_rsci;

ARCHITECTURE v12 OF mult_add_pipeline_core_result_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL result_rsci_biwt : STD_LOGIC;
  SIGNAL result_rsci_bdwt : STD_LOGIC;
  SIGNAL result_rsci_bcwt : STD_LOGIC;
  SIGNAL result_rsci_irdy : STD_LOGIC;
  SIGNAL result_rsci_ivld_core_sct : STD_LOGIC;

  SIGNAL result_rsci_idat_1 : STD_LOGIC_VECTOR (29 DOWNTO 0);
  SIGNAL result_rsci_dat : STD_LOGIC_VECTOR (29 DOWNTO 0);

  COMPONENT mult_add_pipeline_core_result_rsci_result_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      result_rsci_oswt : IN STD_LOGIC;
      result_rsci_biwt : OUT STD_LOGIC;
      result_rsci_bdwt : OUT STD_LOGIC;
      result_rsci_bcwt : IN STD_LOGIC;
      result_rsci_irdy : IN STD_LOGIC;
      result_rsci_ivld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT mult_add_pipeline_core_result_rsci_result_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      result_rsci_oswt : IN STD_LOGIC;
      result_rsci_wen_comp : OUT STD_LOGIC;
      result_rsci_biwt : IN STD_LOGIC;
      result_rsci_bdwt : IN STD_LOGIC;
      result_rsci_bcwt : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  result_rsci : work.ccs_out_wait_pkg_v1.ccs_out_wait_v1
    GENERIC MAP(
      rscid => 6,
      width => 30
      )
    PORT MAP(
      irdy => result_rsci_irdy,
      ivld => result_rsci_ivld_core_sct,
      idat => result_rsci_idat_1,
      rdy => result_rsc_rdy,
      vld => result_rsc_vld,
      dat => result_rsci_dat
    );
  result_rsci_idat_1 <= (result_rsci_idat(29 DOWNTO 4)) & STD_LOGIC_VECTOR'( "0000");
  result_rsc_dat <= result_rsci_dat;

  mult_add_pipeline_core_result_rsci_result_wait_ctrl_inst : mult_add_pipeline_core_result_rsci_result_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      result_rsci_oswt => result_rsci_oswt,
      result_rsci_biwt => result_rsci_biwt,
      result_rsci_bdwt => result_rsci_bdwt,
      result_rsci_bcwt => result_rsci_bcwt,
      result_rsci_irdy => result_rsci_irdy,
      result_rsci_ivld_core_sct => result_rsci_ivld_core_sct
    );
  mult_add_pipeline_core_result_rsci_result_wait_dp_inst : mult_add_pipeline_core_result_rsci_result_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      result_rsci_oswt => result_rsci_oswt,
      result_rsci_wen_comp => result_rsci_wen_comp,
      result_rsci_biwt => result_rsci_biwt,
      result_rsci_bdwt => result_rsci_bdwt,
      result_rsci_bcwt => result_rsci_bcwt
    );
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_c_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_c_rsci IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    c_rsc_dat : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
    c_rsc_vld : IN STD_LOGIC;
    c_rsc_rdy : OUT STD_LOGIC;
    core_wen : IN STD_LOGIC;
    c_rsci_oswt : IN STD_LOGIC;
    c_rsci_wen_comp : OUT STD_LOGIC;
    c_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (24 DOWNTO 0)
  );
END mult_add_pipeline_core_c_rsci;

ARCHITECTURE v12 OF mult_add_pipeline_core_c_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL c_rsci_biwt : STD_LOGIC;
  SIGNAL c_rsci_bdwt : STD_LOGIC;
  SIGNAL c_rsci_bcwt : STD_LOGIC;
  SIGNAL c_rsci_irdy_core_sct : STD_LOGIC;
  SIGNAL c_rsci_ivld : STD_LOGIC;
  SIGNAL c_rsci_idat : STD_LOGIC_VECTOR (24 DOWNTO 0);

  SIGNAL c_rsci_dat : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL c_rsci_idat_1 : STD_LOGIC_VECTOR (24 DOWNTO 0);

  COMPONENT mult_add_pipeline_core_c_rsci_c_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      c_rsci_oswt : IN STD_LOGIC;
      c_rsci_biwt : OUT STD_LOGIC;
      c_rsci_bdwt : OUT STD_LOGIC;
      c_rsci_bcwt : IN STD_LOGIC;
      c_rsci_irdy_core_sct : OUT STD_LOGIC;
      c_rsci_ivld : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT mult_add_pipeline_core_c_rsci_c_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      c_rsci_oswt : IN STD_LOGIC;
      c_rsci_wen_comp : OUT STD_LOGIC;
      c_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
      c_rsci_biwt : IN STD_LOGIC;
      c_rsci_bdwt : IN STD_LOGIC;
      c_rsci_bcwt : OUT STD_LOGIC;
      c_rsci_idat : IN STD_LOGIC_VECTOR (24 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_c_rsci_c_wait_dp_inst_c_rsci_idat_mxwt : STD_LOGIC_VECTOR
      (24 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_c_rsci_c_wait_dp_inst_c_rsci_idat : STD_LOGIC_VECTOR
      (24 DOWNTO 0);

BEGIN
  c_rsci : work.ccs_in_wait_pkg_v1.ccs_in_wait_v1
    GENERIC MAP(
      rscid => 3,
      width => 25
      )
    PORT MAP(
      rdy => c_rsc_rdy,
      vld => c_rsc_vld,
      dat => c_rsci_dat,
      irdy => c_rsci_irdy_core_sct,
      ivld => c_rsci_ivld,
      idat => c_rsci_idat_1
    );
  c_rsci_dat <= c_rsc_dat;
  c_rsci_idat <= c_rsci_idat_1;

  mult_add_pipeline_core_c_rsci_c_wait_ctrl_inst : mult_add_pipeline_core_c_rsci_c_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      c_rsci_oswt => c_rsci_oswt,
      c_rsci_biwt => c_rsci_biwt,
      c_rsci_bdwt => c_rsci_bdwt,
      c_rsci_bcwt => c_rsci_bcwt,
      c_rsci_irdy_core_sct => c_rsci_irdy_core_sct,
      c_rsci_ivld => c_rsci_ivld
    );
  mult_add_pipeline_core_c_rsci_c_wait_dp_inst : mult_add_pipeline_core_c_rsci_c_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      c_rsci_oswt => c_rsci_oswt,
      c_rsci_wen_comp => c_rsci_wen_comp,
      c_rsci_idat_mxwt => mult_add_pipeline_core_c_rsci_c_wait_dp_inst_c_rsci_idat_mxwt,
      c_rsci_biwt => c_rsci_biwt,
      c_rsci_bdwt => c_rsci_bdwt,
      c_rsci_bcwt => c_rsci_bcwt,
      c_rsci_idat => mult_add_pipeline_core_c_rsci_c_wait_dp_inst_c_rsci_idat
    );
  c_rsci_idat_mxwt <= mult_add_pipeline_core_c_rsci_c_wait_dp_inst_c_rsci_idat_mxwt;
  mult_add_pipeline_core_c_rsci_c_wait_dp_inst_c_rsci_idat <= c_rsci_idat;

END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_b_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_b_rsci IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    b_rsc_dat : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    b_rsc_vld : IN STD_LOGIC;
    b_rsc_rdy : OUT STD_LOGIC;
    core_wen : IN STD_LOGIC;
    b_rsci_oswt : IN STD_LOGIC;
    b_rsci_wen_comp : OUT STD_LOGIC;
    b_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (13 DOWNTO 0)
  );
END mult_add_pipeline_core_b_rsci;

ARCHITECTURE v12 OF mult_add_pipeline_core_b_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL b_rsci_biwt : STD_LOGIC;
  SIGNAL b_rsci_bdwt : STD_LOGIC;
  SIGNAL b_rsci_bcwt : STD_LOGIC;
  SIGNAL b_rsci_irdy_core_sct : STD_LOGIC;
  SIGNAL b_rsci_ivld : STD_LOGIC;
  SIGNAL b_rsci_idat : STD_LOGIC_VECTOR (13 DOWNTO 0);

  SIGNAL b_rsci_dat : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL b_rsci_idat_1 : STD_LOGIC_VECTOR (13 DOWNTO 0);

  COMPONENT mult_add_pipeline_core_b_rsci_b_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      b_rsci_oswt : IN STD_LOGIC;
      b_rsci_biwt : OUT STD_LOGIC;
      b_rsci_bdwt : OUT STD_LOGIC;
      b_rsci_bcwt : IN STD_LOGIC;
      b_rsci_irdy_core_sct : OUT STD_LOGIC;
      b_rsci_ivld : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT mult_add_pipeline_core_b_rsci_b_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      b_rsci_oswt : IN STD_LOGIC;
      b_rsci_wen_comp : OUT STD_LOGIC;
      b_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
      b_rsci_biwt : IN STD_LOGIC;
      b_rsci_bdwt : IN STD_LOGIC;
      b_rsci_bcwt : OUT STD_LOGIC;
      b_rsci_idat : IN STD_LOGIC_VECTOR (13 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_b_rsci_b_wait_dp_inst_b_rsci_idat_mxwt : STD_LOGIC_VECTOR
      (13 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_b_rsci_b_wait_dp_inst_b_rsci_idat : STD_LOGIC_VECTOR
      (13 DOWNTO 0);

BEGIN
  b_rsci : work.ccs_in_wait_pkg_v1.ccs_in_wait_v1
    GENERIC MAP(
      rscid => 2,
      width => 14
      )
    PORT MAP(
      rdy => b_rsc_rdy,
      vld => b_rsc_vld,
      dat => b_rsci_dat,
      irdy => b_rsci_irdy_core_sct,
      ivld => b_rsci_ivld,
      idat => b_rsci_idat_1
    );
  b_rsci_dat <= b_rsc_dat;
  b_rsci_idat <= b_rsci_idat_1;

  mult_add_pipeline_core_b_rsci_b_wait_ctrl_inst : mult_add_pipeline_core_b_rsci_b_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      b_rsci_oswt => b_rsci_oswt,
      b_rsci_biwt => b_rsci_biwt,
      b_rsci_bdwt => b_rsci_bdwt,
      b_rsci_bcwt => b_rsci_bcwt,
      b_rsci_irdy_core_sct => b_rsci_irdy_core_sct,
      b_rsci_ivld => b_rsci_ivld
    );
  mult_add_pipeline_core_b_rsci_b_wait_dp_inst : mult_add_pipeline_core_b_rsci_b_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      b_rsci_oswt => b_rsci_oswt,
      b_rsci_wen_comp => b_rsci_wen_comp,
      b_rsci_idat_mxwt => mult_add_pipeline_core_b_rsci_b_wait_dp_inst_b_rsci_idat_mxwt,
      b_rsci_biwt => b_rsci_biwt,
      b_rsci_bdwt => b_rsci_bdwt,
      b_rsci_bcwt => b_rsci_bcwt,
      b_rsci_idat => mult_add_pipeline_core_b_rsci_b_wait_dp_inst_b_rsci_idat
    );
  b_rsci_idat_mxwt <= mult_add_pipeline_core_b_rsci_b_wait_dp_inst_b_rsci_idat_mxwt;
  mult_add_pipeline_core_b_rsci_b_wait_dp_inst_b_rsci_idat <= b_rsci_idat;

END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core_a_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core_a_rsci IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    a_rsc_dat : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    a_rsc_vld : IN STD_LOGIC;
    a_rsc_rdy : OUT STD_LOGIC;
    core_wen : IN STD_LOGIC;
    a_rsci_oswt : IN STD_LOGIC;
    a_rsci_wen_comp : OUT STD_LOGIC;
    a_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
  );
END mult_add_pipeline_core_a_rsci;

ARCHITECTURE v12 OF mult_add_pipeline_core_a_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL a_rsci_biwt : STD_LOGIC;
  SIGNAL a_rsci_bdwt : STD_LOGIC;
  SIGNAL a_rsci_bcwt : STD_LOGIC;
  SIGNAL a_rsci_irdy_core_sct : STD_LOGIC;
  SIGNAL a_rsci_ivld : STD_LOGIC;
  SIGNAL a_rsci_idat : STD_LOGIC_VECTOR (10 DOWNTO 0);

  SIGNAL a_rsci_dat : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL a_rsci_idat_1 : STD_LOGIC_VECTOR (10 DOWNTO 0);

  COMPONENT mult_add_pipeline_core_a_rsci_a_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      a_rsci_oswt : IN STD_LOGIC;
      a_rsci_biwt : OUT STD_LOGIC;
      a_rsci_bdwt : OUT STD_LOGIC;
      a_rsci_bcwt : IN STD_LOGIC;
      a_rsci_irdy_core_sct : OUT STD_LOGIC;
      a_rsci_ivld : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT mult_add_pipeline_core_a_rsci_a_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      a_rsci_oswt : IN STD_LOGIC;
      a_rsci_wen_comp : OUT STD_LOGIC;
      a_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
      a_rsci_biwt : IN STD_LOGIC;
      a_rsci_bdwt : IN STD_LOGIC;
      a_rsci_bcwt : OUT STD_LOGIC;
      a_rsci_idat : IN STD_LOGIC_VECTOR (10 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_a_rsci_a_wait_dp_inst_a_rsci_idat_mxwt : STD_LOGIC_VECTOR
      (10 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_a_rsci_a_wait_dp_inst_a_rsci_idat : STD_LOGIC_VECTOR
      (10 DOWNTO 0);

BEGIN
  a_rsci : work.ccs_in_wait_pkg_v1.ccs_in_wait_v1
    GENERIC MAP(
      rscid => 1,
      width => 11
      )
    PORT MAP(
      rdy => a_rsc_rdy,
      vld => a_rsc_vld,
      dat => a_rsci_dat,
      irdy => a_rsci_irdy_core_sct,
      ivld => a_rsci_ivld,
      idat => a_rsci_idat_1
    );
  a_rsci_dat <= a_rsc_dat;
  a_rsci_idat <= a_rsci_idat_1;

  mult_add_pipeline_core_a_rsci_a_wait_ctrl_inst : mult_add_pipeline_core_a_rsci_a_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      a_rsci_oswt => a_rsci_oswt,
      a_rsci_biwt => a_rsci_biwt,
      a_rsci_bdwt => a_rsci_bdwt,
      a_rsci_bcwt => a_rsci_bcwt,
      a_rsci_irdy_core_sct => a_rsci_irdy_core_sct,
      a_rsci_ivld => a_rsci_ivld
    );
  mult_add_pipeline_core_a_rsci_a_wait_dp_inst : mult_add_pipeline_core_a_rsci_a_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      a_rsci_oswt => a_rsci_oswt,
      a_rsci_wen_comp => a_rsci_wen_comp,
      a_rsci_idat_mxwt => mult_add_pipeline_core_a_rsci_a_wait_dp_inst_a_rsci_idat_mxwt,
      a_rsci_biwt => a_rsci_biwt,
      a_rsci_bdwt => a_rsci_bdwt,
      a_rsci_bcwt => a_rsci_bcwt,
      a_rsci_idat => mult_add_pipeline_core_a_rsci_a_wait_dp_inst_a_rsci_idat
    );
  a_rsci_idat_mxwt <= mult_add_pipeline_core_a_rsci_a_wait_dp_inst_a_rsci_idat_mxwt;
  mult_add_pipeline_core_a_rsci_a_wait_dp_inst_a_rsci_idat <= a_rsci_idat;

END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    a_rsc_dat : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    a_rsc_vld : IN STD_LOGIC;
    a_rsc_rdy : OUT STD_LOGIC;
    b_rsc_dat : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    b_rsc_vld : IN STD_LOGIC;
    b_rsc_rdy : OUT STD_LOGIC;
    c_rsc_dat : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
    c_rsc_vld : IN STD_LOGIC;
    c_rsc_rdy : OUT STD_LOGIC;
    gain_rsc_dat : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    gain_rsc_triosy_lz : OUT STD_LOGIC;
    gain_adjust_rsc_dat : IN STD_LOGIC;
    gain_adjust_rsc_triosy_lz : OUT STD_LOGIC;
    result_rsc_dat : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
    result_rsc_vld : OUT STD_LOGIC;
    result_rsc_rdy : IN STD_LOGIC
  );
END mult_add_pipeline_core;

ARCHITECTURE v12 OF mult_add_pipeline_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL core_wen : STD_LOGIC;
  SIGNAL core_wten : STD_LOGIC;
  SIGNAL a_rsci_wen_comp : STD_LOGIC;
  SIGNAL a_rsci_idat_mxwt : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL b_rsci_wen_comp : STD_LOGIC;
  SIGNAL b_rsci_idat_mxwt : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL c_rsci_wen_comp : STD_LOGIC;
  SIGNAL c_rsci_idat_mxwt : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL gain_rsci_idat : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL gain_adjust_rsci_idat : STD_LOGIC;
  SIGNAL result_rsci_wen_comp : STD_LOGIC;
  SIGNAL result_rsci_idat_29_4 : STD_LOGIC_VECTOR (25 DOWNTO 0);
  SIGNAL fsm_output : STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL CHECK_io_read_gain_adjust_rsc_svs_st_1 : STD_LOGIC;
  SIGNAL main_stage_0_3 : STD_LOGIC;
  SIGNAL CHECK_io_read_gain_adjust_rsc_svs_2 : STD_LOGIC;
  SIGNAL reg_gain_adjust_rsc_triosy_obj_iswt0_cse : STD_LOGIC;
  SIGNAL reg_result_rsci_iswt0_cse : STD_LOGIC;
  SIGNAL reg_c_rsci_iswt0_cse : STD_LOGIC;
  SIGNAL gain_sva_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL gain_sva_2 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL sum_c_tmp_sva_1 : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL sum_sva_1 : STD_LOGIC_VECTOR (25 DOWNTO 0);
  SIGNAL product_mul_itm_1 : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL sum_and_cse : STD_LOGIC;

  SIGNAL operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl : STD_LOGIC_VECTOR (33
      DOWNTO 0);
  SIGNAL and_2_nl : STD_LOGIC;
  SIGNAL gain_rsci_dat : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL gain_rsci_idat_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);

  SIGNAL gain_adjust_rsci_dat : STD_LOGIC ;
  SIGNAL gain_adjust_rsci_idat_1 : STD_LOGIC ;

  COMPONENT mult_add_pipeline_core_a_rsci
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      a_rsc_dat : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      a_rsc_vld : IN STD_LOGIC;
      a_rsc_rdy : OUT STD_LOGIC;
      core_wen : IN STD_LOGIC;
      a_rsci_oswt : IN STD_LOGIC;
      a_rsci_wen_comp : OUT STD_LOGIC;
      a_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_a_rsci_inst_a_rsc_dat : STD_LOGIC_VECTOR (10 DOWNTO
      0);
  SIGNAL mult_add_pipeline_core_a_rsci_inst_a_rsci_idat_mxwt : STD_LOGIC_VECTOR (10
      DOWNTO 0);

  COMPONENT mult_add_pipeline_core_b_rsci
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      b_rsc_dat : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
      b_rsc_vld : IN STD_LOGIC;
      b_rsc_rdy : OUT STD_LOGIC;
      core_wen : IN STD_LOGIC;
      b_rsci_oswt : IN STD_LOGIC;
      b_rsci_wen_comp : OUT STD_LOGIC;
      b_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (13 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_b_rsci_inst_b_rsc_dat : STD_LOGIC_VECTOR (13 DOWNTO
      0);
  SIGNAL mult_add_pipeline_core_b_rsci_inst_b_rsci_idat_mxwt : STD_LOGIC_VECTOR (13
      DOWNTO 0);

  COMPONENT mult_add_pipeline_core_c_rsci
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      c_rsc_dat : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
      c_rsc_vld : IN STD_LOGIC;
      c_rsc_rdy : OUT STD_LOGIC;
      core_wen : IN STD_LOGIC;
      c_rsci_oswt : IN STD_LOGIC;
      c_rsci_wen_comp : OUT STD_LOGIC;
      c_rsci_idat_mxwt : OUT STD_LOGIC_VECTOR (24 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_c_rsci_inst_c_rsc_dat : STD_LOGIC_VECTOR (24 DOWNTO
      0);
  SIGNAL mult_add_pipeline_core_c_rsci_inst_c_rsci_idat_mxwt : STD_LOGIC_VECTOR (24
      DOWNTO 0);

  COMPONENT mult_add_pipeline_core_result_rsci
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      result_rsc_dat : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
      result_rsc_vld : OUT STD_LOGIC;
      result_rsc_rdy : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      result_rsci_oswt : IN STD_LOGIC;
      result_rsci_wen_comp : OUT STD_LOGIC;
      result_rsci_idat : IN STD_LOGIC_VECTOR (29 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_result_rsci_inst_result_rsc_dat : STD_LOGIC_VECTOR
      (29 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_result_rsci_inst_result_rsci_idat : STD_LOGIC_VECTOR
      (29 DOWNTO 0);

  COMPONENT mult_add_pipeline_core_gain_rsc_triosy_obj
    PORT(
      gain_rsc_triosy_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      gain_rsc_triosy_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT mult_add_pipeline_core_gain_adjust_rsc_triosy_obj
    PORT(
      gain_adjust_rsc_triosy_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      gain_adjust_rsc_triosy_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT mult_add_pipeline_core_staller
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      core_wen : OUT STD_LOGIC;
      core_wten : OUT STD_LOGIC;
      a_rsci_wen_comp : IN STD_LOGIC;
      b_rsci_wen_comp : IN STD_LOGIC;
      c_rsci_wen_comp : IN STD_LOGIC;
      result_rsci_wen_comp : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT mult_add_pipeline_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (1 DOWNTO
      0);

  FUNCTION MUX_v_26_2_2(input_0 : STD_LOGIC_VECTOR(25 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(25 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(25 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  gain_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 4,
      width => 10
      )
    PORT MAP(
      dat => gain_rsci_dat,
      idat => gain_rsci_idat_1
    );
  gain_rsci_dat <= gain_rsc_dat;
  gain_rsci_idat <= gain_rsci_idat_1;

  gain_adjust_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 5,
      width => 1
      )
    PORT MAP(
      dat(0) => gain_adjust_rsci_dat,
      idat(0) => gain_adjust_rsci_idat_1
    );
  gain_adjust_rsci_dat <= gain_adjust_rsc_dat;
  gain_adjust_rsci_idat <= gain_adjust_rsci_idat_1;

  mult_add_pipeline_core_a_rsci_inst : mult_add_pipeline_core_a_rsci
    PORT MAP(
      clk => clk,
      rst => rst,
      a_rsc_dat => mult_add_pipeline_core_a_rsci_inst_a_rsc_dat,
      a_rsc_vld => a_rsc_vld,
      a_rsc_rdy => a_rsc_rdy,
      core_wen => core_wen,
      a_rsci_oswt => reg_c_rsci_iswt0_cse,
      a_rsci_wen_comp => a_rsci_wen_comp,
      a_rsci_idat_mxwt => mult_add_pipeline_core_a_rsci_inst_a_rsci_idat_mxwt
    );
  mult_add_pipeline_core_a_rsci_inst_a_rsc_dat <= a_rsc_dat;
  a_rsci_idat_mxwt <= mult_add_pipeline_core_a_rsci_inst_a_rsci_idat_mxwt;

  mult_add_pipeline_core_b_rsci_inst : mult_add_pipeline_core_b_rsci
    PORT MAP(
      clk => clk,
      rst => rst,
      b_rsc_dat => mult_add_pipeline_core_b_rsci_inst_b_rsc_dat,
      b_rsc_vld => b_rsc_vld,
      b_rsc_rdy => b_rsc_rdy,
      core_wen => core_wen,
      b_rsci_oswt => reg_c_rsci_iswt0_cse,
      b_rsci_wen_comp => b_rsci_wen_comp,
      b_rsci_idat_mxwt => mult_add_pipeline_core_b_rsci_inst_b_rsci_idat_mxwt
    );
  mult_add_pipeline_core_b_rsci_inst_b_rsc_dat <= b_rsc_dat;
  b_rsci_idat_mxwt <= mult_add_pipeline_core_b_rsci_inst_b_rsci_idat_mxwt;

  mult_add_pipeline_core_c_rsci_inst : mult_add_pipeline_core_c_rsci
    PORT MAP(
      clk => clk,
      rst => rst,
      c_rsc_dat => mult_add_pipeline_core_c_rsci_inst_c_rsc_dat,
      c_rsc_vld => c_rsc_vld,
      c_rsc_rdy => c_rsc_rdy,
      core_wen => core_wen,
      c_rsci_oswt => reg_c_rsci_iswt0_cse,
      c_rsci_wen_comp => c_rsci_wen_comp,
      c_rsci_idat_mxwt => mult_add_pipeline_core_c_rsci_inst_c_rsci_idat_mxwt
    );
  mult_add_pipeline_core_c_rsci_inst_c_rsc_dat <= c_rsc_dat;
  c_rsci_idat_mxwt <= mult_add_pipeline_core_c_rsci_inst_c_rsci_idat_mxwt;

  mult_add_pipeline_core_result_rsci_inst : mult_add_pipeline_core_result_rsci
    PORT MAP(
      clk => clk,
      rst => rst,
      result_rsc_dat => mult_add_pipeline_core_result_rsci_inst_result_rsc_dat,
      result_rsc_vld => result_rsc_vld,
      result_rsc_rdy => result_rsc_rdy,
      core_wen => core_wen,
      result_rsci_oswt => reg_result_rsci_iswt0_cse,
      result_rsci_wen_comp => result_rsci_wen_comp,
      result_rsci_idat => mult_add_pipeline_core_result_rsci_inst_result_rsci_idat
    );
  result_rsc_dat <= mult_add_pipeline_core_result_rsci_inst_result_rsc_dat;
  mult_add_pipeline_core_result_rsci_inst_result_rsci_idat <= result_rsci_idat_29_4
      & STD_LOGIC_VECTOR'( "0000");

  mult_add_pipeline_core_gain_rsc_triosy_obj_inst : mult_add_pipeline_core_gain_rsc_triosy_obj
    PORT MAP(
      gain_rsc_triosy_lz => gain_rsc_triosy_lz,
      core_wten => core_wten,
      gain_rsc_triosy_obj_iswt0 => reg_gain_adjust_rsc_triosy_obj_iswt0_cse
    );
  mult_add_pipeline_core_gain_adjust_rsc_triosy_obj_inst : mult_add_pipeline_core_gain_adjust_rsc_triosy_obj
    PORT MAP(
      gain_adjust_rsc_triosy_lz => gain_adjust_rsc_triosy_lz,
      core_wten => core_wten,
      gain_adjust_rsc_triosy_obj_iswt0 => reg_gain_adjust_rsc_triosy_obj_iswt0_cse
    );
  mult_add_pipeline_core_staller_inst : mult_add_pipeline_core_staller
    PORT MAP(
      clk => clk,
      rst => rst,
      core_wen => core_wen,
      core_wten => core_wten,
      a_rsci_wen_comp => a_rsci_wen_comp,
      b_rsci_wen_comp => b_rsci_wen_comp,
      c_rsci_wen_comp => c_rsci_wen_comp,
      result_rsci_wen_comp => result_rsci_wen_comp
    );
  mult_add_pipeline_core_core_fsm_inst : mult_add_pipeline_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      core_wen => core_wen,
      fsm_output => mult_add_pipeline_core_core_fsm_inst_fsm_output
    );
  fsm_output <= mult_add_pipeline_core_core_fsm_inst_fsm_output;

  sum_and_cse <= core_wen AND reg_gain_adjust_rsc_triosy_obj_iswt0_cse;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        result_rsci_idat_29_4 <= STD_LOGIC_VECTOR'( "00000000000000000000000000");
      ELSIF ( (core_wen AND main_stage_0_3) = '1' ) THEN
        result_rsci_idat_29_4 <= MUX_v_26_2_2((operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl(33
            DOWNTO 8)), sum_sva_1, and_2_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_gain_adjust_rsc_triosy_obj_iswt0_cse <= '0';
        reg_result_rsci_iswt0_cse <= '0';
        reg_c_rsci_iswt0_cse <= '0';
        main_stage_0_3 <= '0';
        product_mul_itm_1 <= STD_LOGIC_VECTOR'( "0000000000000000000000000");
        sum_c_tmp_sva_1 <= STD_LOGIC_VECTOR'( "0000000000000000000000000");
        CHECK_io_read_gain_adjust_rsc_svs_st_1 <= '0';
      ELSIF ( core_wen = '1' ) THEN
        reg_gain_adjust_rsc_triosy_obj_iswt0_cse <= fsm_output(1);
        reg_result_rsci_iswt0_cse <= main_stage_0_3;
        reg_c_rsci_iswt0_cse <= '1';
        main_stage_0_3 <= reg_gain_adjust_rsc_triosy_obj_iswt0_cse;
        product_mul_itm_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(a_rsci_idat_mxwt)
            * UNSIGNED(b_rsci_idat_mxwt)), 25));
        sum_c_tmp_sva_1 <= c_rsci_idat_mxwt;
        CHECK_io_read_gain_adjust_rsc_svs_st_1 <= gain_adjust_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        sum_sva_1 <= STD_LOGIC_VECTOR'( "00000000000000000000000000");
        CHECK_io_read_gain_adjust_rsc_svs_2 <= '0';
      ELSIF ( sum_and_cse = '1' ) THEN
        sum_sva_1 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(product_mul_itm_1),
            25), 26) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(sum_c_tmp_sva_1), 25),
            26), 26));
        CHECK_io_read_gain_adjust_rsc_svs_2 <= CHECK_io_read_gain_adjust_rsc_svs_st_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        gain_sva_2 <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (core_wen AND reg_gain_adjust_rsc_triosy_obj_iswt0_cse AND CHECK_io_read_gain_adjust_rsc_svs_st_1)
          = '1' ) THEN
        gain_sva_2 <= gain_sva_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        gain_sva_1 <= STD_LOGIC_VECTOR'( "0000000000");
      ELSIF ( (core_wen AND gain_adjust_rsci_idat) = '1' ) THEN
        gain_sva_1 <= gain_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  operator_10_2_true_AC_TRN_AC_WRAP_26_false_mul_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'(
      CONV_SIGNED(CONV_UNSIGNED(UNSIGNED(sum_sva_1), 26), 27) * SIGNED(gain_sva_2)),
      34));
  and_2_nl <= main_stage_0_3 AND (NOT CHECK_io_read_gain_adjust_rsc_svs_2);
END v12;

-- ------------------------------------------------------------------
--  Design Unit:    mult_add_pipeline
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_wait_pkg_v1.ALL;
USE work.ccs_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;
USE work.ccs_in_pkg_v1.ALL;


ENTITY mult_add_pipeline IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    a_rsc_dat : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
    a_rsc_vld : IN STD_LOGIC;
    a_rsc_rdy : OUT STD_LOGIC;
    b_rsc_dat : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    b_rsc_vld : IN STD_LOGIC;
    b_rsc_rdy : OUT STD_LOGIC;
    c_rsc_dat : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
    c_rsc_vld : IN STD_LOGIC;
    c_rsc_rdy : OUT STD_LOGIC;
    gain_rsc_dat : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    gain_rsc_triosy_lz : OUT STD_LOGIC;
    gain_adjust_rsc_dat : IN STD_LOGIC;
    gain_adjust_rsc_triosy_lz : OUT STD_LOGIC;
    result_rsc_dat : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
    result_rsc_vld : OUT STD_LOGIC;
    result_rsc_rdy : IN STD_LOGIC
  );
END mult_add_pipeline;

ARCHITECTURE v12 OF mult_add_pipeline IS
  -- Default Constants

  COMPONENT mult_add_pipeline_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      a_rsc_dat : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
      a_rsc_vld : IN STD_LOGIC;
      a_rsc_rdy : OUT STD_LOGIC;
      b_rsc_dat : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
      b_rsc_vld : IN STD_LOGIC;
      b_rsc_rdy : OUT STD_LOGIC;
      c_rsc_dat : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
      c_rsc_vld : IN STD_LOGIC;
      c_rsc_rdy : OUT STD_LOGIC;
      gain_rsc_dat : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      gain_rsc_triosy_lz : OUT STD_LOGIC;
      gain_adjust_rsc_dat : IN STD_LOGIC;
      gain_adjust_rsc_triosy_lz : OUT STD_LOGIC;
      result_rsc_dat : OUT STD_LOGIC_VECTOR (29 DOWNTO 0);
      result_rsc_vld : OUT STD_LOGIC;
      result_rsc_rdy : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL mult_add_pipeline_core_inst_a_rsc_dat : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_inst_b_rsc_dat : STD_LOGIC_VECTOR (13 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_inst_c_rsc_dat : STD_LOGIC_VECTOR (24 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_inst_gain_rsc_dat : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL mult_add_pipeline_core_inst_result_rsc_dat : STD_LOGIC_VECTOR (29 DOWNTO
      0);

BEGIN
  mult_add_pipeline_core_inst : mult_add_pipeline_core
    PORT MAP(
      clk => clk,
      rst => rst,
      a_rsc_dat => mult_add_pipeline_core_inst_a_rsc_dat,
      a_rsc_vld => a_rsc_vld,
      a_rsc_rdy => a_rsc_rdy,
      b_rsc_dat => mult_add_pipeline_core_inst_b_rsc_dat,
      b_rsc_vld => b_rsc_vld,
      b_rsc_rdy => b_rsc_rdy,
      c_rsc_dat => mult_add_pipeline_core_inst_c_rsc_dat,
      c_rsc_vld => c_rsc_vld,
      c_rsc_rdy => c_rsc_rdy,
      gain_rsc_dat => mult_add_pipeline_core_inst_gain_rsc_dat,
      gain_rsc_triosy_lz => gain_rsc_triosy_lz,
      gain_adjust_rsc_dat => gain_adjust_rsc_dat,
      gain_adjust_rsc_triosy_lz => gain_adjust_rsc_triosy_lz,
      result_rsc_dat => mult_add_pipeline_core_inst_result_rsc_dat,
      result_rsc_vld => result_rsc_vld,
      result_rsc_rdy => result_rsc_rdy
    );
  mult_add_pipeline_core_inst_a_rsc_dat <= a_rsc_dat;
  mult_add_pipeline_core_inst_b_rsc_dat <= b_rsc_dat;
  mult_add_pipeline_core_inst_c_rsc_dat <= c_rsc_dat;
  mult_add_pipeline_core_inst_gain_rsc_dat <= gain_rsc_dat;
  result_rsc_dat <= mult_add_pipeline_core_inst_result_rsc_dat;

END v12;



