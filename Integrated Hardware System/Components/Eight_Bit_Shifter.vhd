library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Eight_Bit_Shifter is
    Port (Input_RegisterA: in STD_LOGIC_VECTOR (7 downto 0);
          Output_RegisterD: out STD_LOGIC_VECTOR (7 downto 0));
end Eight_Bit_Shifter;

architecture Eight_Bit_Shifter_Logic of Eight_Bit_Shifter is
begin
    Output_RegisterD <= Input_RegisterA(6 downto 0) & '0';
end Eight_Bit_Shifter_Logic;
