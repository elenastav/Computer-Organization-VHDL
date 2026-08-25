library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MEMSTAGE is 
    Port ( ByteOp : in  STD_LOGIC;  --shma elegxou gia epilogh lw/sw(0) OR lb/sb(1)  
           Mem_WrEn : in  STD_LOGIC;  --flag energopoihshs eggrafhs sth mnhmh
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
		   MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);  --apotelesma RF[rd] gia apofhkeush sth mnhmh gia entoles swap sb, sw
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);  --dedomena gia fortwsh apo mnhmh pros register lb lw(pros RF)
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
		   MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0)
		   );
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is 

begin

MEM_DataOut <= MM_RdData when ByteOp = '0' else
               ("000000000000000000000000" & MM_RdData(7 downto 0)) when ByteOp ='1';

MM_Addr <= ALU_MEM_Addr;

MM_WrEn <= Mem_WrEn;

MM_WrData <= MEM_DataIn when ByteOp = '0' else
             ("000000000000000000000000" & MEM_DataIn(7 downto 0)) when ByteOp ='1' ;


end Behavioral;


