--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:33:12 04/23/2023
-- Design Name:   
-- Module Name:   /home/ise/Project/MEMSTAGE_FINAL_testbench.vhd
-- Project Name:  Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE_FINAL
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
 
ENTITY MEMSTAGE_FINAL_testbench IS
END MEMSTAGE_FINAL_testbench;
 
ARCHITECTURE behavior OF MEMSTAGE_FINAL_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE_FINAL
    PORT(
         clk : IN  std_logic;
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic_vector(0 downto 0);
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic_vector(0 downto 0) := (others => '0');
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE_FINAL PORT MAP (
          clk => clk,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
    begin		
      -- hold reset state for 100 ns.
         ByteOp <= '0';
         Mem_WrEn <= "1";
         ALU_MEM_Addr <= "00000000000000000000000000000000";
         MEM_DataIn <=   "01111111111111111111111111111111";
       
         wait for 100 ns;

         ALU_MEM_Addr <= "00000000000000000000000000000100";
         MEM_DataIn <=   "11111111111111111111111000000001";

         wait for 100 ns;
			
         ByteOp <= '1';
         ALU_MEM_Addr <= "00000000000000000000000000001000";
         MEM_DataIn <=   "11111111111111111111111100000001";
        
         wait for 100 ns;	
		
         ALU_MEM_Addr <= "00000000000000000000000000001100";
         MEM_DataIn <=   "11111111111111111111111100000011";
			
			wait for 100 ns;
			
         Mem_WrEn <= "0";			
			ALU_MEM_Addr <= "00000000000000000000000000010000";
         MEM_DataIn <=   "00000001111111000000001111000000";
			
			wait for 100 ns;

      wait;
   end process;

END;
