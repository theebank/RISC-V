LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decoder3to8 IS
	PORT (
		i_in : IN STD_LOGIC_VECTOR (2 downto 0);
		o_out : OUT STD_LOGIC_VECTOR (7 downto 0) );
END decoder3to8;

ARCHITECTURE struct OF decoder3to8 IS

	SIGNAL int_sig : STD_LOGIC_VECTOR (7 downto 0);

BEGIN
	--Signal Assignment
	int_sig(0) <= not(i_in(2)) AND not(i_in(1)) AND not(i_in(0)); 
	int_sig(1) <= not(i_in(2)) AND not(i_in(1)) AND     i_in(0) ; 
	int_sig(2) <= not(i_in(2)) AND     i_in(1)  AND not(i_in(0)); 
	int_sig(3) <= not(i_in(2)) AND     i_in(1)  AND     i_in(0) ;
	int_sig(4) <=     i_in(2)  AND not(i_in(1)) AND not(i_in(0)); 
	int_sig(5) <=     i_in(2)  AND not(i_in(1)) AND     i_in(0) ; 
	int_sig(6) <=     i_in(2)  AND     i_in(1)  AND not(i_in(0));
	int_sig(7) <=     i_in(2)  AND     i_in(1)  AND     i_in(0) ;
	--Output Driver
	o_out <= int_sig;
END struct;
