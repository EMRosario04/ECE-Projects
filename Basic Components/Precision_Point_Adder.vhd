library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Precision_Point_Adder is
    Port (
        clk: in  STD_LOGIC;
        restart: in  STD_LOGIC; 
        start: in  STD_LOGIC;
        A_Input: in  STD_LOGIC_VECTOR (31 downto 0);
        B_Input: in  STD_LOGIC_VECTOR (31 downto 0);
        Result_Output : out STD_LOGIC_VECTOR (31 downto 0);
        Standby: out STD_LOGIC;
        Done_Signal: out STD_LOGIC
    );
end Precision_Point_Adder;

architecture Precision_Point_Adder_Logic of Precision_Point_Adder is

    type phase is (stop, start_phase, shift_phase, calc_phase, format_notation, finish_phase);
    signal state : phase;

    signal Sign_A, Sign_B: STD_LOGIC;
    signal Exponent_A, Exponent_B : unsigned(7 downto 0);
    signal Temp_Sig_A, Temp_Sig_B : unsigned(23 downto 0);

    signal Final_Sign: STD_LOGIC;
    signal Final_Exponent: unsigned(7 downto 0);
    signal Temp_Sig_Result: unsigned(24 downto 0);

begin

    process(clk, restart)
    begin
        if restart = '0' then
            state <= stop;
            Result_Output   <= (others => '0');
            Standby <= '1';
            Done_Signal <= '0';
            Sign_A <= '0'; 
            Sign_B <= '0';
            Exponent_A <= (others => '0'); 
            Exponent_B <= (others => '0');
            Temp_Sig_A <= (others => '0'); 
            Temp_Sig_B <= (others => '0');
            Final_Sign <= '0';
            Final_Exponent  <= (others => '0');
            Temp_Sig_Result <= (others => '0');

        elsif rising_edge(clk) then
            case state is

                when stop =>
                    Standby     <= '1';
                    Done_Signal <= '0';
                    if start = '0' then
                        Standby <= '0';
                        state   <= start_phase;
                    end if;

                when start_phase =>
                    Sign_A     <= A_Input(31);
                    Sign_B     <= B_Input(31);
                    Exponent_A <= unsigned(A_Input(30 downto 23));
                    Exponent_B <= unsigned(B_Input(30 downto 23));

                    if unsigned(A_Input(30 downto 23)) = 0 then
                        Temp_Sig_A <= (others => '0');
                    else
                        Temp_Sig_A <= unsigned('1' & A_Input(22 downto 0));
                    end if;

                    if unsigned(B_Input(30 downto 23)) = 0 then
                        Temp_Sig_B <= (others => '0');
                    else
                        Temp_Sig_B <= unsigned('1' & B_Input(22 downto 0));
                    end if;

                    state <= shift_phase;

                when shift_phase =>
                    if Exponent_A > Exponent_B then
                        Temp_Sig_B     <= shift_right(Temp_Sig_B, to_integer(Exponent_A - Exponent_B));
                        Final_Exponent <= Exponent_A;
                    elsif Exponent_B > Exponent_A then
                        Temp_Sig_A     <= shift_right(Temp_Sig_A, to_integer(Exponent_B - Exponent_A));
                        Final_Exponent <= Exponent_B;
                    else
                        Final_Exponent <= Exponent_A;
                    end if;

                    state <= calc_phase;

                when calc_phase =>
                    if Sign_A = Sign_B then
                        Temp_Sig_Result <= ('0' & Temp_Sig_A) + ('0' & Temp_Sig_B);
                        Final_Sign      <= Sign_A;
                    else
                        if Temp_Sig_A >= Temp_Sig_B then
                            Temp_Sig_Result <= ('0' & Temp_Sig_A) - ('0' & Temp_Sig_B);
                            Final_Sign      <= Sign_A;
                        else
                            Temp_Sig_Result <= ('0' & Temp_Sig_B) - ('0' & Temp_Sig_A);
                            Final_Sign      <= Sign_B;
                        end if;
                    end if;

                    state <= format_notation;

                when format_notation =>
                    if Temp_Sig_Result = 0 then
                        Final_Exponent <= (others => '0');
                        Final_Sign     <= '0';
                        state          <= finish_phase;
                        
                    elsif Temp_Sig_Result(24) = '1' then
                        Temp_Sig_Result <= shift_right(Temp_Sig_Result, 1);
                        Final_Exponent  <= Final_Exponent + 1;
                        state           <= finish_phase;
                        
                    elsif Temp_Sig_Result(23) = '0' then
                        Temp_Sig_Result <= shift_left(Temp_Sig_Result, 1);
                        Final_Exponent  <= Final_Exponent - 1;
                        state <= format_notation; 
                        
                    else

                        state <= finish_phase;
                    end if;

                when finish_phase =>
                    if Final_Exponent = 0 and Temp_Sig_Result = 0 then
                        Result_Output <= (others => '0');
                    else
                        Result_Output <= Final_Sign & std_logic_vector(Final_Exponent) & std_logic_vector(Temp_Sig_Result(22 downto 0));
                    end if;
                    Standby     <= '1';
                    Done_Signal <= '1';
                    state       <= stop;
            end case;
        end if;
    end process;
end Precision_Point_Adder_Logic;
