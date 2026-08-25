library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DATAPATH is
	Port(	Clk : in  STD_LOGIC;
			Reset : in  STD_LOGIC;
			ByteOp : in  STD_LOGIC;
		   PC_sel : in  STD_LOGIC;
         PC_LdEn : in  STD_LOGIC;
         RF_WrEn : in  STD_LOGIC;
         RF_WrData_sel : in  STD_LOGIC;
         RF_B_sel : in  STD_LOGIC;
		   ALU_Bin_sel : in  STD_LOGIC;
         ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
		   Mem_WrEn : in STD_LOGIC;
		   Instr : out STD_LOGIC_VECTOR (31 downto 0);
		   ALU_zero : out STD_LOGIC;
		   Instr_Reg_WrEn : in  STD_LOGIC;
			MEM_Reg_WrEn : in  STD_LOGIC;
			rfA_Reg_WrEn : in  STD_LOGIC;
			rfB_Reg_WrEn : in  STD_LOGIC;
			ALU_Reg_WrEn : in  STD_LOGIC
		  );
end DATAPATH;

architecture Behavioral of DATAPATH is

component IFSTAGE_FINAL 
	port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component DECSTAGE 
	port(  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0) ;
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
           Reset : in STD_LOGIC);
end component;

component ALUSTAGE 
	port(  RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
		   ALU_zero : out STD_LOGIC);
end component;

component MEMSTAGE_FINAL 
	port(  clk : in  STD_LOGIC;
			ByteOp : in  STD_LOGIC;
	        Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn  : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component reg_32bit
port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal instr_sig_in : STD_LOGIC_VECTOR (31 downto 0);
signal instr_sig_out : STD_LOGIC_VECTOR (31 downto 0);
signal immed_sig : STD_LOGIC_VECTOR (31 downto 0);
signal alu_out_sig: STD_LOGIC_VECTOR (31 downto 0);
signal rf_a_sig : STD_LOGIC_VECTOR (31 downto 0);
signal rf_b_sig : STD_LOGIC_VECTOR (31 downto 0);
signal mem_out_sig : STD_LOGIC_VECTOR (31 downto 0);
signal instr_reg_out_sig : STD_LOGIC_VECTOR (31 downto 0);
signal rfa_reg_out_sig : STD_LOGIC_VECTOR (31 downto 0);
signal rfb_reg_out_sig : STD_LOGIC_VECTOR (31 downto 0);
signal alu_reg_out_sig : STD_LOGIC_VECTOR (31 downto 0);
signal mem_reg_out_sig : STD_LOGIC_VECTOR (31 downto 0);

begin

if_port : IFSTAGE_FINAL port map( PC_Immed => immed_sig,
          						       PC_sel => PC_sel,
          						       PC_LdEn =>  PC_LdEn,
           						       Reset => Reset,
           						       Clk => Clk,
           						       Instr => instr_sig_in);
									   
instr_reg_port: reg_32bit port map ( CLK => Clk,
										Reset => Reset,
										Data => instr_sig_in,
										WE => Instr_Reg_WrEn,
									    Dout => instr_sig_out
										);									   
									   
dec_port : DECSTAGE port map (     Instr => instr_sig_out,
                                   WrEn  => RF_WrEn,
                                   ALU_out  => alu_out_sig,
                                   MEM_out  => mem_reg_out_sig,
                                   RF_WrData_sel  => RF_WrData_sel,
                                   RF_B_sel  => RF_B_sel,
                                   CLK  =>  Clk,
                                   Immed  => immed_sig ,
                                   RF_A  => rf_a_sig,
                                   RF_B  => rf_b_sig,
                                   Reset => Reset );

rfA_reg_port: reg_32bit port map ( CLK => Clk,
										Reset => Reset,
										Data => rf_a_sig,
										WE => rfA_Reg_WrEn,
									    Dout => rfa_reg_out_sig
										);									   
									   								   
rfB_reg_port: reg_32bit port map ( CLK => Clk,
										Reset => Reset,
										Data => rf_b_sig,
										WE => rfB_Reg_WrEn,
									    Dout => rfb_reg_out_sig
										);									   									   

alu_port : ALUSTAGE port map (    RF_A => rfa_reg_out_sig,
          						       RF_B => rfb_reg_out_sig,  
                                  Immed => immed_sig,
                                  ALU_Bin_sel => ALU_Bin_sel,
                                  ALU_func => ALU_func,
                                  ALU_out => alu_out_sig,
								          ALU_zero => ALU_zero);
										  
alu_reg_port: reg_32bit port map ( CLK => Clk,
										Reset => Reset,
										Data => alu_out_sig,
										WE => alu_Reg_WrEn,
									    Dout => ALU_reg_out_sig
										);										  

mem_port : MEMSTAGE_FINAL port map( clk =>  Clk,  
									         ByteOp => ByteOp,
                                    Mem_WrEn => Mem_WrEn,
                                    ALU_MEM_Addr => alu_reg_out_sig,
                                    MEM_DataIn => rf_b_sig,
                                    MEM_DataOut => mem_out_sig );
									
mem_reg_port: reg_32bit port map ( CLK => Clk,
										Reset => Reset,
										Data => mem_out_sig,
										WE => MEM_Reg_WrEn,
									    Dout => mem_reg_out_sig
										);										
											  
Instr <= instr_sig_in;											  

end Behavioral;
