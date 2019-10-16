----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    23:28:44 10/08/2019 
-- Design Name: 
-- Module Name:    SelAnodo - SelAnodo_Arch 
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
entity SelAnodo is

  port (
    Sel   : in  STD_LOGIC_VECTOR(1 downto 0);
	 Anodo : out STD_LOGIC_VECTOR(3 downto 0));
end SelAnodo;

architecture SelAnodo_Arch of SelAnodo is

begin

  with Sel select
       Anodo <=   "1110" when "00",
                  "1101" when "01",
					   "1011" when "10",
                  "0111" when others;

end SelAnodo_Arch;

