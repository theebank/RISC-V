library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY PC IS
PORT(
	clk, reset	: IN STD_LOGIC;
	i_A		: IN STD_LOGIC_VECTOR(7 downto 0);
	o_A		: OUT STD_LOGIC_VECTOR(7 downto 0));
END PC;

ARCHITECTURE struct of PC IS

component dlatch IS
	PORT(
		i_D		: IN STD_LOGIC;
		clk,reset	: IN STD_LOGIC;
		Q		: OUT STD_LOGIC);
END component;

BEGIN
	GEN_Dlatch:
		for I in 0 to 7 generate
			di: dlatch PORT MAP(
				i_A(i),
				clk,
				reset,
				o_A(i));
		end generate GEN_Dlatch;
end struct;	