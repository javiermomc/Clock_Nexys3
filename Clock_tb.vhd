--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:36:12 10/09/2019
-- Design Name:   
-- Module Name:   C:/ProgSisDigAva/P18_Clock/Clock_tb.vhd
-- Project Name:  P18_Clock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Clock
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
 
ENTITY Clock_tb IS
END Clock_tb;
 
ARCHITECTURE behavior OF Clock_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Clock
    PORT(
         HorEn : IN  std_logic;
         DecEnt : IN  std_logic_vector(3 downto 0);
         MinEn : IN  std_logic;
         UniEnt : IN  std_logic_vector(3 downto 0);
         Rst : IN  std_logic;
         Clk100MHz : IN  std_logic;
         Seg : OUT  std_logic_vector(7 downto 0);
         Disp : OUT  std_logic_vector(3 downto 0);
         SegOut : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal HorEn : std_logic := '0';
   signal DecEnt : std_logic_vector(3 downto 0) := (others => '0');
   signal MinEn : std_logic := '0';
   signal UniEnt : std_logic_vector(3 downto 0) := (others => '0');
   signal Rst : std_logic := '0';
   signal Clk100MHz : std_logic := '0';

 	--Outputs
   signal Seg : std_logic_vector(7 downto 0);
   signal Disp : std_logic_vector(3 downto 0);
   signal SegOut : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant Clk100MHz_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Clock PORT MAP (
          HorEn => HorEn,
          DecEnt => DecEnt,
          MinEn => MinEn,
          UniEnt => UniEnt,
          Rst => Rst,
          Clk100MHz => Clk100MHz,
          Seg => Seg,
          Disp => Disp,
          SegOut => SegOut
        );

   -- Clock process definitions
   Clk100MHz_process :process
   begin
		Clk100MHz <= '0';
		wait for Clk100MHz_period/2;
		Clk100MHz <= '1';
		wait for Clk100MHz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk100MHz_period*1;

      -- insert stimulus here 
		Rst <= '0';
		HorEn <= '0';
		MinEn <= '0';
		DecEnt <= "0000";
		UniEnt <= "0000";
      wait;
   end process;

END;
