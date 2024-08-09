library ieee;
use ieee.std_logic_1164.all;
entity mux4to1_8bit is
   port(
      i_0, i_1, i_2, i_3: in std_logic_vector(7 downto 0);
      sel: in std_logic_vector(1 downto 0);
      o_mux: out std_logic_vector(7 downto 0)
   );
end mux4to1_8bit;

architecture rtl of mux4to1_8bit is
begin
   o_mux <= i_0 when (sel="00") else
        i_1 when (sel="01") else
        i_2 when (sel="10") else
        i_3;
end rtl;
