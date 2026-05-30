library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity four_bit_divider is
    Port (
        clk: in  STD_LOGIC;
        reset: in  STD_LOGIC;
        start: in  STD_LOGIC;
        Dividend_Input: in  STD_LOGIC_VECTOR (3 downto 0);
        Divisor_Input: in  STD_LOGIC_VECTOR (3 downto 0);
        Quotient_Output: out STD_LOGIC_VECTOR (3 downto 0);
        Remainder_Output: out STD_LOGIC_VECTOR (3 downto 0);
        Standby: out STD_LOGIC;
        Div_Zero: out STD_LOGIC
    );
end four_bit_divider;

architecture four_bit_divider_logic of four_bit_divider is
    
    type phase is (stop, divide, done);
    signal state : phase;

    signal Divisor_reg : unsigned(4 downto 0); 
    signal count : integer range 0 to 4;

begin
    process(clk, reset)
        variable Remainder_Stage: unsigned(4 downto 0); 
        variable Quotient_Stage : unsigned(3 downto 0);
    begin
        if reset = '0' then 
            state <= stop;
            Standby <= '1';
            Div_Zero <= '0';
            Quotient_Output <= (others => '0');
            Remainder_Output <= (others => '0');
            
        elsif rising_edge(clk) then
            case state is
                
                when stop =>
                    Standby <= '1';
                    if start = '0' then 
                        if Divisor_Input = "0000" then
                            Div_Zero <= '1'; 
                        else
                            Div_Zero <= '0';
                            Standby <= '0';
                            
                           
                            Remainder_Stage := (others => '0'); 
                            Quotient_Stage := unsigned(Dividend_Input); 
                            Divisor_reg <= '0' & unsigned(Divisor_Input);
                            
                            count <= 4; 
                            state <= divide;
                        end if;
                    end if;

                when divide =>
                    
						  Remainder_Stage := Remainder_Stage(3 downto 0) & Quotient_Stage(3);
                    Quotient_Stage := Quotient_Stage(2 downto 0) & '0';

                    Remainder_Stage := Remainder_Stage - Divisor_reg;

                    if Remainder_Stage(4) = '1' then 
                        Remainder_Stage := Remainder_Stage + Divisor_reg;  
                        Quotient_Stage(0) := '0';     
                    else
                        Quotient_Stage(0) := '1';     
                    end if;

                    if count = 1 then
                        Quotient_Output <= std_logic_vector(Quotient_Stage);
                        Remainder_Output <= std_logic_vector(Remainder_Stage(3 downto 0));
                        state <= done;
                    else
                        count <= count - 1;
                    end if;

                when done =>
                    Standby <= '1';
                    state <= stop;
                    
            end case;
        end if;
    end process;
end four_bit_divider_logic;