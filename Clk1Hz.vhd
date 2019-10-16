----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    23:13:55 10/08/2019 
-- Design Name: 
-- Module Name:    Clk1Hz - Clk1Hz_Arch 
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

entity Clk1Hz is
  port (
    Rst 	  : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
    ClkOut : out STD_LOGIC);


end Clk1Hz;

architecture Clk1Hz_Arch of Clk1Hz is
 -- Embedded signals used by the Frequency_Divider
  constant MaxCountM : integer := 99_999_999;
  signal Count100M : integer range 0 to MaxCountM;

begin

    -- Implementation of a Frequency Divider
  -- Derive a 1Hz Enable signal from the
  -- 100,000,000 Hz Xtal Oscillator found on
  -- the Nexys 3 board.
  Frequency_Divider: process(Clk,Rst)
  begin
    if (Rst = '1') then
	   Count100M <= 0;
    elsif (rising_edge(Clk)) then
	   if (Count100M = MaxCountM) then
		  ClkOut   <= '1';
		  Count100M <= 0;
		else
		  ClkOut   <= '0';
		  Count100M <= Count100M + 1;
		end if;
	 end if;	  
  end process Frequency_Divider;


end Clk1Hz_Arch;

