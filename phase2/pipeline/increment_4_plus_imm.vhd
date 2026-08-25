----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:	22:15:37 03/19/2023
-- Design Name:
-- Module Name:	ncrement_4_plus_imm - Behavioral
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
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity increment_4_plus_imm is
	Port ( immediate : in  STD_LOGIC_VECTOR (31 downto 0);
       	incr_out1 : in  STD_LOGIC_VECTOR (31 downto 0);
       	incr_out2 : out  STD_LOGIC_VECTOR (31 downto 0));
end increment_4_plus_imm;

architecture Behavioral of increment_4_plus_imm is

begin

    incr_out2 <= incr_out1 + STD_LOGIC_VECTOR(shift_left(unsigned(immediate),2));
    
end Behavioral;
