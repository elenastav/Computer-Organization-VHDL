--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   14:21:43 19/03/2023
-- Design Name:   
-- Module Name:   /home/ise/Desktop/alu/rf_testbench.vhd
-- Project Name:  rf
-- Target Device:  
-- Tool versions:  
-- Description:   
--
-- VHDL Test Bench Created by ISE for module: rf
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
 
ENTITY rf_testbench IS
END rf_testbench;
 
ARCHITECTURE behavior OF rf_testbench IS
 
	-- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT RF
	PORT(
     	CLK : IN  std_logic;
     	Ard1 : IN  std_logic_vector(4 downto 0);
     	Ard2 : IN  std_logic_vector(4 downto 0);
     	Awr : IN  std_logic_vector(4 downto 0);
     	Dout1 : OUT  std_logic_vector(31 downto 0);
     	Dout2 : OUT  std_logic_vector(31 downto 0);
     	Din : IN  std_logic_vector(31 downto 0);
     	WrEn : IN  std_logic;
     	Reset : IN  std_logic
    	);
	END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Reset : std_logic := '0';

	 --Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
      	CLK => CLK,
      	Ard1 => Ard1,
      	Ard2 => Ard2,
      	Awr => Awr,
      	Dout1 => Dout1,
      	Dout2 => Dout2,
      	Din => Din,
      	WrEn => WrEn,
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
  	-- hold reset state for 100 ns.
  	Reset <= '1';
   	 wait for 100 ns;
    
   	 Reset <= '0';
   	 WrEn <= '1';
   	 
   	 -- write to register 1 and read from 1 and 2
   	 Din <= "00000000000000000000000000000001";
   	 Ard1 <= "00001";
   	 Ard2 <= "00010";
   	 Awr<= "00001";
  	wait for 100 ns;    
   	 
   	 -- write to register 2 and read from 1 and 2
   	 Din <= "00000000000000000000000000000011";
   	 Ard1 <= "00001";
   	 Ard2 <= "00010";
   	 Awr<= "00010";
  	wait for 100 ns;
      
      -- try to write to register 0 and read from 1 and 2
   	 Din <= "11111111111111111111111111111111";
   	 Ard1 <= "00001";
   	 Ard2 <= "00010";
   	 Awr<= "00000";
  	wait for 100 ns;
   	 
   	 -- close WE and try to write to register 15 and read from 0 and 1
   	 WrEn <='0';
   	 Din <= "00000000000000000111111111111111";
   	 Ard1 <= "00000";
   	 Ard2 <= "00001";
   	 Awr<= "01111";
  	wait for 100 ns;
      
      -- open WE and write to register 15 and read from 1 and 15
   	 WrEn <='1';
   	 Din <= "00000000000000000111111111111111";
   	 Ard1 <= "00001";
   	 Ard2 <= "01111";
   	 Awr<= "01111";
  	wait for 100 ns;
      
      -- write to register 8 and read from 1 and 15
   	 Din <= "00000000000000000000000011111111";
   	 Ard1 <= "00001";
   	 Ard2 <= "01111";
   	 Awr<= "01000";
  	wait for 100 ns;

  	-- insert stimulus here

  	wait;
   end process;




END;




