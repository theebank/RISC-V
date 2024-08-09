library ieee;
use ieee.std_logic_1164.all;

ENTITY EXMEM IS
PORT(
	i_pc	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_zero	: IN STD_LOGIC;
	i_alures: IN STD_LOGIC_VECTOR(7 downto 0);
	i_rd2	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_regdst: IN STD_LOGIC_VECTOR(4 downto 0);
	i_M	: IN STD_LOGIC_VECTOR(2 downto 0);
	i_WB	: IN STD_LOGIC_VECTOR(1 downto 0);
	i_clk,i_en,i_resetbar: IN STD_LOGIC;
	o_M	: OUT STD_LOGIC_VECTOR(2 downto 0);
	o_WB	: OUT STD_LOGIC_VECTOR(1 downto 0);
	o_pc	: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_zero	: OUT STD_LOGIC;
	o_alures: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_rd2	: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_regdst: OUT STD_LOGIC_VECTOR(4 downto 0));
END ENTITY;

ARCHITECTURE struct of EXMEM IS
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

COMPONENT register1bit IS
	PORT (
		i_reg			 : IN STD_LOGIC;
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC);
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
	m: register3bit PORT MAP(i_M,i_clk,i_en,i_resetbar,o_M);
	wb: register2bit PORT MAP(i_WB,i_clk,i_en,i_resetbar,o_WB);
	pc: register8bit PORT MAP(i_pc,i_clk,i_en,i_resetbar,o_pc);
	zero: register1bit PORT MAP(i_zero,i_clk,i_en,i_resetbar,o_zero);
	alures: register8bit PORT MAP(i_alures,i_clk,i_en,i_resetbar,o_alures);
	rd2: register8bit PORT MAP(i_rd2,i_clk,i_en,i_resetbar,o_rd2);
	regdst: register5bit PORT MAP(i_regdst,i_clk,i_en,i_resetbar,o_regdst);
END struct;

	
