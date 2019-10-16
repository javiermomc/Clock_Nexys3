----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    23:24:37 10/08/2019 
-- Design Name: 
-- Module Name:    Cont0a23 - Cont0a23_Arch 
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

entity Cont0a23 is

  port (
    Load     : in  STD_LOGIC;
    Enable   : in  STD_LOGIC;
	 Rst      : in  STD_LOGIC;
    Clk      : in  STD_LOGIC;
	 ValorDec : in  STD_LOGIC_VECTOR(3 downto 0);
	 ValorUni : in  STD_LOGIC_VECTOR(3 downto 0);
	 Cuenta   : out STD_LOGIC_VECTOR(7 downto 0));
end Cont0a23;

architecture Cont0a23_Arch of Cont0a23 is
  
  signal countUni : STD_LOGIC_VECTOR(3 downto 0);
  signal countDec : STD_LOGIC_VECTOR(3 downto 0);

begin

process(Rst,Clk, Load, ValorDec, ValorUni, countUni, countDec)
  begin
    if (Rst = '1') then
	     countUni <= (others => '0');
		  countDec <= (others => '0');
	 elsif (rising_edge(Clk)) then
	  if (Load = '1') then
		    countUni <= ValorUni;
		    countDec <= ValorDec;	
	  elsif (Enable = '1') then
		 if (countUni = "0011" and countDec = "0010") then
			 countDec <= "0000";
			 countUni <= "0000";
		 elsif (countUni = "1001") then
			 countUni <= (others => '0');
			 countDec <= countDec +1;
		 else
		   countUni <= countUni + 1;
		 end if;
		end if;
	 end if;
	 Cuenta <= countDec&countUni;
  end process;
  
end Cont0a23_Arch;

