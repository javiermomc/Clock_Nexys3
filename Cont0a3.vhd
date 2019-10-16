------------------------------------------------------------------------------------
---- Company: 		   ITESM Qro
---- Engineer: 		Sarahí
---- 
---- Create Date:    23:26:39 10/08/2019 
---- Design Name: 
---- Module Name:    Cont0a3 - Cont0a3_Arch 
---- Project Name: 
---- Target Devices: 
---- Tool versions: 
---- Description: 
----
---- Dependencies: 
----
---- Revision: 
---- Revision 0.01 - File Created
---- Additional Comments: 
----
------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Cont0a3 is
	port (
		Enable   : in  STD_LOGIC;
		Rst      : in  STD_LOGIC;
		Clk      : in  STD_LOGIC;
		Cuenta   : out STD_LOGIC_VECTOR (1 downto 0));
end Cont0a3;

architecture Behavioral of Cont0a3 is

	signal count : STD_LOGIC_VECTOR(1 downto 0);

begin

  process(Rst,Clk,Enable)
  begin
    --Asynchronous Reset
    if (Rst = '1') then
	   count <= (others => '0');
	 elsif (rising_edge(Clk)) then
		if (Enable = '1') then
	    if (count = "11") then
		   count <= (others => '0');
		 else
		   count <= count + 1;
		 end if;
		end if;
	 end if;
  end process;
  
  Cuenta <= count;

end Behavioral;


