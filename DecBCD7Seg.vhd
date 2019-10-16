----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    23:29:40 10/08/2019 
-- Design Name: 
-- Module Name:    DecBCD7Seg - DecBCD7Seg_Arch 
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


entity DecBCD7Seg is

  port (
    BCD : in  STD_LOGIC_VECTOR(3 downto 0);
	 Seg : out STD_LOGIC_VECTOR(7 downto 0));
end DecBCD7Seg;

architecture DecBCD7Seg_Arch of DecBCD7Seg is

begin

   Seg  <= x"C0" when (BCD = x"0") else
           x"F9" when (BCD = x"1") else
			  x"A4" when (BCD = x"2") else
           x"B0" when (BCD = x"3") else
			  x"99" when (BCD = x"4") else
           x"92" when (BCD = x"5") else
			  x"82" when (BCD = x"6") else
           x"F8" when (BCD = x"7") else
			  x"80" when (BCD = x"8") else
           x"90" when (BCD = x"9") else
			  x"88" when (BCD = x"A") else
           x"83" when (BCD = x"B") else
			  x"C6" when (BCD = x"C") else
           x"A1" when (BCD = x"D") else
			  x"86" when (BCD = x"E") else
           x"8E" when (BCD = x"F") else
           x"7F";

end DecBCD7Seg_Arch;

