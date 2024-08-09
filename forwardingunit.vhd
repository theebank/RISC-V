//Devon Lin 300056174 & Theeban Kumaresan 300062377
//This file contains the top level for our forwarding unit 

library ieee;
use ieee.std_logic_1164.all;

ENTITY forwardingunit IS
PORT(
	i_IDEXRS, i_IDEXRT,i_EXMEMRD,i_MEMWBRD	: IN STD_LOGIC_VECTOR(4 downto 0);
	i_EXMEM, i_MEMWB			: IN STD_LOGIC;
	o_forwardA,o_forwardB			: OUT STD_LOGIC_VECTOR(1 downto 0));
END ENTITY;

ARCHITECTURE struct of forwardingunit IS
	SIGNAL int_EXMEMRS,int_EXMEMRT,int_MEMWBRS,int_MEMWBRT	: STD_LOGIC;
	SIGNAL int_s1,int_s2,int_s3,int_s4	: STD_LOGIC;
	
BEGIN

	--The following four signals form the correct rs & rt values using an array of xnor gates
	int_EXMEMRS <= (i_EXMEMRD(4) xnor i_IDEXRS(4)) and (i_EXMEMRD(3) xnor i_IDEXRS(3)) and (i_EXMEMRD(2) xnor i_IDEXRS(2)) and (i_EXMEMRD(1) xnor i_IDEXRS(1)) and (i_EXMEMRD(0) xnor i_IDEXRS(0));
	int_EXMEMRT <= (i_EXMEMRD(4) xnor i_IDEXRT(4)) and (i_EXMEMRD(3) xnor i_IDEXRT(3)) and (i_EXMEMRD(2) xnor i_IDEXRT(2)) and (i_EXMEMRD(1) xnor i_IDEXRT(1)) and (i_EXMEMRD(0) xnor i_IDEXRT(0));	
	int_MEMWBRS <= (i_MEMWBRD(4) xnor i_IDEXRS(4)) and (i_MEMWBRD(3) xnor i_IDEXRS(3)) and (i_MEMWBRD(2) xnor i_IDEXRS(2)) and (i_MEMWBRD(1) xnor i_IDEXRS(1)) and (i_MEMWBRD(0) xnor i_IDEXRS(0));
	int_MEMWBRT <= (i_MEMWBRD(4) xnor i_IDEXRT(4)) and (i_MEMWBRD(3) xnor i_IDEXRT(3)) and (i_MEMWBRD(2) xnor i_IDEXRT(2)) and (i_MEMWBRD(1) xnor i_IDEXRT(1)) and (i_MEMWBRD(0) xnor i_IDEXRT(0));

	--The following four signals are based off of the data hazards outlined in the report 
	int_s1 <= i_EXMEM and (i_EXMEMRD(4) or i_EXMEMRD(3) or i_EXMEMRD(2) or i_EXMEMRD(1) or i_EXMEMRD(0)) and int_EXMEMRS;
	int_s2 <= i_EXMEM and (i_EXMEMRD(4) or i_EXMEMRD(3) or i_EXMEMRD(2) or i_EXMEMRD(1) or i_EXMEMRD(0)) and int_EXMEMRT;
	int_s3 <= i_MEMWB and (i_MEMWBRD(4) or i_MEMWBRD(3) or i_MEMWBRD(2) or i_MEMWBRD(1) or i_MEMWBRD(0)) and int_MEMWBRS;
	int_s4 <= i_MEMWB and (i_MEMWBRD(4) or i_MEMWBRD(3) or i_MEMWBRD(2) or i_MEMWBRD(1) or i_MEMWBRD(0)) and int_MEMWBRT;

	--output drivers
	--These control signals control the multiplexers in the EX stage 
	o_forwardA <= ((not int_s1) and int_s3) & int_s1;
	o_forwardB <= ((not int_s2) and int_s4) & int_s2;

end struct;
