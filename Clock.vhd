----------------------------------------------------------------------------------
-- Company: 		 ITESM Qro
-- Engineer: 		 Sarahí
-- 
-- Create Date:    13:57:46 10/08/2019 
-- Design Name: 
-- Module Name:    Clock - Clock_Arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 1.0
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Clock is
    Port ( HorEn     : in 	 STD_LOGIC;
           DecEnt    : in   STD_LOGIC_VECTOR (3 downto 0);
           MinEn     : in   STD_LOGIC;
           UniEnt    : in   STD_LOGIC_VECTOR (3 downto 0);
           Rst       : in   STD_LOGIC;
           Clk100MHz : in   STD_LOGIC;
           Seg       : out  STD_LOGIC_VECTOR (7 downto 0);
           Disp      : out  STD_LOGIC_VECTOR (3 downto 0);
			  SegOut    : out  STD_LOGIC_VECTOR (7 downto 0));
end Clock;

architecture Clock_Arch of Clock is
  -- Component Declarations
  
  -- Derives a 1Hz Enable signal from the Nexys3 100MHz clock.
  component Clk1Hz
  port (
    Rst 	  : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
    ClkOut : out STD_LOGIC);
  end component;
  
  -- Counter 0 to 9, used for seconds and minuts
  component Cont0a9
  port (
    Load   : in  STD_LOGIC;
    Enable : in  STD_LOGIC;
	 Rst    : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
	 Valor  : in  STD_LOGIC_VECTOR(3 downto 0);
	 TCO    : out STD_LOGIC;
	 Cuenta : out STD_LOGIC_VECTOR(3 downto 0));
  end component;
   
  -- Counter 0 to 5, used for seconds and minuts
  component Cont0a5
  port (
    Load   : in  STD_LOGIC;
    Enable : in  STD_LOGIC;
	 Rst    : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
	 Valor  : in  STD_LOGIC_VECTOR(3 downto 0);
	 TCO    : out STD_LOGIC;
	 Cuenta : out STD_LOGIC_VECTOR(3 downto 0));
  end component;
  
  -- Counter 0 to 23, used for seconds and minuts
  component Cont0a23
  port (
    Load     : in  STD_LOGIC;
    Enable   : in  STD_LOGIC;
	 Rst      : in  STD_LOGIC;
    Clk      : in  STD_LOGIC;
	 ValorDec : in  STD_LOGIC_VECTOR(3 downto 0);
	 ValorUni : in  STD_LOGIC_VECTOR(3 downto 0);
	 Cuenta   : out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  -- 
  component RefreshDisplay
  port (
    Rst    : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
	 ClkOut : out STD_LOGIC);
  end component;
  
  -- Counter 0 to 3 
  component Cont0a3
  port (
	 Enable : in  STD_LOGIC;
    Rst    : in  STD_LOGIC;
    Clk    : in  STD_LOGIC;
	 Cuenta : out STD_LOGIC_VECTOR(1 downto 0));
  end component;
  
  -- Mux 4 to 1
  component Mux4to1
  port (
    DecHor : in  STD_LOGIC_VECTOR(7 downto 4);
    UniHor : in  STD_LOGIC_VECTOR(3 downto 0);
	 DecMin : in  STD_LOGIC_VECTOR(3 downto 0);
    UniMin : in  STD_LOGIC_VECTOR(3 downto 0);
	 Sel    : in  STD_LOGIC_VECTOR(1 downto 0);
	 Tiempo : out STD_LOGIC_VECTOR(3 downto 0));
  end component;
  
  -- 
  component DecBCD7Seg
  port (
    BCD : in  STD_LOGIC_VECTOR(3 downto 0);
	 Seg : out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  -- To select an anodo
  component SelAnodo
  port (
    Sel   : in  STD_LOGIC_VECTOR(1 downto 0);
	 Anodo : out STD_LOGIC_VECTOR(3 downto 0));
  end component;


  -- Embedded signal declaration
  -- 1-bit embedded signals
  signal EnHoras_int    :  STD_LOGIC;
  signal EnDecMin_int   :  STD_LOGIC;
  signal EnUniMin_int   :  STD_LOGIC;
  signal EnSeg_int      :  STD_LOGIC;
  signal EnDecSeg_int   :  STD_LOGIC;
  signal Clk1Hz_int     :  STD_LOGIC;
  signal TCODecMin_int  :  STD_LOGIC;
  signal TCOUniMin_int  :  STD_LOGIC;
  signal TCODecSeg_int  :  STD_LOGIC;
  signal TCOUniSeg_int  :  STD_LOGIC;
  signal ClkRefresh_int :  STD_LOGIC;
  -- 2-bit embedded signals
  signal Sel_int :  STD_LOGIC_VECTOR(1 downto 0);
  -- 4-bit embedded signals
  signal DecMin_int :  STD_LOGIC_VECTOR(3 downto 0);
  signal UniMin_int :  STD_LOGIC_VECTOR(3 downto 0); 
  signal Tiempo_int :  STD_LOGIC_VECTOR(3 downto 0);   
  -- 8-bit embedded signals
  signal Hor_int :  STD_LOGIC_VECTOR(7 downto 0);


begin

  -- Include individual gates from top schematic
  EnHoras_int  <= EnDecMin_int  and TCODecMin_int and Clk1Hz_int;
  EnDecMin_int <= EnUniMin_int  and TCOUniMin_int and Clk1Hz_int;
  EnUniMin_int <= TCOUniSeg_int and TCODecSeg_int and Clk1Hz_int;
  EnSeg_int    <= HorEn         or  MinEn;
  EnDecSeg_int <= TCOUniSeg_int and Clk1Hz_int;
  
  U1: Clk1Hz
  port map (
    Rst,
    Clk100MHz,
	 Clk1Hz_int);
	 
  U2: Cont0a9
  port map (
    EnSeg_int,
    Clk1Hz_int,
	 Rst,
	 Clk100MHz,
	 "0000",
	 TCOUniSeg_int,
	 SegOut(3 downto 0));
	  
  U3: Cont0a5
  port map (
    EnSeg_int,
    EnDecSeg_int,
	 Rst,
	 Clk100MHz,
	 "0000",
	 TCODecSeg_int,
	 SegOut(7 downto 4));
	 
  U4: Cont0a9
  port map (
    MinEn,
    EnUniMin_int,
	 Rst,
	 Clk100MHz,
	 UniEnt,
	 TCOUniMin_int,
	 UniMin_int);
	 
  U5: Cont0a5
  port map (
    MinEn,
    EnDecMin_int,
	 Rst,
	 Clk100MHz,
	 DecEnt,
	 TCODecMin_int,
	 DecMin_int);

  U6: Cont0a23
  port map (
    HorEn,
    EnHoras_int,
	 Rst,
	 Clk100MHz,
	 DecEnt,
	 UniEnt,
	 Hor_int);
	 
  U7: RefreshDisplay
  port map (
	Rst,
	Clk100MHz,
	ClkRefresh_int);
	
  U8: Cont0a3
  port map (
	ClkRefresh_int,
	Rst,
	Clk100Mhz,
	Sel_int);
	
	
  U9: Mux4to1
  port map (
    Hor_int(7 downto 4),
    Hor_int(3 downto 0),
	 DecMin_int,
	 UniMin_int,
	 Sel_int,
	 Tiempo_int);
	 
  U10: SelAnodo
  port map (
	Sel_int,
   Disp);
	
  U11: DecBCD7Seg
  port map (
	Tiempo_int,
   Seg);
	
end Clock_Arch;

