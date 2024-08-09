library ieee;
use ieee.std_logic_1164.all;

ENTITY branchshiftleft2 IS
PORT(
	i_A	: IN STD_LOGIC_VECTOR(7 downto 0);
	O	: OUT STD_LOGIC_VECTOR(7 downto 0));
END branchshiftleft2;

ARCHITECTURE struct of branchshiftleft2 IS
	SIGNAL zeros : STD_LOGIC_VECTOR(1 downto 0) := "00";
	SIGNAL tmp : STD_LOGIC_VECTOR(5 downto 0);
begin
	tmp <= i_A(5 downto 0);
	O(7 downto 2) <= tmp;
	O(1 downto 0) <= zeros;
END;
