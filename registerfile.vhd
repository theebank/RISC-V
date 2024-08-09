--Authors: Devon Lin & Theeban Kumaresan
--Date: 6/17/2021
--CEG3156 Lab2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registerFile IS
	PORT(
		i_read1, i_read2 : IN std_logic_vector(2 downto 0);
		i_write_s 	 : IN std_logic_vector(2 downto 0); 
		i_write_data	 : IN std_logic_vector(7 downto 0);
		i_clk, i_resetbar, i_write_en : IN std_logic; 
		o_data1, o_data2 : OUT std_logic_vector(7 downto 0)
	);
END registerFile; 

ARCHITECTURE rtl of registerFile IS

	SIGNAL int_readData1, int_readData2 : std_logic_vector(7 downto 0);
	SIGNAL int_write_en, int_dec_out    : std_logic_vector(7 downto 0); 
	SIGNAL int_reg0, int_reg1, int_reg2 : std_logic_vector(7 downto 0); 
	SIGNAL int_reg3, int_reg4, int_reg5 : std_logic_vector(7 downto 0);
	SIGNAL int_reg6, int_reg7           : std_logic_vector(7 downto 0);

COMPONENT decoder3to8 IS
	PORT(
		i_in  : IN STD_LOGIC_VECTOR (2 downto 0);
		o_out : OUT STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT; 


COMPONENT register8bit IS 
	PORT(
		i_reg			 : IN STD_LOGIC_VECTOR (7 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT; 

COMPONENT mux8to1_8bit IS 
	PORT( 
   sel : IN std_logic_vector(2 downto 0);
   in0 	:in STD_LOGIC_VECTOR(7 downto 0);
   in1 	:in STD_LOGIC_VECTOR(7 downto 0);
   in2 	:in STD_LOGIC_VECTOR(7 downto 0);
   in3 	:in STD_LOGIC_VECTOR(7 downto 0);
   in4	 :in STD_LOGIC_VECTOR(7 downto 0);
   in5 	:in STD_LOGIC_VECTOR(7 downto 0);
   in6 	:in STD_LOGIC_VECTOR(7 downto 0);
   in7 	:in STD_LOGIC_VECTOR(7 downto 0);
   Y 	:out STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT; 

BEGIN 

--Signal Assignment
int_write_en(0) <= i_write_en AND int_dec_out(0);
int_write_en(1) <= i_write_en AND int_dec_out(1);
int_write_en(2) <= i_write_en AND int_dec_out(2);
int_write_en(3) <= i_write_en AND int_dec_out(3);
int_write_en(4) <= i_write_en AND int_dec_out(4);
int_write_en(5) <= i_write_en AND int_dec_out(5);
int_write_en(6) <= i_write_en AND int_dec_out(6);
int_write_en(7) <= i_write_en AND int_dec_out(7);

--Setup Components 

Reg0 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(0), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg0); 

Reg1 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(1), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg1); 

Reg2 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(2), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg2); 

Reg3 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(3), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg3); 

Reg4 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(4), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg4); 

Reg5 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(5), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg5);

Reg6 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(6), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg6); 
 
Reg7 : register8bit
PORT MAP(
	i_reg => i_write_data, 
	i_clk => i_clk, 
	i_en => int_write_en(7), 
	i_resetbar => i_resetbar, 
	o_reg => int_reg7); 

Mux1 : mux8to1_8bit
PORT MAP(
	sel => i_read1,
	in0 => int_reg0, 
	in1 => int_reg1, 
	in2 => int_reg2, 
	in3 => int_reg3, 
	in4 => int_reg4, 
	in5 => int_reg5, 
	in6 => int_reg6,
	in7 => int_reg7, 
	Y   => int_readData1); 

Mux2 : mux8to1_8bit
PORT MAP(
	sel => i_read2,
	in0 => int_reg0, 
	in1 => int_reg1, 
	in2 => int_reg2, 
	in3 => int_reg3, 
	in4 => int_reg4, 
	in5 => int_reg5, 
	in6 => int_reg6,
	in7 => int_reg7, 
	Y   => int_readData2); 	
	
Decoder : decoder3to8
PORT MAP(
	i_in => i_write_s,
	o_out => int_dec_out);

--Output Driver
o_data1 <= int_readData1; 
o_data2 <= int_readData2; 

END rtl;










