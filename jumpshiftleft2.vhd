library ieee;
use ieee.std_logic_1164.all;

ENTITY jumpshiftleft2 IS
PORT(
	i_A	: IN STD_LOGIC_VECTOR(25 downto 0);
	O	: OUT STD_LOGIC_VECTOR(27 downto 0));
END jumpshiftleft2;

ARCHITECTURE struct of jumpshiftleft2 IS
	SIGNAL zeros : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin

	O <= i_A & zeros;
END;