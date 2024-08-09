LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity mux8to1_8bit IS
    Port (sel : IN std_logic_vector(2 downto 0);
   in0 :in STD_LOGIC_VECTOR(7 downto 0);
   in1 :in STD_LOGIC_VECTOR(7 downto 0);
   in2 :in STD_LOGIC_VECTOR(7 downto 0);
   in3 :in STD_LOGIC_VECTOR(7 downto 0);
   in4 :in STD_LOGIC_VECTOR(7 downto 0);
   in5 :in STD_LOGIC_VECTOR(7 downto 0);
   in6 :in STD_LOGIC_VECTOR(7 downto 0);
   in7 :in STD_LOGIC_VECTOR(7 downto 0);
   Y :out STD_LOGIC_VECTOR(7 downto 0) );
  End mux8to1_8bit ;

  Architecture rtl of mux8to1_8bit is
     Signal a0,a1,a2,a3,a4,a5,a6,a7 : STD_LOGIC_VECTOR(7 downto 0);
    begin
    process(in0, in1, in2, in3, in4, in5, in6, in7, sel)
    begin
    Case sel is
	When"000"=>Y<=in0;
	When"001"=>Y<=in1;
	When"010"=>Y<=in2;
	When"011"=>Y<=in3;
	When"100"=>Y<=in4;
	When"101"=>Y<=in5;
	When"110"=>Y<=in6;
	When"111"=>Y<=in7;
	when others => Y <= "00000000";
	end case;
    end process; 
end rtl;
