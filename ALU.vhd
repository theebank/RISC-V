library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY ALU IS
PORT(
	i_A, i_B	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_S		: IN STD_LOGIC_VECTOR(2 downto 0);
	o_Zero		: OUT STD_LOGIC;
	o_Result	: buffer STD_LOGIC_VECTOR(7 downto 0));
END ALU;

ARCHITECTURE struct of ALU IS

BEGIN
	process(i_S)
	BEGIN

			if (i_S = "000") THEN 
				o_Result <= i_A AND i_B;
			elsif (i_S = "001") THEN
				o_Result <= i_A OR i_B;
			elsif (i_S = "010") THEN
				o_Result <= not i_A;
			elsif (i_S = "011") THEN
				o_Result <= not i_B;
			elsif (i_S = "100") THEN
				o_Result <= i_A NAND i_B;
			elsif (i_S = "101") THEN
				o_Result <= i_A NOR i_B;
			elsif (i_S = "110") THEN
				o_Result <= i_A xor i_B;
			elsif (i_S = "111") THEN
				o_Result <= X"00";
		end if;	
	end process;
	o_Zero <= '1' WHEN CONV_INTEGER(UNSIGNED(o_Result)) = 0 else 
		'0';
end struct;
