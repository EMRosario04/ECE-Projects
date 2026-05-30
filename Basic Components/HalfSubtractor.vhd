library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HalfSubtractor is
    Port (A: in STD_LOGIC;
          B: in STD_LOGIC;
          Difference: out STD_LOGIC; 
          Bout: out STD_LOGIC
			 );
end HalfSubtractor;

architecture TotalSum of HalfSubtractor is
begin
    Difference <= A xor B;
    Bout <= (not A) and B;
end TotalSum;
