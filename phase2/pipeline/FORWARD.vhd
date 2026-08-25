----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:39:13 06/06/2023 
-- Design Name: 
-- Module Name:    FORWARD - Behavioral 
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

entity FORWARD is 
	port( EX_MEM_RegWrite : in STD_LOGIC;
			MEM_WB_RegWrite : in STD_LOGIC;
			EX_MEM_RegisterRD : in STD_LOGIC_VECTOR(4 downto 0);
			MEM_WB_RegisterRD : in STD_LOGIC_VECTOR(4 downto 0);
			ID_EX_RegisterRS : in STD_LOGIC_VECTOR(4 downto 0);
			ID_EX_RegisterRT : in STD_LOGIC_VECTOR(4 downto 0);
			ForwardA : out STD_LOGIC_VECTOR(1 downto 0);
			ForwardB : out STD_LOGIC_VECTOR(1 downto 0)
	);
end FORWARD;


architecture Behavioral of FORWARD is

begin
	
	forwarding_pro: process( EX_MEM_RegWrite, EX_MEM_RegisterRD, ID_EX_RegisterRS, 
	ID_EX_RegisterRT, MEM_WB_RegWrite, MEM_WB_RegisterRD)
	
	begin
					
	if(EX_MEM_RegWrite = '1' and (EX_MEM_RegisterRD /= "00000") and (EX_MEM_RegisterRD = ID_EX_RegisterRS) ) then
		ForwardA <= "10";
	elsif(MEM_WB_RegWrite = '1' and (MEM_WB_RegisterRD /= "00000") and (MEM_WB_RegisterRD = ID_EX_RegisterRS) ) then
		ForwardA <= "01";
	else
		ForwardA <= "00";
	end if;
			
	if(EX_MEM_RegWrite = '1' and (EX_MEM_RegisterRD /= "00000") and (EX_MEM_RegisterRD = ID_EX_RegisterRT) ) then
		ForwardB <= "10";
	elsif(MEM_WB_RegWrite = '1' and (MEM_WB_RegisterRD /= "00000") and (MEM_WB_RegisterRD = ID_EX_RegisterRT) ) then
		ForwardB <= "01";
	else
		ForwardB <= "00";
	end if;
	
	end process;

end Behavioral;



