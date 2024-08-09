library ieee;
use ieee.std_logic_1164.all;

ENTITY fulladder IS
PORT(
	i_A,i_B,i_C	: IN STD_LOGIC;
	o_S,o_C		: OUT STD_LOGIC);
END fulladder;
architecture struct of fulladder IS
BEGIN
o_S <= (i_A xor i_B) xor i_C;
o_C <= (i_A xor i_B) OR (i_C AND (i_A xor i_B));
End struct;
