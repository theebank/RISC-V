library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY PCadder32 IS 
PORT(
	CLK	: IN STD_LOGIC;
	i_A	: IN STD_LOGIC_VECTOR(7 downto 0);
	o_A	: OUT STD_LOGIC_VECTOR(7 downto 0));
END PCadder32;

ARCHITECTURE struct of PCadder32 IS

BEGIN

process(CLK)
	begin
		if rising_edge(CLK) then
			o_A <= STD_LOGIC_VECTOR(unsigned(i_A)+4);
		end if;
	end process;

end struct;
