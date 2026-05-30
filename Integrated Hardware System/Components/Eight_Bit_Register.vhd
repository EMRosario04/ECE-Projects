library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Eight_Bit_Register is
    Port (Input: in STD_LOGIC_VECTOR (7 downto 0);
          load: in STD_LOGIC;
          clk: in STD_LOGIC;
          Output: out STD_LOGIC_VECTOR (7 downto 0));
end Eight_Bit_Register;

architecture Eight_Bit_Register_Logic of Eight_Bit_Register is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if load = '1' then
               Output <= Input;
            end if;
        end if;
    end process;
end Eight_Bit_Register_Logic;
