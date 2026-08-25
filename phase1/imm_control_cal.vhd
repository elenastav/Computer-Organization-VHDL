----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:34:01 04/05/2023 
-- Design Name: 
-- Module Name:    imm_control_cal - Behavioral 
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

entity imm_control_cal is
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           ImmControl : out  STD_LOGIC_VECTOR (1 downto 0));
end imm_control_cal;

architecture Behavioral of imm_control_cal is

begin
	              -- zerofill
	ImmControl <= "00" when (opcode = "110010" or opcode = "110011") else
                 -- signextend	
				     "01" when (opcode = "111000" or opcode = "110000" or opcode =  "000011" or 
	                       opcode =  "000111" or opcode =  "001111"  or opcode =  "011111") else 
						-- shift and zero fill
				     "10" when (opcode = "111001") else
					  -- signextend and shift 
				     "11" when (opcode = "111111"  or opcode = "010000" or opcode = "010001") else 
				     "UU"; 

end Behavioral;

