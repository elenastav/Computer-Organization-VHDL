--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:03:11 04/20/2023
-- Design Name:   
-- Module Name:   /home/ise/project_alustage/Control_test_bench.vhd
-- Project Name:  project_alustage
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
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
 
ENTITY Control_testbench IS
END Control_testbench;
 
ARCHITECTURE behavior OF Control_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         ByteOp : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         ALU_zero : IN  std_logic;
         PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         Mem_WrEn : OUT  std_logic_vector(0 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_zero : std_logic := '0';

 	--Outputs
   signal ByteOp : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal Mem_WrEn : std_logic_vector(0 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          Instr => Instr,
          ByteOp => ByteOp,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          Mem_WrEn => Mem_WrEn
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
   
		Instr <= "100000"&"00000"&"00101"&"00000"&"00000"&"110000"; --ADD
      wait for 100 ns;

		Instr <= "100000"&"00001"&"00101"&"00000"&"00000"&"110001"; --SUB
      wait for 100 ns;

		Instr <= "100000"&"00000"&"00100"&"00000"&"00000"&"110010"; --AND
      wait for 100 ns;
	
		Instr <= "100000"&"00010"&"00100"&"00000"&"00000"&"110100"; --NOT
      wait for 100 ns;
		
		Instr <= "100000"&"00010"&"00100"&"00000"&"00000"&"110011"; --OR
      wait for 100 ns;
	
		Instr <= "100000"&"00010"&"00100"&"00000"&"00000"&"111000"; --SRL
      wait for 100 ns;

		Instr <= "100000"&"00010"&"00100"&"00000"&"00000"&"111001"; --SLL
      wait for 100 ns;

		Instr <= "100000"&"00010"&"00100"&"00000"&"00000"&"111010"; --SLA
      wait for 100 ns;

		Instr <= "100000"&"00010"&"00100"&"00000"&"00000"&"111100"; --ROL
      wait for 100 ns;
	
		Instr <= "100000"&"00010"&"00100"&"00000"&"00000"&"111101"; --ROR
      wait for 100 ns;
		
		Instr <= "111000"&"00000"&"00100"&"0000000000111100"; --LI
      wait for 100 ns;
	
		Instr <= "111001"&"00000"&"00100"&"0000000000111100"; --LUI
      wait for 100 ns;
	
		Instr <= "110000"&"00000"&"00100"&"0000000000111100"; --ADDI
      wait for 100 ns;

		Instr <= "110010"&"00000"&"00100"&"0000000000111100"; --ANDI
      wait for 100 ns;

		Instr <= "110011"&"00000"&"00100"&"0000000000111100"; --ORI
      wait for 100 ns;
	 
		ALU_ZERO <= '0';
		Instr <= "111111"&"00000"&"00100"&"0000000000000100"; --B
      wait for 100 ns;
	
		ALU_ZERO <= '1';
		Instr <= "010000"&"00100"&"00100"&"0000000000000100"; --BEQ TRUE
      wait for 100 ns;
	
		ALU_ZERO <= '0';
		Instr <= "010000"&"00001"&"00100"&"0000000000000100"; --BEQ FALSE
      wait for 100 ns;
	 
		ALU_ZERO <= '0';
		Instr <= "010001"&"00101"&"00100"&"0000000000000100"; --BNE
      wait for 100 ns;

		Instr <= "000011"&"00101"&"00100"&"0000000000000100"; --LB
      wait for 100 ns;
	
		Instr <= "000111"&"00101"&"00100"&"0000000000000100"; --SB
      wait for 100 ns;

		Instr <= "001111"&"00101"&"00100"&"0110000000000100"; --LW
      wait for 100 ns;
	
		Instr <= "011111"&"00101"&"00100"&"0110000000000100"; --SW
      wait for 100 ns;




     -- wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
