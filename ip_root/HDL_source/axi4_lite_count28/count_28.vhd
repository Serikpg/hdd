library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

------------------------------------------
------------------------------------------
--
-- 28-bit synchronous binary counter with
-- synchronous reset (active low) and
-- enable (active high)
-- The 10 most bignificat bits of the
-- counter are connected to the leds
-- output
--
------------------------------------------
------------------------------------------

entity count_28 is
port(
		clk: in std_logic; 						-- clock input, active by rising edge
		reset_n: in std_logic; 					-- synchronous reset input, active low
		enable: in std_logic; 					-- enable input, active high
		leds: out std_logic_vector(9 downto 0) 	-- 10 most significant bits of the counter
);
end count_28;


architecture bevahiour of count_28 is

-- Auxiliary signal for the counter
signal count_28: std_logic_vector(27 downto 0);


begin


	-- Process that defines the behaviour of the counter
	count_process: process(clk)
	begin
		if (clk'event and clk= '1') then
			if (reset_n = '0') then
				count_28 <= (others => '0');
			elsif (enable = '1') then
				count_28 <= count_28 + 1;
			end if;
		end if;
	end process;
	
	-- Output assignment for the ZedBoard LEDs
	leds <= count_28(27 downto 18);
	
end bevahiour;
