----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:00:56 04/11/2023 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity MEMSTAGE_FINAL is
    Port ( clk : in  STD_LOGIC;
			ByteOp : in  STD_LOGIC;
	        Mem_WrEn : in STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn  : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE_FINAL;

architecture Behavioral of MEMSTAGE_FINAL is

component MEMSTAGE 
	port(  ByteOp : in  STD_LOGIC;                              
           Mem_WrEn : in  STD_LOGIC;                           
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
		   MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);    
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0); 
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
		   MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MyMemRam
	port(   clk : in  STD_LOGIC;
	        we : in  STD_LOGIC; 
           a : in  STD_LOGIC_VECTOR(9 downto 0);
           d: in  STD_LOGIC_VECTOR(31 downto 0);
           spo : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

signal  WE : STD_LOGIC;
signal  addr : STD_LOGIC_VECTOR (31 downto 0);
signal  data_in_write : STD_LOGIC_VECTOR (31 downto 0);
signal  data_out_read : STD_LOGIC_VECTOR (31 downto 0);

begin

memstage_port : MEMSTAGE port map(ByteOp => ByteOp,
								  Mem_WrEn => Mem_WrEn,
								  ALU_MEM_Addr => ALU_MEM_Addr,
								  MEM_DataIn => MEM_DataIn, 
           						  MEM_DataOut => MEM_DataOut, 
                                  MM_WrEn => WE,
                                  MM_Addr => addr,
								  MM_WrData => data_in_write,
                                  MM_RdData => data_out_read);
								  
ram_port : MyMemRam port map (  clk => clk,
                                we => WE,
          				           a => addr(11 downto 2),
          					        d => data_in_write,                           
           					        spo => data_out_read);


end Behavioral;
