----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:44:32 03/17/2023 
-- Design Name: 
-- Module Name:    reg_32bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is

        signal temp_out_33 : std_logic_vector(32 downto 0);
        signal temp_out : std_logic_vector(31 downto 0);

begin
        Alu_process: process(A, B, Op, temp_out_33, temp_out)
begin

        Ovf <= '0';
        Cout <= '0';

        case Op is
                when "0000" =>
                        temp_out_33 <= ('0' & A) + ('0' & B);
                        temp_out <= temp_out_33(31 downto 0);
                        if ((A(31) = B(31)) AND (temp_out_33(31) = not A(31))) then
                          Ovf <= '1' after 10 ns;
                          else
                          Ovf <= '0' after 10 ns;
                          end if;
                        Cout <= temp_out_33(32) after 10 ns;

                when "0001" =>
                        temp_out_33 <= ('0' & A) - ('0' & B);
                        temp_out <= temp_out_33(31 downto 0);
                        if ((A(31) = not B(31)) AND (temp_out_33(31) = B(31))) then
                          Ovf <= '1' after 10 ns;
                        else
                          Ovf <= '0' after 10 ns;
                          end if;
                        Cout <= temp_out_33(32) after 10 ns;

                when "0010" =>
                        temp_out <= A AND B;

                when "0011" =>
                        temp_out <= A OR B;

                when "0100" =>
                        temp_out <= NOT A;

                when "0101" =>
                        temp_out <= A NAND B;

                when "0110" =>
                        temp_out <= A NOR B;

                when "1000" =>
                        temp_out <= STD_LOGIC_VECTOR(shift_right(signed(A),1));

                when "1001" =>
                        temp_out <= STD_LOGIC_VECTOR(shift_right(unsigned(A),1));

                when "1010" =>
                        temp_out <= STD_LOGIC_VECTOR(shift_left(unsigned(A),1));

                when "1100" =>
                        temp_out <= STD_LOGIC_VECTOR(rotate_left(unsigned(A),1));

                when "1101" =>
                        temp_out <= STD_LOGIC_VECTOR(rotate_right(unsigned(A),1));

                when others =>
                        temp_out <= x"00000000";

        end case;

         if (temp_out = x"00000000") then
         Zero <= '1' after 10 ns;
         else
         Zero <= '0' after 10 ns;
         end if;

        Output <= temp_out after 10 ns;

end process;                   
end Behavioral;
