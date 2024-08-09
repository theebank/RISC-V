library ieee;
use ieee.std_logic_1164.all;

ENTITY register1bit IS
	PORT (
		i_reg			 : IN STD_LOGIC;
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE struct OF register1bit IS

	
COMPONENT enARdFF_2 IS
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
END COMPONENT;

BEGIN

	dflops: enARdFF_2 PORT MAP(i_resetBar,i_reg,i_en,i_clk,o_reg,open);


END struct;
