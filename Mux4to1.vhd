----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    23:27:58 10/08/2019 
-- Design Name: 
-- Module Name:    Mux4to1 - Mux4to1_Arch 
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

entity Mux4to1 is

  port (
    DecHor : in  STD_LOGIC_VECTOR(7 downto 4);
    UniHor : in  STD_LOGIC_VECTOR(3 downto 0);
	 DecMin : in  STD_LOGIC_VECTOR(3 downto 0);
    UniMin : in  STD_LOGIC_VECTOR(3 downto 0);
	 Sel    : in  STD_LOGIC_VECTOR(1 downto 0);
	 Tiempo : out STD_LOGIC_VECTOR(3 downto 0));
end Mux4to1;

architecture Mux4to1_Arch of Mux4to1 is

begin

  process (DecHor,UniHor,DecMin,UniMin,Sel)
  begin
    if (Sel ="00") then
        Tiempo <= UniMin;
    elsif (Sel ="01") then
        Tiempo <= DecMin;
	 elsif (Sel ="10") then
        Tiempo <= UniHor;
	 elsif (Sel ="11") then
        Tiempo <= DecHor;
    end if;
  end process;

end Mux4to1_Arch;

