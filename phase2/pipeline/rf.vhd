----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:22 03/18/2023 
-- Design Name: 
-- Module Name:    rf - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
use work.arrayofvectors.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity rf is
    Port ( CLK : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end rf;

architecture Behavioral of rf is

component reg_32bit is
port( CLK, Reset, WE : in STD_LOGIC;
Data : in STD_LOGIC_VECTOR(31 downto 0);
Dout : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component decoder_5to32 is
port( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component mux_32to1 is
port( muxin : in  array_in;
sel : in  STD_LOGIC_VECTOR(4 downto 0);
muxout : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

signal decoder_out : STD_LOGIC_VECTOR (31 downto 0);
signal temp_reg : STD_LOGIC_VECTOR (31 downto 0);
signal temp_reg_we : STD_LOGIC_VECTOR (31 downto 0);
signal mux_input : array_in;

begin

decoder: decoder_5to32 port map( Awr => Awr,
Dout => decoder_out);

registers: for i in 1 to 31 generate
temp_reg(i) <= decoder_out(i) and WrEn;
temp_reg_we(i) <= temp_reg(i) after 2 ns;

Ri: reg_32bit port map( CLK => CLK,
 Reset => Reset,
 WE => temp_reg_we(i),
 Data => Din,
 Dout => mux_input(i));
end generate;

R0: reg_32bit port map( CLK => CLK,
 Reset => Reset,
 WE => '1',
 Data => "00000000000000000000000000000000",
 Dout => mux_input(0));

mux1: mux_32to1 port map( muxin => mux_input,
sel => Ard1,
muxout => Dout1);

mux2: mux_32to1 port map( muxin => mux_input,
sel => Ard2,
muxout => Dout2);

end Behavioral;

