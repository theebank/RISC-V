library ieee;
use ieee.std_logic_1164.all;

ENTITY IFID IS
PORT(
	i_mem	: IN STD_LOGIC_VECTOR(31 downto 0);
	i_pc	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_clk,i_en,i_resetbar	: IN STD_LOGIC;
	o_mem	: OUT STD_LOGIC_VECTOR(31 downto 0);
	o_pc	: OUT STD_LOGIC_VECTOR(7 downto 0));
END ENTITY;

ARCHITECTURE struct of IFID IS
COMPONENT register8bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (7 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;

COMPONENT register32bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (31 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT;

BEGIN
	PC: register8bit PORT MAP(i_pc, i_clk,i_en,i_resetbar,o_pc);
	insmem	: register32bit PORT MAP(i_mem,i_clk,i_en,i_resetbar,o_mem);

END struct;