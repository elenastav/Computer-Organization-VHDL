--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:11:57 03/17/2023
-- Design Name:   
-- Module Name:   /home/ise/Desktop/alu/alu_testbench.vhd
-- Project Name:  alu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
 
ENTITY alu_testbench IS
END alu_testbench;
 
ARCHITECTURE behavior OF alu_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );
 

   -- Stimulus process
   stim_proc: process
   begin
-- hold reset state for 100 ns.

A <= "11111111111111111111111111111111";
B <= "11111111111111111111111111111111";
Op <= "1111";
wait for 100 ns;

-- Add
A <= "00000000000000000000000000001011";
B <= "00000000000000000000000000001101";
Op <= "0000";
wait for 100 ns;

-- Add with carry out
A <= "11000000000000000000000000000000";
B <= "11000000000000000000000000000000";
Op <= "0000";
wait for 100 ns;

-- Add with overflow
A <= "01000000000000000000000000000000";
B <= "01000000000000000000000000000000";
Op <= "0000";
wait for 100 ns;

-- Add with overflow and carry out
A <= "10000000000000000000000000000000";
B <= "10000000000000000000000000000000";
Op <= "0000";
wait for 100 ns;

-- Add with zero output
A <= "00000000000000000000000000000000";
B <= "00000000000000000000000000000000";
Op <= "0000";
wait for 100 ns;

-- Subtract
A <= "00000000000000000000000000001111";
B <= "00000000000000000000000000001101";
Op <= "0001";
wait for 100 ns;

-- Subtract with carry out
A <= "00000000000000000000000000000000";
B <= "11111111111111111111111111111111";
Op <= "0001";
wait for 100 ns;

-- Subtract with overflow
A <= "10000000000000000000000000000000";
B <= "01000000000000000000000000000000";
Op <= "0001";
wait for 100 ns;

-- Subtract with overflow and carry out
A <= "00000000000000000000000000000000";
B <= "10000000000000000000000000000000";
Op <= "0001";
wait for 100 ns;

-- AND
A <= "11000000000000000000000000000000";
B <= "10100000000000000000000000000000";
Op <= "0010";
wait for 100 ns;

-- OR
A <= "11000000000000000000000000000000";
B <= "10100000000000000000000000000000";
Op <= "0011";
wait for 100 ns;

-- NOT
A <= "10000000000000000000000000000000";
Op <= "0100";
wait for 100 ns;

-- NAND
A <= "11000000000000000000000000000000";
B <= "10100000000000000000000000000000";
Op <= "0101";
wait for 100 ns;

-- NOR
A <= "11000000000000000000000000000000";
B <= "10100000000000000000000000000000";
Op <= "0110";
wait for 100 ns;

-- Shift Right Arithmetic
A <= "11111111111111111111111111111110";
Op <= "1000";
wait for 100 ns;

-- Shift Right Logical
A <= "11111111111111111111111111111110";
Op <= "1001";
wait for 100 ns;

-- Shift Left Logical
A <= "01111111111111111111111111111111";
Op <= "1010";
wait for 100 ns;

-- Rotate Left
A <= "01111111111111111111111111111111";
Op <= "1100";
wait for 100 ns;

-- Rotate Right
A <= "11111111111111111111111111111110";
Op <= "1101";
wait for 100 ns;

      wait;
   end process;

END;
