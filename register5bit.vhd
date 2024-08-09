library ieee;
use ieee.std_logic_1164.all;

ENTITY register5bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (4 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (4 downto 0));
END ENTITY;

ARCHITECTURE struct OF register5bit IS
	SIGNAL int_regSig : STD_LOGIC_VECTOR(4 downto 0);
	
COMPONENT enARdFF_2 IS
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
END COMPONENT;

BEGIN
	dflipflops:
		for i in 0 to 4 generate
			dflops: enARdFF_2 PORT MAP(i_resetBar,i_reg(i),i_en,i_clk,int_regSig(i),open);
		end generate dflipflops;
	o_reg 	<= int_regSig;
END struct;
