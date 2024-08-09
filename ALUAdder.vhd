library ieee;
use ieee.std_logic_1164.all;

ENTITY ALUAdder IS
PORT(
	i_A, i_B	: IN STD_LOGIC_VECTOR(7 downto 0);
	in_C		: IN STD_LOGIC;
	ou_C		: OUT STD_LOGIC;
	o_Result	: buffer STD_LOGIC_VECTOR(7 downto 0));
END ALUAdder;


ARCHITECTURE struct of ALUAdder IS

COMPONENT fulladder IS
PORT(
	i_A,i_B,i_C	: IN STD_LOGIC;
	o_S,o_C		: OUT STD_LOGIC);
END COMPONENT;


	SIGNAL int_C : STD_LOGIC_VECTOR(7 downto 0);
BEGIN
	addercomponents:
		for i in 0 to 7 generate
			adderzerobit: 
			if (i = 0) generate
				adderzero: fulladder PORT MAP(i_A(i),i_B(i),in_C,o_Result(i),int_C(i));
			end generate adderzerobit;

			addermsb:
			if(i=7) generate
				addermsb : fulladder PORT MAP(i_A(i),i_B(i),int_C(i-1),o_Result(i),ou_C);
			end generate addermsb;
			
			fulladders:
			if(i>0 and i<7) generate
				adders	: fulladder PORT MAP(i_A(i),i_B(i),int_C(i-1),o_Result(i),int_C(i));
			end generate fulladders;
		end generate addercomponents;
	end struct;
