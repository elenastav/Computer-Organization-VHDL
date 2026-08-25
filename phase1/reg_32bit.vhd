----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:47:31 03/18/2023 
-- Design Name: 
-- Module Name:    reg_32bit - Behavioral 
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

entity reg_32bit is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end reg_32bit;

architecture Behavioral of reg_32bit is

begin

Reg_process: process(CLK, Reset)

begin

if rising_edge(CLK) then

  if Reset = '1' then
     Dout <= x"00000000" after 10 ns;
  elsif WE = '1' then
     Dout <= Data after 10 ns;
  end if;

end if;

end process;

end Behavioral;

