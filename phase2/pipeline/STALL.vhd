----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:33:36 06/06/2023 
-- Design Name: 
-- Module Name:    STALL - Behavioral 
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

entity STALL is
    Port ( ID_EX_MemRead : in  STD_LOGIC;
    	     ID_EX_RegisterRT : in std_logic_vector(4 downto 0);
    	     IF_ID_RegisterRT : in std_logic_vector(4 downto 0);
    	     IF_ID_RegisterRS : in std_logic_vector(4 downto 0);
    	     Stalling : out std_logic);
end STALL;

architecture Behavioral of STALL is

begin
stalling_pro : process(ID_EX_MemRead, ID_EX_RegisterRT, IF_ID_RegisterRT, IF_ID_RegisterRS)
begin 

if (ID_EX_MemRead = '1') then
	if(IF_ID_RegisterRS = ID_EX_RegisterRT or IF_ID_RegisterRT = ID_EX_RegisterRT) then
		Stalling <= '1';
    else 
    	Stalling <= '0';
    end if;
else
	Stalling <= '0';

end if;

end process;


end Behavioral;
