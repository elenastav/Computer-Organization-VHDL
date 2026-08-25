--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:39:50 04/11/2023
-- Design Name:   
-- Module Name:   /home/ise/project_alustage/ALUSTAGE_testbench.vhd
-- Project Name:  project_alustage
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALUSTAGE
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
 
ENTITY ALUSTAGE_testbench IS
END ALUSTAGE_testbench;
 
ARCHITECTURE behavior OF ALUSTAGE_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALUSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
			ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
	signal ALU_zero : std_logic := '0';
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALUSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
			 ALU_zero => ALU_zero
        );
 

   -- Stimulus process
   stim_proc: process
 begin
-- hold reset state for 100 ns.

ALU_Bin_sel <= '0';
RF_A <= "11111111111111111111111111111111";
RF_B <= "11111111111111111111111111111111";
Immed <= "11111111111111111111111111111111";
ALU_func <= "1111";
wait for 100 ns;

-- Add
RF_A <= "00000000000000000000000000001011";
RF_B <= "00000000000000000000000000001101";
Immed <= "11111111111111111111111111111111";
ALU_func <= "0000";
wait for 100 ns;

-- Subtract
ALU_Bin_sel <= '1';
RF_A <= "00000000000000000000000000001111";
RF_B <= "11111111111111111111111111111111";
Immed <= "00000000000000000000000000001101";
ALU_func <= "0001";
wait for 100 ns;

-- AND
RF_A <= "11000000000000000000000000000000";
Immed <= "10100000000000000000000000000000";
ALU_func <= "0010";
wait for 100 ns;

-- OR
RF_A <= "11000000000000000000000000000000";
Immed <= "10100000000000000000000000000000";
ALU_func <= "0011";
wait for 100 ns;

-- NOT
RF_A <= "10000000000000000000000000000000";
ALU_func <= "0100";
wait for 100 ns;

-- NAND
ALU_Bin_sel <= '0';
RF_A <= "11000000000000000000000000000000";
RF_B <= "10100000000000000000000000000000";
Immed <= "11111111111111111111111111111111";
ALU_func <= "0101";
wait for 100 ns;

-- NOR
RF_A <= "11000000000000000000000000000000";
RF_B <= "10100000000000000000000000000000";
ALU_func <= "0110";
wait for 100 ns;

-- Shift Right Arithmetic
RF_A <= "11111111111111111111111111111110";
ALU_func <= "1000";
wait for 100 ns;

-- Shift Right Logical
RF_A <= "11111111111111111111111111111110";
ALU_func <= "1001";
wait for 100 ns;

-- Shift Left Logical
RF_A <= "01111111111111111111111111111111";
ALU_func <= "1010";
wait for 100 ns;

-- Rotate Left
RF_A <= "01111111111111111111111111111111";
ALU_func <= "1100";
wait for 100 ns;

-- Rotate Right
RF_A <= "11111111111111111111111111111110";
ALU_func <= "1101";
wait for 100 ns;

      wait;
   end process;

END;
