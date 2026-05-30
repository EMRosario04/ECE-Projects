library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Divider is
    Port ( 
        SW: in  STD_LOGIC_VECTOR (7 downto 0); 
        Circuit_state: in  STD_LOGIC_VECTOR (2 downto 0); 
        Full_Input1: out STD_LOGIC_VECTOR (6 downto 0); 
        Full_Input2: out STD_LOGIC_VECTOR (6 downto 0); 
        Quotient_1: out STD_LOGIC_VECTOR (6 downto 0);
        Quotient_2: out STD_LOGIC_VECTOR (6 downto 0); 
        LED_Done: out STD_LOGIC_VECTOR (9 downto 0));
end Full_Divider;

architecture Full_Divider_Logic of Full_Divider is

    component four_bit_divider is
        Port (clk: in  STD_LOGIC;
              reset: in  STD_LOGIC;
              start: in  STD_LOGIC;
              Dividend_Input: in  STD_LOGIC_VECTOR (3 downto 0);
              Divisor_Input: in  STD_LOGIC_VECTOR (3 downto 0);
              Quotient_Output: out STD_LOGIC_VECTOR (3 downto 0);
              Remainder_Output: out STD_LOGIC_VECTOR (3 downto 0);
              Standby: out STD_LOGIC;
              Div_Zero: out STD_LOGIC);
    end component;

   
    component seven_segment_decoder is
        Port (Input: in  STD_LOGIC_VECTOR (3 downto 0);
              Output: out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    
    signal final_quotient: STD_LOGIC_VECTOR(3 downto 0);
    signal final_remainder: STD_LOGIC_VECTOR(3 downto 0);

begin

    
    Full_Divider: 
		four_bit_divider port map (
			clk => circuit_state(0),          
         reset => circuit_state(1),          
         start => circuit_state(2),          
         Dividend_Input => SW(7 downto 4),  
         Divisor_Input => SW(3 downto 0),  
         Quotient_Output => final_quotient,          
         Remainder_Output => final_remainder,          
         Standby => LED_Done(0),         
         Div_Zero => LED_Done(9));

    
    seven_segment_input_1: seven_segment_decoder port map (Input => SW(7 downto 4), Output => Full_Input1);
    seven_segment_input_2: seven_segment_decoder port map (Input => SW(3 downto 0), Output => Full_Input2);

    seven_segment_output_1: seven_segment_decoder port map (Input => final_quotient, Output => Quotient_2);
    seven_segment_output_2: seven_segment_decoder port map (Input => final_remainder, Output => Quotient_1);

end Full_Divider_Logic;
