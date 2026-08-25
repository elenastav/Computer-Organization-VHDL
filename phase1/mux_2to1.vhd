----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:	22:07:16 03/19/2023
-- Design Name:
-- Module Name:	mux_2to1 - Behavioral
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

 entity mux_2to1 is
	Port ( muxin_0 : in  STD_LOGIC_VECTOR (31 downto 0);
       	muxin_1 : in  STD_LOGIC_VECTOR (31 downto 0);
       	sel : in  STD_LOGIC;
       	muxout : out  STD_LOGIC_VECTOR (31 downto 0));
end mux_2to1;

architecture Behavioral of mux_2to1 is

begin

    with sel select
   	 muxout <= 	muxin_0 when '0',
   		        	muxin_1 when '1',
   			 	x"00000000" when others;


end Behavioral;
