----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:34:01 04/05/2023 
-- Design Name: 
-- Module Name:    cloud - Behavioral 
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

entity cloud is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmControl : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end cloud;

architecture Behavioral of cloud is

begin
	
	process(Instr, ImmControl) begin
		
		-- zerofill
		if ImmControl = "00" then 
			Immed(15 downto 0) <= Instr;
			Immed(31 downto 16) <= (others => '0');
		-- signextend
		elsif ImmControl = "01" then 
			Immed(15 downto 0) <= Instr;
			Immed(31 downto 16) <= (others => Instr(15));
		-- shift and zerofill
		elsif ImmControl = "10" then 
			Immed(31 downto 16) <= Instr;
			Immed(15 downto 0) <= (others => '0');
		-- signextend and shift
		elsif ImmControl = "11" then 
			Immed(31 downto 18) <= (others => Instr(15));
			Immed(17 downto 2) <= Instr;
			Immed(1 downto 0) <= "00";
		else
			Immed <= x"00000000";
		end if;
	end process;			

end Behavioral;
