library ieee;
use ieee.std_logic_1164.all;

ENTITY IDEX IS
PORT(
	i_pc		: IN STD_LOGIC_VECTOR(7 downto 0);
	i_rd1,i_rd2	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_sedata	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_ins2016	: IN STD_LOGIC_VECTOR(4 downto 0);
	i_ins1511	: IN STD_LOGIC_VECTOR(4 downto 0);
	i_EX		: IN STD_LOGIC_VECTOR(3 downto 0);
	i_M		: IN STD_LOGIC_VECTOR(2 downto 0);
	i_WB		: IN STD_LOGIC_VECTOR(1 downto 0);
	i_clk,i_en,i_resetbar	: IN STD_LOGIC;
	o_pc		: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_rd1,o_rd2	: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_sedata	: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_ins2016	: OUT STD_LOGIC_VECTOR(4 downto 0);
	o_ins1511	: OUT STD_LOGIC_VECTOR(4 downto 0);
	o_EX		: OUT STD_LOGIC_VECTOR(3 downto 0);
	o_M		: OUT STD_LOGIC_VECTOR(2 downto 0);
	o_WB		: OUT STD_LOGIC_VECTOR(1 downto 0));

END ENTITY;

ARCHITECTURE struct of IDEX IS
COMPONENT register8bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (7 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;

COMPONENT register5bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (4 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (4 downto 0));
END COMPONENT;

COMPONENT register4bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (3 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (3 downto 0));
END COMPONENT;

COMPONENT register3bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (2 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (2 downto 0));
END COMPONENT;

COMPONENT register2bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (1 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (1 downto 0));
END COMPONENT;

BEGIN
	pc: register8bit PORT MAP(i_pc,i_clk,i_en,i_resetbar,o_pc);
	ex: register4bit PORT MAP(i_EX,i_clk,i_en,i_resetbar,o_EX);
	m: register3bit PORT MAP(i_M,i_clk,i_en,i_resetbar,o_M);
	wb: register2bit PORT MAP(i_WB,i_clk,i_en,i_resetbar,o_WB);
	rd1: register8bit PORT MAP(i_rd1,i_clk,i_en,i_resetbar,o_rd1);
	rd2: register8bit PORT MAP(i_rd2,i_clk,i_en,i_resetbar,o_rd2);
	sedata: register8bit PORT MAP(i_sedata,i_clk,i_en,i_resetbar,o_sedata);
	ins2016: register5bit PORT MAP(i_ins2016,i_clk,i_en,i_resetbar,o_ins2016);
	ins1511: register5bit PORT MAP(i_ins1511,i_clk,i_en,i_resetbar,o_ins1511);
END struct;
