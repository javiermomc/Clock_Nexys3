----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:54:44 10/08/2019 
-- Design Name: 
-- Module Name:    RefreshDisplay - RefreshDisplay_arch
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity RefreshDisplay is
	port (
		Rst      : in  STD_LOGIC;
		Clk      : in  STD_LOGIC;
		ClkOut   : out STD_LOGIC);
end RefreshDisplay;

architecture RefreshDisplay_arch of RefreshDisplay is

	constant BoardFreq    : integer := 100_000_000;
	constant DesiredFreq   : integer := 800;
	constant MaxCountM    : integer := BoardFreq/DesiredFreq;
	-- constant QuarterMaxCount : integer := MaxCountM/4 -1;
	signal Count100M    : integer range 0 to MaxCountM;
	
	-- Other embedded signals
	signal Toggle       : STD_LOGIC;

begin

--Enables a 800Hz signal
	Frequency_Divider: process(Rst, Clk)
		begin
			if (Rst = '1') then
				Count100M <= 0;
			elsif (rising_edge(Clk)) then
				if (Count100M = MaxCountM) then
					Count100M <= 0;
					ClkOut <= '1';
				else
					Count100M <= Count100M + 1;
					ClkOut <= '0';
				end if;
			end if;
		end process Frequency_Divider;

end RefreshDisplay_arch;

