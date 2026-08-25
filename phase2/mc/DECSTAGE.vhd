----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:49 04/05/2023 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  Reset : in STD_LOGIC);
end DECSTAGE;

architecture Behavioral of DECSTAGE is

	component rf is
    Port ( CLK : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
	end component;
	
	component mux_2to1 is
    Port ( muxin_0 : in  STD_LOGIC_VECTOR (31 downto 0); 
           muxin_1 : in  STD_LOGIC_VECTOR (31 downto 0); 
           sel : in  STD_LOGIC;
           muxout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component cloud is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmControl : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component imm_control_cal is
	Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           ImmControl : out  STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
	signal mux1_out : STD_LOGIC_VECTOR (31 downto 0);
	signal mux2_out : STD_LOGIC_VECTOR (31 downto 0);
	signal muxin_2 : STD_LOGIC_VECTOR (31 downto 0);
	signal muxin_3 : STD_LOGIC_VECTOR (31 downto 0);
	signal Imm_Control : STD_LOGIC_VECTOR (1 downto 0);
	
begin

	--zerofill the 5-bit inputs of the mux
	muxin_2 <= "000000000000000000000000000" & Instr(15 downto 11);
	muxin_3 <= "000000000000000000000000000" & Instr(20 downto 16);
	
	ctrl: imm_control_cal port map(opcode => Instr(31 downto 26),
									 ImmControl => Imm_Control);
	
	cld: cloud port map( Instr => Instr(15 downto 0),
							  ImmControl => Imm_Control,
							  Immed => Immed);
							  
	mux1: mux_2to1 port map( muxin_0 => muxin_2,
												 muxin_1 => muxin_3,
												 sel => RF_B_sel,
												 muxout => mux1_out);
												 
	mux2: mux_2to1 port map( muxin_0 => ALU_out,
									  muxin_1 => MEM_out,
									  sel => RF_WrData_sel,
									  muxout => mux2_out);
									  
	rfile: rf port map( CLK => CLK,
								 Ard1 => Instr(25 downto 21),
								 Ard2 => mux1_out(4 downto 0),
								 Awr => Instr(20 downto 16),
								 Dout1 => RF_A,
								 Dout2 => RF_B,
								 Din => mux2_out,
								 WrEn => WrEn,
								 Reset => Reset);

end Behavioral;

