--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:26:37 06/06/2023
-- Design Name:   
-- Module Name:   /home/ise/project/FORWARD_testbench.vhd
-- Project Name:  project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FORWARD
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
 
ENTITY FORWARD_testbench IS
END FORWARD_testbench;
 
ARCHITECTURE behavior OF FORWARD_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FORWARD
    PORT(
         EX_MEM_RegWrite : IN  std_logic;
         MEM_WB_RegWrite : IN  std_logic;
         EX_MEM_RegisterRD : IN  std_logic_vector(4 downto 0);
         MEM_WB_RegisterRD : IN  std_logic_vector(4 downto 0);
         ID_EX_RegisterRS : IN  std_logic_vector(4 downto 0);
         ID_EX_RegisterRT : IN  std_logic_vector(4 downto 0);
         ForwardA : OUT  std_logic_vector(1 downto 0);
         ForwardB : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal EX_MEM_RegWrite : std_logic := '0';
   signal MEM_WB_RegWrite : std_logic := '0';
   signal EX_MEM_RegisterRD : std_logic_vector(4 downto 0) := (others => '0');
   signal MEM_WB_RegisterRD : std_logic_vector(4 downto 0) := (others => '0');
   signal ID_EX_RegisterRS : std_logic_vector(4 downto 0) := (others => '0');
   signal ID_EX_RegisterRT : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal ForwardA : std_logic_vector(1 downto 0);
   signal ForwardB : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FORWARD PORT MAP (
          EX_MEM_RegWrite => EX_MEM_RegWrite,
          MEM_WB_RegWrite => MEM_WB_RegWrite,
          EX_MEM_RegisterRD => EX_MEM_RegisterRD,
          MEM_WB_RegisterRD => MEM_WB_RegisterRD,
          ID_EX_RegisterRS => ID_EX_RegisterRS,
          ID_EX_RegisterRT => ID_EX_RegisterRT,
          ForwardA => ForwardA,
          ForwardB => ForwardB
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		EX_MEM_RegisterRD <= "00000";
		MEM_WB_RegisterRD <=  "00000";
		wait for 100 ns;
		
		EX_MEM_RegWrite <=  '1';
		EX_MEM_RegisterRD <=  "00001";
		ID_EX_RegisterRS <=  "00001";		
		ID_EX_RegisterRT <=  "00001"; 
      wait for 100 ns;		
		
		EX_MEM_RegWrite <=  '0';
		MEM_WB_RegWrite <=  '1';
		MEM_WB_RegisterRD <=  "00001";
		wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
