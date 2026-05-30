library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Multiplier is
    Port ( 
        SW: in  STD_LOGIC_VECTOR (9 downto 0); 
        Input_A: out STD_LOGIC_VECTOR (6 downto 0); 
        Input_B: out STD_LOGIC_VECTOR (6 downto 0);
        Output_1: out STD_LOGIC_VECTOR (6 downto 0); 
        Output_2: out STD_LOGIC_VECTOR (6 downto 0));
end Full_Multiplier;

architecture Full_Multiplier_Logic of Full_Multiplier is

    Component array_multiplier is
		Port (Multiplier_A: in STD_LOGIC_VECTOR (3 downto 0);
            Multiplier_B: in STD_LOGIC_VECTOR (3 downto 0);
            Multiplier_Output: out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    Component seven_segment_decoder is
		Port (Input : in  STD_LOGIC_VECTOR (3 downto 0);
            Output: out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    signal Final_Output: STD_LOGIC_VECTOR(7 downto 0);

begin

    multiplier: array_multiplier port map (
        Multiplier_A => SW(9 downto 6),
        Multiplier_B => SW(3 downto 0),
        Multiplier_Output => Final_Output);

    First_input: seven_segment_decoder port map (Input => SW(9 downto 6), Output => Input_A);
    Second_Input: seven_segment_decoder port map (Input => SW(3 downto 0), Output => Input_B);

   seven_segment_output_1: seven_segment_decoder port map (Input => Final_Output(7 downto 4), Output => Output_1);
   seven_segment_output_2: seven_segment_decoder port map (Input => Final_Output(3 downto 0), Output => Output_2);

End Full_Multiplier_Logic;
