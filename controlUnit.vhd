--Authors: Devon Lin & Theeban Kumaresan
--Date: 6/24/2021
--CEG3156 Lab2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY controlUnit IS	
	PORT ( 
		opcode 					: IN std_logic_vector(5 downto 0); 
		regDst, jump, beq, memToReg, memRead 	: out std_logic; 
		aluSrc, regWrite, memWrite       	: out std_logic; 
		aluOp					: out std_logic_vector(1 downto 0)); 
END ENTITY; 

ARCHITECTURE rtl of controlUnit IS

signal int_rFormat, int_lw, int_sw, int_beq, int_jump : std_logic; 

BEGIN

	int_rFormat 	<= (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (not opcode(2)) and (not opcode(1)) and (not opcode(0)); 
	int_lw 		<=      opcode(5)  and (not opcode(4)) and (not opcode(3)) and (not opcode(2)) and      opcode(1)  and      opcode(0);
	int_sw  	<=      opcode(5)  and (not opcode(4)) and 	opcode(3)  and (not opcode(2)) and      opcode(1)  and      opcode(0);
	int_beq		<= (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and      opcode(2)  and (not opcode(1)) and (not opcode(0));
	int_jump 	<= (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (not opcode(2)) and      opcode(1)  and (not opcode(0));

 	aluSrc <= int_sw or int_lw; 
	memToReg <= int_lw; 
	regDst <= int_rFormat; 
	regWrite <= int_rFormat or int_lw;
	memRead <= int_lw;
	memWrite <= int_sw; 
	aluOp(0) <= int_beq; 
	aluOp(1) <= int_rFormat;
	beq <= int_beq; 
	jump <= int_jump;
END rtl; 
