--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:14:55 04/09/2023
-- Design Name:   
-- Module Name:   /home/ise/A_phase_project/DECSTAGE_Testbench.vhd
-- Project Name:  A_phase_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DECSTAGE_testbench IS
END DECSTAGE_testbench;
 
ARCHITECTURE behavior OF DECSTAGE_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         CLK : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0);
         Reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          WrEn => WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          CLK => CLK,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B,
          Reset => Reset
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process	
	begin		
     
   	 Reset <= '1';
   	 wait for Clk_period;		 

   	 Reset <= '0';
		 WrEn <= '1';		 
		 ALU_out <= "00000000000000001111111111111111";
   	 MEM_out <= "11111111111111110000000000000000";
		 
   	 -- zero fill
   	 -- write MEM_out to 00001 | read from 00001 and 00010
   	 RF_WrData_sel <= '0';
   	 RF_B_sel <= '0';
   	 Instr <= "110011"&"00001"&"00001"&"00010"&"11111111111";
       wait for Clk_period;
    
	 
	    -- signextend
   	 -- write ALU_out to 00010 | read from 00001 and 00010
   	 RF_WrData_sel <= '1';
   	 RF_B_sel <= '0';
   	 Instr <= "111000"&"00001"&"00010"&"00010"&"11111111111";
  	    wait for Clk_period;
		 
    
   	 -- shift and zero fill
   	 -- write MEM_out to 00011 | read from 00001 and 00010
   	 RF_WrData_sel <= '0';
   	 RF_B_sel <= '0';
   	 Instr <= "111001"&"00001"&"00011"&"00010"&"11111111111";
  	    wait for Clk_period;
      
   	 
   	 -- signextend and shift
   	 -- write ALU_out to 00100 | read from 00011 and 00100
   	 RF_WrData_sel <= '1';
   	 RF_B_sel <= '1';
   	 Instr <= "111111"&"00011"&"00100"&"10000"&"11111111111";
    	 wait for Clk_period;

      wait;
   end process;

END;
