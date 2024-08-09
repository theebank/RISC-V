--Authors: Devon Lin & Theeban Kumaresan
--Date: 6/16/2021
--CEG3156 Lab2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register8bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (7 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (7 downto 0));
END;

ARCHITECTURE struct OF register8bit IS

	SIGNAL  int_regSig : STD_LOGIC_VECTOR(7 downto 0);
	
COMPONENT enARdFF_2 IS
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
END COMPONENT;

BEGIN
	DFF_0 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(0),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(0),
		o_qBar		=>open);

	DFF_1 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(1),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(1),
		o_qBar		=>open);

	DFF_2 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(2),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(2),
		o_qBar		=>open);

	DFF_3 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(3),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(3),
		o_qBar		=>open);

	DFF_4 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(4),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(4),
		o_qBar		=>open);

	DFF_5 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(5),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(5),
		o_qBar		=>open);

	DFF_6 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(6),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(6),
		o_qBar		=>open);
	
	DFF_7 : enARdFF_2
	PORT MAP(
		i_resetBar	=>i_resetbar,
		i_d		=>i_reg(7),
		i_enable	=>i_en,
		i_clock		=>i_clk,
		o_q		=>int_regSig(7),
		o_qBar		=>open);

	--Output Driver
	o_reg 	<= int_regSig;
END struct;
