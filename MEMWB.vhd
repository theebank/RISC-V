library ieee;
use ieee.std_logic_1164.all;

ENTITY MEMWB IS 
PORT(
	i_WB	: IN STD_LOGIC_VECTOR(1 downto 0);
	i_rdm	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_alures: IN STD_LOGIC_VECTOR(7 downto 0);
	i_regdst: IN STD_LOGIC_VECTOR(4 downto 0);
	i_clk,i_en,i_resetbar	: IN STD_LOGIC;
	o_WB	: OUT STD_LOGIC_VECTOR(1 downto 0);
	o_rdm	: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_alures: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_regdst: OUT STD_LOGIC_VECTOR(4 downto 0));
END ENTITY;

ARCHITECTURE struct of MEMWB IS
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
	
	wb: register2bit PORT MAP(i_WB,i_clk,i_en,i_resetbar,o_WB);
	rdm: register8bit PORT MAP(i_rdm,i_clk,i_en,i_resetbar,o_rdm);
	alures: register8bit PORT MAP(i_alures,i_clk,i_en,i_resetbar,o_alures);
	regdst: register5bit PORT MAP(i_regdst,i_clk,i_en,i_resetbar,o_regdst);

END struct;