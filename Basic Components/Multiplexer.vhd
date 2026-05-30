library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexer is
    Port (Sel: in STD_LOGIC;
          External_Input: in STD_LOGIC_VECTOR (7 downto 0); 
          Adder_Input: in STD_LOGIC_VECTOR (7 downto 0); 
          Multiplexer_Output: out STD_LOGIC_VECTOR (7 downto 0));
end Multiplexer;

architecture Multiplexer_Logic of Multiplexer is
begin
    process(External_Input, Adder_Input, Sel)
    begin
        if Sel = '0' then
            Multiplexer_Output <= External_Input;
        else
            Multiplexer_Output <= Adder_Input;
        end if;
    end process;
end Multiplexer_Logic;
