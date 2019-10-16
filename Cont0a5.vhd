----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    23:23:19 10/08/2019 
-- Design Name: 
-- Module Name:    Cont0a5 - Cont0a5_Arch 
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

entity Cont0a5 is

  port (
    Load   : in  STD_LOGIC;
    Enable : in  STD_LOGIC;
	 Rst    : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
	 Valor  : in  STD_LOGIC_VECTOR(3 downto 0);
	 TCO    : out STD_LOGIC;
	 Cuenta : out STD_LOGIC_VECTOR(3 downto 0));
end Cont0a5;

architecture Cont0a5_Arch of Cont0a5 is
  signal count: STD_LOGIC_VECTOR (3 downto 0);

begin

  -- 0 to 5 Counter 
	process(Rst, Clk, Valor)
	begin
		if (Rst = '1') then
			count <= (others => '0');
		elsif (rising_edge(Clk)) then
			if (Load = '1') then	
				count <= Valor;
			end if;
			if (Enable = '1') then 
				if(count = "0101") then
					count <= (others => '0');
				else 
					count <= count + 1;
				end if;
			end if;
		end if;
	end process;	
	Cuenta <= count;
		TCO <= '1' when count = "0101" else
		'0';
	
end Cont0a5_Arch;

