----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:08:00 03/28/2023 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

	component reg_32bit is
		port ( CLK : in  STD_LOGIC;
				 Reset : in  STD_LOGIC;
				 WE : in  STD_LOGIC;
				 Data : in  STD_LOGIC_VECTOR (31 downto 0);
				 Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component mux_2to1 is
		port ( muxin_0 : in  STD_LOGIC_VECTOR (31 downto 0); 
				 muxin_1 : in  STD_LOGIC_VECTOR (31 downto 0); 
				 sel : in  STD_LOGIC;
				 muxout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component increment_4 is
		port ( incr_in : in  STD_LOGIC_VECTOR (31 downto 0);
             incr_out1 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component increment_4_plus_imm is
		port ( immediate : in  STD_LOGIC_VECTOR (31 downto 0);
             incr_out1 : in  STD_LOGIC_VECTOR (31 downto 0);
             incr_out2 : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal PC_in: STD_LOGIC_VECTOR (31 downto 0);
	signal muxin0: STD_LOGIC_VECTOR (31 downto 0);
	signal muxin1: STD_LOGIC_VECTOR (31 downto 0);
	signal PC_out_tmp: STD_LOGIC_VECTOR (31 downto 0);

begin

	reg32: reg_32bit port map( CLK => Clk,
											Reset => Reset,
											Data => PC_in,
											WE => PC_LdEn,
											Dout => PC_out_tmp);
	
	incr4: increment_4 port map( incr_in => PC_out_tmp,
									incr_out1 => muxin0);
									
	incr4imm: increment_4_plus_imm port map( immediate => PC_Immed,
												incr_out1 => muxin0,
												incr_out2 => muxin1);
												
	mux2x1: mux_2to1 port map( muxin_0 => muxin0,
										 muxin_1 => muxin1,
										 sel => PC_sel,
										 muxout => PC_in);
	
	PC_out <= PC_out_tmp;


end Behavioral;





