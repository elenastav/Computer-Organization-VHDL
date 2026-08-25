library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
		   ALU_zero : out STD_LOGIC
		   );
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is

signal muxoutput : STD_LOGIC_VECTOR (31 downto 0);

component alu
	port(    A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
		   Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;

component mux_2to1
	port(     muxin_0 : in  STD_LOGIC_VECTOR(31 downto 0);
    	      muxin_1 : in  STD_LOGIC_VECTOR(31 downto 0);
              sel : in  STD_LOGIC;
              muxout : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

begin

MUX_port : mux_2to1 port map( muxin_0 => RF_B,
							muxin_1  => Immed ,
							sel => ALU_Bin_sel,
							muxout => muxoutput);

ALU_port : Alu port map( A => RF_A,
						 B => muxoutput,
						 Op => ALU_func,
						 Output => ALU_out,
						 Zero => ALU_zero);

end Behavioral;
