library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FINAL is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end FINAL;

architecture Behavioral of FINAL is

component CONTROL is	
	Port(	Instr : in STD_LOGIC_VECTOR (31 downto 0);
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
end component;

component DATAPATH is
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
		   ALU_zero : out STD_LOGIC
		  );
end component;

	signal PC_sel_tmp : STD_LOGIC;
	signal PC_LdEn_tmp : STD_LOGIC;
	signal Instr_tmp : STD_LOGIC_VECTOR (31 downto 0);
	signal RF_WrEn_tmp : STD_LOGIC;
	signal RF_WrData_sel_tmp : STD_LOGIC;
	signal RF_B_sel_tmp : STD_LOGIC;
	signal ALU_Bin_sel_tmp : STD_LOGIC;
	signal ALU_func_tmp : STD_LOGIC_VECTOR (3 downto 0);
	signal ALU_zero_tmp : STD_LOGIC;
	signal ByteOp_tmp : STD_LOGIC;
	signal Mem_WrEn_tmp : STD_LOGIC;
	
begin

	ctrl_port: CONTROL 	
	port map( Instr => Instr_tmp,
				 ALU_zero => ALU_zero_tmp,
				 ALU_func => ALU_func_tmp,
				 ByteOp => ByteOp_tmp,
				 PC_sel => PC_sel_tmp,
				 PC_LdEn => PC_LdEn_tmp,
				 RF_WrEn => RF_WrEn_tmp,
				 RF_WrData_sel => RF_WrData_sel_tmp,
				 RF_B_sel => RF_B_sel_tmp,
				 ALU_Bin_sel => ALU_Bin_sel_tmp,
				 Mem_WrEn => Mem_WrEn_tmp
				);
	
	dpath_port: DATAPATH 
	port map( Clk => Clk,
				 Reset => Reset,
				 ByteOp => ByteOp_tmp,
				 PC_sel => PC_sel_tmp,
				 PC_LdEn => PC_LdEn_tmp,
				 RF_WrEn => RF_WrEn_tmp,
				 RF_WrData_sel => RF_WrData_sel_tmp,
				 RF_B_sel => RF_B_sel_tmp,
				 ALU_Bin_sel => ALU_Bin_sel_tmp,
				 ALU_func => ALU_func_tmp,
				 Mem_WrEn => Mem_WrEn_tmp,
				 Instr => Instr_tmp,
				 ALU_zero => ALU_zero_tmp
				);
				
end Behavioral;

