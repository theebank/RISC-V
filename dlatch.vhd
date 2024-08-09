library ieee;
use ieee.std_logic_1164.all;

ENTITY dlatch IS
PORT(
	i_D		: IN STD_LOGIC;
	clk,reset	: IN STD_LOGIC;
	Q		: OUT STD_LOGIC);
END dlatch;

Architecture struct of dlatch IS
BEGIN
process(clk)
	begin
		if reset = '1' then
			q <= '0';
		elsif clk = '1' then
			q <= i_D;
		end if;
	end process;
end struct;
