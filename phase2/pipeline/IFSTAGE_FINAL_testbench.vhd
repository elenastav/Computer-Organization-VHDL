--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:28:39 03/28/2023
-- Design Name:   
-- Module Name:   /home/ise/a_project/IFSTAGE_FINAL_test_bench.vhd
-- Project Name:  a_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE_FINAL
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
 
ENTITY IFSTAGE_FINAL_testbench IS
END IFSTAGE_FINAL_testbench;
 
ARCHITECTURE behavior OF IFSTAGE_FINAL_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE_FINAL
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE_FINAL PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          Instr => Instr
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
       --Reset=1, so the memory address is 0
	   PC_Immed <= "00000000000000000000000000000001";
      PC_sel <= '0'; 
      PC_LdEn <= '1';
      Reset <= '1';		
      wait for 100 ns;	
		
	  --Reset=0, select=0, WE=1, so we go through memory line by line
      PC_Immed <= "00000000000000000000000000000001";
      PC_sel <= '0'; 
      PC_LdEn <= '1';
      Reset <= '0';		
      wait for 100 ns;	
 		
	  --Select=1, Immediate=1, so we move by 2 lines in memory	
      PC_Immed <= "00000000000000000000000000000001";
      PC_sel <= '1'; 
      PC_LdEn <= '1';		
      wait for 100 ns;
		
	  --WE=0, so we don't move at all	
	  PC_Immed <= "00000000000000000000000000000001";
      PC_sel <= '1'; 
      PC_LdEn <= '0';
      wait for 100 ns;
		
	  --Select=1, WE=1, Immediate=3, so we move by 4 lines in memory	
	  PC_Immed <= "00000000000000000000000000000011";
      PC_sel <= '1'; 
      PC_LdEn <= '1';
      wait for 100 ns;
		
	  --Select=0, so we move line by line	
	  PC_Immed <= "00000000000000000000000000000011";
      PC_sel <= '0'; 
      PC_LdEn <= '1'; 
      wait for 100 ns;
		
	  --WE=0, so we don't move at all(We've reached addresses that have 0)	
	  PC_Immed <= "00000000000000000000000000000011";
      PC_sel <= '0'; 
      PC_LdEn <= '0';
	  wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;




END;
