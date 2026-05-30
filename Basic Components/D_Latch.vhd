library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_Latch is
    Port (Input: in STD_LOGIC;
          EN: in STD_LOGIC;
          Output : out STD_LOGIC);
end D_Latch;

architecture D_Latch_Logic of D_Latch is
begin
    process(Input, EN)
    begin
        if (EN = '1') then
            Output <= Input;
        end if;
    end process;
end D_Latch_Logic;
