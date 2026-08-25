library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Control is
    Port ( Instr : in STD_LOGIC_VECTOR (31 downto 0);
		     ALU_zero : in STD_LOGIC;
		     ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
		     ByteOp : out STD_LOGIC;
           PC_sel : out STD_LOGIC;
		     PC_LdEn : out STD_LOGIC;
		     RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
		     ALU_Bin_sel : out  STD_LOGIC;
           Mem_WrEn : out STD_LOGIC
);
end Control;

architecture Behavioral of Control is

begin

  control_process : process (Instr, ALU_zero)
    begin    
       case Instr(31 DOWNTO 26) is
		 
        --R TYPE COMMANDS
		  
		  --ALU
        when "100000" =>
        ALU_func <= Instr(3 downto 0);   
		  PC_sel <= '0';
		  PC_LdEn <= '1';
		  RF_WrEn <= '1';
		  RF_WrData_sel <= '0';
		  RF_B_sel <= '0';
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';

---------------------------------------------
        --LI 
        when "111000" =>
        ALU_func <= "0000";
		  PC_sel <= '0';    
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';

        --LUI 
        when "111001" =>
        ALU_func <= "0000";
        PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';
  
        --ADDI
        when "110000" =>
        ALU_func <= "0000";
        PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';
  
        --ANDI
        when "110010" => 
        ALU_func <= "0010"; 
        PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';

        --ORI
        when "110011" =>
        ALU_func <= "0011";
        PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_WrData_sel <= '0';  
		  RF_B_sel <= '0';   
		  ALU_Bin_sel <= '1';
		  Mem_WrEn <= '0';


---------------------------------------------
        --J TYPE COMMANDS 
  
        --b 
        when "111111" =>
		  PC_sel <= '1';       
		  PC_LdEn <= '1';
        RF_WrEn <= '0';  
		  RF_B_sel <= '1'; 
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';

        --beq  
        when "010000" =>
        ALU_func <= "0001"; 
		  PC_sel <= ALU_zero;      
		  PC_LdEn <= '1';
		  RF_WrEn <= '0';
		  RF_B_sel <= '1';   
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
    
        --bne  
        when "010001" =>
        ALU_func <= "0001"; 
		  PC_sel <= NOT(ALU_zero);       
		  PC_LdEn <= '1';
		  RF_WrEn <= '0';
		  RF_B_sel <= '1';   
		  ALU_Bin_sel <= '0';
		  Mem_WrEn <= '0';
		  
        --lb  
        when "000011" =>
        ALU_func <= "0000";
		  PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_B_sel <= '0';   
        Mem_WrEn <= '0';
        RF_WrData_sel <= '1'; 
        ByteOp <= '1';
        ALU_Bin_sel <= '1';
    

        --sb
        when "000111" =>
        ALU_func <= "0000";
		  PC_sel <= '0';      
		  PC_LdEn <= '1';
        RF_WrEn <= '0';
		  RF_B_sel <= '1';   
        Mem_WrEn <= '1';
        RF_WrData_sel <= '1';  
        ByteOp <= '1';
        ALU_Bin_sel <= '1';

        --lw
        when "001111" =>
        ALU_func <= "0000";
		  PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '1';
		  RF_B_sel <= '0';   
        Mem_WrEn <= '0';
        RF_WrData_sel <= '1';  
        ByteOp <= '0';
        ALU_Bin_sel <= '1';

        --sw
        when "011111" =>
        ALU_func <= "0000";
		  PC_sel <= '0';       
		  PC_LdEn <= '1';
        RF_WrEn <= '0';
		  RF_B_sel <= '1';   
        Mem_WrEn <= '1';
        RF_WrData_sel <= '1'; 
        ByteOp <= '0';
        ALU_Bin_sel <= '1';

        when others => 
        RF_WrEn <= '0';
        Mem_WrEn <= '0';
        PC_LdEn <= '0';
		  
      end case;
    end process;

end Behavioral;
