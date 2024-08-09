library ieee;
use ieee.std_logic_1164.all;

ENTITY mux2to15bit IS
PORT(
	i_A,i_B : IN STD_LOGIC_VECTOR(4 downto 0);
	i_S 	: IN STD_LOGIC;
	o_P	: OUT STD_LOGIC_VECTOR(4 downto 0));
END mux2to15bit;

ARCHITECTURE struct of mux2to15bit IS
BEGIN
	o_P <= i_A when (i_S = '1') else i_B;
END struct;


