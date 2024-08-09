--Authors: Devon Lin & Theeban Kumaresan
--Date: 6/15/2021
--CEG3156 Lab2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY signExtend IS
	PORT(
		i_se	: in std_logic_vector(15 downto 0); 
		o_se	: out std_logic_vector(31 downto 0));
END signExtend; 

ARCHITECTURE rtl OF signExtend is 
Signal int_se : std_logic_vector(31 downto 0); 

BEGIN 
	--Signal Assignment
	int_se(0) <= i_se(0);
	int_se(1) <= i_se(1);
	int_se(2) <= i_se(2);
	int_se(3) <= i_se(3);
	int_se(4) <= i_se(4);
	int_se(5) <= i_se(5);
	int_se(6) <= i_se(6);
	int_se(7) <= i_se(7);
	int_se(8) <= i_se(8);
	int_se(9) <= i_se(9);
	int_se(10) <= i_se(10);
	int_se(11) <= i_se(11);
	int_se(12) <= i_se(12);
	int_se(13) <= i_se(13);
	int_se(14) <= i_se(14);
	int_se(15) <= i_se(15);
	int_se(16) <= i_se(15);
	int_se(17) <= i_se(15);
	int_se(18) <= i_se(15);
	int_se(19) <= i_se(15);
	int_se(20) <= i_se(15);
	int_se(21) <= i_se(15);
	int_se(22) <= i_se(15);
	int_se(23) <= i_se(15);
	int_se(24) <= i_se(15);
	int_se(25) <= i_se(15);
	int_se(26) <= i_se(15);
	int_se(27) <= i_se(15);
	int_se(28) <= i_se(15);
	int_se(29) <= i_se(15);
	int_se(30) <= i_se(15);
	int_se(31) <= i_se(15);
	
	--Output Driver
	o_se <= int_se;
END rtl;
