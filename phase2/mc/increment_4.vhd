----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:	22:14:40 03/19/2023
-- Design Name:
-- Module Name:	increment_4 - Behavioral
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
use  ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity increment_4 is
	Port ( incr_in : in  STD_LOGIC_VECTOR (31 downto 0);
       	incr_out1 : out  STD_LOGIC_VECTOR (31 downto 0));
end increment_4;

architecture Behavioral of increment_4 is

begin

    incr_out1 <= incr_in + "00000000000000000000000000000100";

end Behavioral;
