--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:12:48 04/22/2023
-- Design Name:   
-- Module Name:   /home/ise/Project/DATAPATH_tb.vhd
-- Project Name:  Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATH_testbench IS
END DATAPATH_testbench;
 
ARCHITECTURE behavior OF DATAPATH_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         ByteOp : IN  std_logic;
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         Mem_WrEn : IN  STD_LOGIC;
         Instr : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal Mem_WrEn : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          Clk => Clk,
          Reset => Reset,
          ByteOp => ByteOp,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
          Instr => Instr,
          ALU_zero => ALU_zero
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
      -- hold reset state for 100 ns.

		  Reset <= '1';
		  wait for clk_period*1;
	 
		  Reset <= '0';

        --li r1,6
        ALU_func <= "0000";
		  PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';    
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
		
		
        --li r2,6
        ALU_func <= "0000";
		  PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
		  
		  
        --add r1,r3,r2
        ALU_func <= "0000";    
		  PC_sel <= '0';
		  PC_LdEn <= '1';
		  RF_WrEn <= '1';
		  RF_WrData_sel <= '0';
		  RF_B_sel <= '0';
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
			
			
        --bne r1,r2, 0  
        ALU_func <= "0001"; 
		  PC_sel <= '0';       
		  PC_LdEn <= '1';
		  RF_WrEn <= '0';
		  RF_B_sel <= '1';   
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
	     wait for clk_period*1;
	
	
        --beq r1,r2, 0
        ALU_func <= "0001"; 
		  PC_sel <= '1';       
		  PC_LdEn <= '1';
		  RF_WrEn <= '0';
		  RF_B_sel <= '1';   
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
			
			
        --lui r8,4
        ALU_func <= "0000";
        PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';
        wait for clk_period*1;

		  
        --lui r10,16
        ALU_func <= "0000";
        PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
					
					
        --or r8,r5,r10
        ALU_func <= "0011";    
		  PC_sel <= '0';
		  PC_LdEn <= '1';
		  RF_WrEn <= '1';
		  RF_WrData_sel <= '0';
		  RF_B_sel <= '0';
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
			
			
        --rol r5,r6,1
        ALU_func <= "1100";    
		  PC_sel <= '0';
		  PC_LdEn <= '1';
		  RF_WrEn <= '1';
		  RF_WrData_sel <= '0';
		  RF_B_sel <= '0';
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
			  
			  
        --ror r6,r5,1
        ALU_func <= "1101";   
		  PC_sel <= '0';
		  PC_LdEn <= '1';
		  RF_WrEn <= '1';
		  RF_WrData_sel <= '0';
		  RF_B_sel <= '0';
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
		  wait for clk_period*1;
			
			
        --sw r5,4(r10)
        ALU_func <= "0000";
		  PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '0';
		  RF_B_sel <= '1';   
        Mem_WrEn <= '1';
        RF_WrData_sel <= '1';  
        ByteOp <= '0';
        ALU_Bin_sel <= '1';
		  wait for clk_period*1;
  

      wait;
   end process;

END;
