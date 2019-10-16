----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    23:21:42 10/08/2019 
-- Design Name: 
-- Module Name:    Cont0a9 - Cont0a9_Arch 
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


entity Cont0a9 is

  port (
    Load   : in  STD_LOGIC;
    Enable : in  STD_LOGIC;
	 Rst    : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
	 Valor  : in  STD_LOGIC_VECTOR(3 downto 0);
	 TCO    : out STD_LOGIC;
	 Cuenta : out STD_LOGIC_VECTOR(3 downto 0));
end Cont0a9;

architecture Cont0a9_Arch of Cont0a9 is
  signal Count : STD_LOGIC_VECTOR (3 downto 0);
  
begin

  Counter0a9: process(Rst, Clk, Count)
  begin
    if (Rst = '1') then
		Count <= (others => '0');
	 elsif (rising_edge(Clk)) then
		if (Load = '0') then		
	     if (Enable = '1') then
		    if (Count = "1001") then 
			   Count <= (others => '0');
			 else
			   Count <= Count + 1;
		    end if;
	     end if;
		elsif(Load = '1') then
        Count <= Valor;		
		end if;
    end if;
  end process Counter0a9;
  Cuenta <= Count; 
  TCO <= '1' when count = "1001" else
		'0';

end Cont0a9_Arch;

