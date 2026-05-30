library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_Flip_Flop is
    Port (Input: in STD_LOGIC;
          clk: in STD_LOGIC;
          Output: out STD_LOGIC);
end D_Flip_Flop;

architecture D_Flip_Flop_Logic of D_Flip_Flop is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            Output <= Input;
        end if;
    end process;
end D_Flip_Flop_Logic;
