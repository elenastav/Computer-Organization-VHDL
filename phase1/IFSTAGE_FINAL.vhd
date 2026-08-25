----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:44 03/28/2023 
-- Design Name: 
-- Module Name:    IFSTAGE_FINAL - Behavioral 
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

entity IFSTAGE_FINAL is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
    	   PC_sel : in  STD_LOGIC;
    	   PC_LdEn : in  STD_LOGIC;
    	   Reset : in  STD_LOGIC;
    	   Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR(31 downto 0));
end IFSTAGE_FINAL;

architecture Behavioral of IFSTAGE_FINAL is
 
component IFSTAGE
	port(    PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MyMemory
	port(  CLKA : in  STD_LOGIC;
           ADDRA : in  STD_LOGIC_VECTOR(9 downto 0);
           DOUTA : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

signal PC_tmp : STD_LOGIC_VECTOR(31 downto 0);

begin

ifstg: IFSTAGE port map( PC_Immed => PC_Immed,
							    PC_sel => PC_sel,
							    PC_LdEn => PC_LdEn,
							    Reset => Reset,
							    CLK => CLK,
							    PC_out => PC_tmp);

mem : MyMemory port map( CLKA => CLK,
						 ADDRA => PC_tmp(11 downto 2),
						 DOUTA => Instr);

end Behavioral;





