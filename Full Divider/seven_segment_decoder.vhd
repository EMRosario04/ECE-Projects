library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_segment_decoder is
    Port (Input : in  STD_LOGIC_VECTOR (3 downto 0);
          Output : out STD_LOGIC_VECTOR (6 downto 0));
End seven_segment_decoder;

architecture seven_segment_decoder_logic of seven_segment_decoder is
begin
    process(Input)
    begin
        case Input is
            when "0000" => Output <= "1000000"; 
            when "0001" => Output <= "1111001"; 
            when "0010" => Output <= "0100100";            
				when "0011" => Output <= "0110000";
            when "0100" => Output <= "0011001"; 
            when "0101" => Output <= "0010010"; 
            when "0110" => Output <= "0000010"; 
            when "0111" => Output <= "1111000"; 
            when "1000" => Output <= "0000000"; 
            when "1001" =>Output <= "0010000"; 
            when "1010" => Output <= "0001000"; 
            when "1011" => Output <= "0000011"; 
            when "1100" => Output <= "1000110"; 
            when "1101" => Output <= "0100001"; 
            when "1110" => Output <= "0000110"; 
            when "1111" => Output <= "0001110"; 
            when others => Output <= "1111111"; 
        end case;
    end process;
end seven_segment_decoder_logic;
