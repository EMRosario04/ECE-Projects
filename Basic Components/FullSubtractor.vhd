library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullSubtractor is
    Port ( A: in STD_LOGIC;
           B: in STD_LOGIC;
           Cin: in STD_LOGIC;
           Difference: out STD_LOGIC;
           Cout: out STD_LOGIC
    );
end FullSubtractor;

architecture TotalDifference of FullSubtractor is
begin
    Difference <= A xor B xor Cin;
    Cout <= ((not A) and B) or (Cin and (not (A xor B)));
end TotalDifference;