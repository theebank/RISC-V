//Devon Lin 300056174 & Theeban Kumaresan 300062377
//This file contains the top level for our hazard detection unit 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY hazardDetectionUnit IS
	PORT (
		i_IDEX_MemRead : IN STD_LOGIC;
		i_IFID_Rs : IN STD_LOGIC_VECTOR(4 downto 0);
		i_IDEX_Rt : IN STD_LOGIC_VECTOR(4 downto 0);
		i_IFID_Rt : IN STD_LOGIC_VECTOR(4 downto 0);
		o_stall : OUT STD_LOGIC);
END hazardDetectionUnit;

ARCHITECTURE struct OF hazardDetectionUnit IS

SIGNAL int_stall, int_hazard1, int_hazard2 : STD_LOGIC;

BEGIN

--Internal signals are driven with the logic that determines the hazards (outlined in design doc)
int_hazard1 <= (i_IDEX_Rt(4) XNOR i_IFID_Rs(4)) AND (i_IDEX_Rt(3) XNOR i_IFID_Rs(3)) AND (i_IDEX_Rt(2) XNOR i_IFID_Rs(2)) AND (i_IDEX_Rt(1) XNOR i_IFID_Rs(1)) AND (i_IDEX_Rt(0) XNOR i_IFID_Rs(0));
int_hazard2 <= (i_IDEX_Rt(4) XNOR i_IFID_Rt(4)) AND (i_IDEX_Rt(3) XNOR i_IFID_Rt(3)) AND (i_IDEX_Rt(2) XNOR i_IFID_Rt(2)) AND (i_IDEX_Rt(1) XNOR i_IFID_Rt(1)) AND (i_IDEX_Rt(0) XNOR i_IFID_Rt(0));

int_stall <= i_IDEX_MemRead AND (int_hazard1 OR int_hazard2);

	--Output drivers
	o_stall <= int_stall;

END struct;
			
