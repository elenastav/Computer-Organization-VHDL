----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:44 03/18/2023 
-- Design Name: 
-- Module Name:    mux_32to1 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


package arrayofvectors is
type array_in is array(31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.arrayofvectors.all;

entity mux_32to1 is
    Port ( muxin : in  array_in;
           sel : in  STD_LOGIC_VECTOR(4 downto 0);
           muxout : out  STD_LOGIC_VECTOR(31 downto 0));
end mux_32to1;

architecture Behavioral of mux_32to1 is

SIGNAL tempout: STD_LOGIC_VECTOR (31 downto 0);

begin

with sel select
tempout <= muxin(0) when "00000",
muxin(1) when "00001",
muxin(2) when "00010",
muxin(3) when "00011",
muxin(4) when "00100",
muxin(5) when "00101",
muxin(6) when "00110",
muxin(7) when "00111",
muxin(8) when "01000",
muxin(9) when "01001",
muxin(10) when "01010",
muxin(11) when "01011",
muxin(12) when "01100",
muxin(13) when "01101",
muxin(14) when "01110",
muxin(15) when "01111",
muxin(16) when "10000",
muxin(17) when "10001",
muxin(18) when "10010",
muxin(19) when "10011",
muxin(20) when "10100",
muxin(21) when "10101",
muxin(22) when "10110",
muxin(23) when "10111",
muxin(24) when "11000",
muxin(25) when "11001",
muxin(26) when "11010",
muxin(27) when "11011",
muxin(28) when "11100",
muxin(29) when "11101",
muxin(30) when "11110",
muxin(31) when "11111",
x"00000000" when others;

muxout <= tempout after 10ns;

end Behavioral;
