--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:43:35 06/06/2023
-- Design Name:   
-- Module Name:   /home/ise/project/STALL_testbench.vhd
-- Project Name:  project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: STALL
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
 
ENTITY STALL_testbench IS
END STALL_testbench;
 
ARCHITECTURE behavior OF STALL_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT STALL
    PORT(
         ID_EX_MemRead : IN  std_logic;
         ID_EX_RegisterRT : IN  std_logic_vector(4 downto 0);
         IF_ID_RegisterRT : IN  std_logic_vector(4 downto 0);
         IF_ID_RegisterRS : IN  std_logic_vector(4 downto 0);
         Stalling : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ID_EX_MemRead : std_logic := '0';
   signal ID_EX_RegisterRT : std_logic_vector(4 downto 0) := (others => '0');
   signal IF_ID_RegisterRT : std_logic_vector(4 downto 0) := (others => '0');
   signal IF_ID_RegisterRS : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Stalling : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: STALL PORT MAP (
          ID_EX_MemRead => ID_EX_MemRead,
          ID_EX_RegisterRT => ID_EX_RegisterRT,
          IF_ID_RegisterRT => IF_ID_RegisterRT,
          IF_ID_RegisterRS => IF_ID_RegisterRS,
          Stalling => Stalling
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     wait for 100 ns;

     ID_EX_MemRead <= '1';	
     IF_ID_RegisterRS <= "00000";	
     ID_EX_RegisterRT <= "00000";
     IF_ID_RegisterRT <= "00001";
	  wait for 100 ns;	  
	  
     ID_EX_RegisterRT <= "00001";
	  wait for 100 ns;  
	
     IF_ID_RegisterRS <= "00001";	
     ID_EX_RegisterRT <= "00010";
     IF_ID_RegisterRT <= "00011";
	  wait for 100 ns;
	  
     ID_EX_MemRead <= '0';    
	  wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
