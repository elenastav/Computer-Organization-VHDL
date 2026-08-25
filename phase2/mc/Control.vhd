library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Control is
    Port ( Instr : in STD_LOGIC_VECTOR (31 downto 0);
		     ALU_zero : in STD_LOGIC;
			 Clk : in STD_LOGIC;
			 Reset: in STD_LOGIC;
		     ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
		     ByteOp : out STD_LOGIC;
           PC_sel : out STD_LOGIC;
		     PC_LdEn : out STD_LOGIC;
		     RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
		     ALU_Bin_sel : out  STD_LOGIC;
           Mem_WrEn : out STD_LOGIC;
		   Instr_Reg_WrEn : out  STD_LOGIC;
			MEM_Reg_WrEn : out  STD_LOGIC;
			rfA_Reg_WrEn : out  STD_LOGIC;
			rfB_Reg_WrEn : out  STD_LOGIC;
			ALU_Reg_WrEn : out  STD_LOGIC
);
end Control;

architecture Behavioral of Control is

type state is (Reset_state, IF_state, DEC_state, RtypeEx_state, RtypeWB_state, ItypeEx_state, ItypeWB_state, StoreEx_state, 
               StoreMem_state, LoadEx_state, LoadMem_state, LoadWB_state, BranchEx_state);

SIGNAL cur_state, next_state: state;					

begin

  control_process : process (Instr, ALU_zero, cur_state)
    begin    
		case cur_state is 
			when Reset_state => ALU_func <= "1111";   
								PC_sel <= '0';
								PC_LdEn <= '0';
								RF_WrEn <= '0';
								RF_WrData_sel <= '0';
								RF_B_sel <= '0';
								ALU_Bin_sel <= '0';
								Mem_WrEn <= '0';
								PC_LdEn <= '0';
								ByteOp <= '0';
								Instr_Reg_WrEn <= '0';
								MEM_Reg_WrEn <= '0';
								rfA_Reg_WrEn <= '0';
								rfB_Reg_WrEn <= '0';
								ALU_Reg_WrEn <= '0';
								next_state <= IF_state;
	
			when IF_state => PC_sel <= '0';
							 PC_LdEn <= '0';
							 Instr_Reg_WrEn <= '1';
							 next_state <= DEC_state;
	
			when DEC_state => Mem_WrEn <= '0';
							  RF_B_sel <= '0';
							  RF_WrEn <= '0';
								
							  -- Rtype	
							  if(INSTR(31 DOWNTO 26) = "100000") then	
									    MEM_Reg_WrEn <= '0';
										rfA_Reg_WrEn <= '1';
										rfB_Reg_WrEn <= '1';
										ALU_Reg_WrEn <= '1';
										next_state <= RtypeEx_state;
										
							   -- Itype
								elsif (INSTR(31 downto 30) = "11" and INSTR(28) = '0') then 
										MEM_Reg_WrEn <= '0';
										rfA_Reg_WrEn <= '1';
										rfB_Reg_WrEn <= '0';
										ALU_Reg_WrEn <= '1';
										next_state <= ItypeEx_state;
												
								-- Branch
								elsif (Instr(31 downto 26) = "111111" or Instr(31 downto 26) = "010000"
										or Instr(31 downto 26) = "010001") then
										MEM_Reg_WrEn <= '0';
										rfA_Reg_WrEn <= '1';
										rfB_Reg_WrEn <= '1';
										ALU_Reg_WrEn <= '1';    
										RF_B_sel <= '1';
										next_state <= BranchEx_state;	
	
								-- Load
								elsif (Instr(31 downto 26) = "000011" or INSTR(31 DOWNTO 26) = "001111") then 
										MEM_Reg_WrEn <= '1';
										rfA_Reg_WrEn <= '1';
										rfB_Reg_WrEn <= '0';
										ALU_Reg_WrEn <= '1'; 
										RF_B_sel <= '0';
										next_state <= LoadEx_state;
										
								-- Store
								elsif (Instr(31 downto 26) = "000111" or INSTR(31 DOWNTO 26) = "011111") then 
										MEM_Reg_WrEn <= '1';
										rfA_Reg_WrEn <= '1';
										rfB_Reg_WrEn <= '1';
										ALU_Reg_WrEn <= '1'; 
										RF_B_sel <= '1';
										next_state <= StoreEx_state;
								end if;
			
			when RtypeEx_state => ALU_Bin_sel <= '0';
								  ALU_func <= INSTR(3 DOWNTO 0);
								  next_state <= RtypeWB_state;
			
			when RtypeWB_state => RF_WrData_sel <= '0';
		                          RF_WrEn <= '1';
								  PC_LdEn <= '1';
								  next_state <= IF_state;
	
			when ItypeEx_state => ALU_Bin_sel <= '1';
								  if (Instr(27 downto 26) = "00" OR Instr(27 downto 26) = "01") then -- li, addi and lui
										ALU_func <= "0000"; -- add
								  elsif Instr(27 downto 26) = "10" then  -- andi
										ALU_func <= "0010"; -- and
								  elsif Instr(27 downto 26) = "11" then  -- ori
										ALU_func <= "0011"; -- or
								  end if;
								  next_state <= ItypeWB_state;
	
			when ItypeWB_state => RF_WrData_sel <= '0';
		                          RF_WrEn <= '1';
								  PC_LdEn <= '1';
								  next_state <= IF_state;
	
			when StoreEx_state => ALU_Bin_sel <= '1';
								  ALU_func <= "0000";
								  next_state <= StoreMem_state;
	
			when StoreMem_state => Mem_WrEn <= '1';
								   PC_LdEn <= '1';
								   if( INSTR(31 DOWNTO 26) = "000111") then 
										ByteOp <= '1'; -- sb
								   else
										ByteOp <= '0'; -- sw
								   end if;	
								   next_state <= IF_state;
	
			when LoadEx_state => ALU_Bin_sel <= '1';
								  ALU_func <= "0000";
								  next_state <= LoadMem_state;
								  
			when LoadMem_state =>  Mem_WrEn <= '0';
								   if( INSTR(31 DOWNTO 26) = "000011") then 
										ByteOp <= '1'; -- lb
								   else
										ByteOp <= '0'; -- lw
								   end if;	
								   next_state <= LoadWB_state;					  
			
			when LoadWB_state => RF_WrData_sel <= '1';
                                 RF_WrEn <= '1';
								 PC_LdEn <= '1';
								 next_state <= IF_state; 
	
			when BranchEx_state  => ALU_func <= "0001";
								    ALU_Bin_sel <= '0';
								    PC_LdEn <= '1';		  
									if(INSTR(31 DOWNTO 26) = "111111" ) then -- b
										PC_sel <= '1';	
									elsif(INSTR(31 DOWNTO 26) = "010000") then --be
										if(ALU_ZERO = '1') then  
											PC_sel <='1';
										else
											PC_sel <= '0';
										end if;
									elsif(	INSTR(31 DOWNTO 26) = "010001") then -- bne
											if(ALU_ZERO = '1') then  
												PC_sel <='0';
											else
												PC_sel <= '1';
											end if;
									end if;									
									next_state <= IF_state;
	
			end case;
			end process;
			
			
			process(Clk, Reset) begin
			
				if Reset = '1' then 
					cur_state <= Reset_state;
				elsif rising_edge(Clk) then
					cur_state <= next_state;
				end if;
			
			end process;
			


end Behavioral;
	

