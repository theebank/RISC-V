--Authors: Devon Lin & Theeban Kumaresan
--Date: 6/25/2021
--CEG3156 Lab2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY lpm;
USE lpm.lpm_components.ALL;

ENTITY dataMemory IS
	PORT( 
		i_inClock, i_outClock	: IN std_logic; 
		i_write_en 		: IN std_logic; 
		i_data, i_addr		: IN std_logic_vector(7 downto 0);
		o_data 			: OUT std_logic_vector(7 downto 0)); 
END dataMemory; 

ARCHITECTURE rtl of dataMemory IS

COMPONENT lpm_ram_dq
	GENERIC
		(	LPM_WIDTH : natural;    -- MUST be greater than 0
                        LPM_WIDTHAD : natural;    -- MUST be greater than 0
                        LPM_NUMWORDS : natural := 0;
                        LPM_INDATA : string := "REGISTERED";
			LPM_ADDRESS_CONTROL: string := "REGISTERED";
			LPM_OUTDATA : string := "REGISTERED";
			LPM_FILE : string := "UNUSED";
			LPM_TYPE : string := L_RAM_DQ;
			USE_EAB  : string := "ON";
			INTENDED_DEVICE_FAMILY  : string := "UNUSED";
			LPM_HINT : string := "UNUSED");
	port ( 		INCLOCK : in std_logic := '0';
			OUTCLOCK : in std_logic := '0';
			ADDRESS : in std_logic_vector(LPM_WIDTHAD-1 downto 0); 
			DATA : in std_logic_vector(LPM_WIDTHAD-1 downto 0); 
			WE : in std_logic := '0';
			Q : out std_logic_vector(LPM_WIDTH-1 downto 0)); 
END COMPONENT; 

CONSTANT datafile : String := "data.mif"; 
SIGNAL int_data : std_logic_vector(7 downto 0); 

BEGIN 

dataMemory : lpm_ram_dq 
	GENERIC MAP (	LPM_WIDTH => 8,
			LPM_WIDTHAD => 8,
			LPM_NUMWORDS => 256,
			LPM_FILE => dataFile)
	PORT MAP (	INCLOCK => i_inClock, 
			OUTCLOCK => i_outClock,
			ADDRESS => i_addr,
			DATA => i_data,
			WE => i_write_en, 
			Q => int_data); 
	
	--OUTPUT DRIVER
	o_data <= int_data; 
END rtl; 
			
			
			
