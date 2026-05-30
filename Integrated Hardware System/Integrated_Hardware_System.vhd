library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Integrated_Hardware_System is
    Port (B: in STD_LOGIC_VECTOR(7 downto 0);
          C: in STD_LOGIC_VECTOR(7 downto 0);
          External_Input: in STD_LOGIC_VECTOR(7 downto 0);
          Sel: in STD_LOGIC;
          LoadA: in STD_LOGIC;
          LoadD: in STD_LOGIC;
          clk: in STD_LOGIC;
          Output_A: out STD_LOGIC_VECTOR(7 downto 0);
          Output_D: out STD_LOGIC_VECTOR(7 downto 0));
end Integrated_Hardware_System;

architecture Integrated_Hardware_System_Logic of Integrated_Hardware_System is
    component Eight_Bit_Adder
        Port (A: in STD_LOGIC_VECTOR(7 downto 0);
              B: in STD_LOGIC_VECTOR(7 downto 0);
              Sum: out STD_LOGIC_VECTOR(7 downto 0);
              Cout: out STD_LOGIC);
    end component;
    
    component Multiplexer
        Port (Sel: in STD_LOGIC;
              External_Input: in STD_LOGIC_VECTOR(7 downto 0); 
              Adder_Input: in STD_LOGIC_VECTOR(7 downto 0); 
              Multiplexer_Output: out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component Eight_Bit_Register
        Port (Input: in STD_LOGIC_VECTOR(7 downto 0);
              load: in STD_LOGIC;
              clk: in STD_LOGIC;
              Output: out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component Eight_Bit_Shifter
        Port (Input_RegisterA: in STD_LOGIC_VECTOR(7 downto 0);
              Output_RegisterD: out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    signal Sum_Output: STD_LOGIC_VECTOR(7 downto 0);
    signal Multiplexer_Output: STD_LOGIC_VECTOR(7 downto 0);
    signal RegisterA_Output: STD_LOGIC_VECTOR(7 downto 0);
    signal Shifter_Output: STD_LOGIC_VECTOR(7 downto 0);
    
begin
	 Output_A <= RegisterA_Output;
	 
    ADDER: Eight_Bit_Adder 
		    port map(A => B,
                   B => C,
                   Sum => Sum_Output,
                   Cout => open);
    
    MUX: Multiplexer 
		  port map(Sel => Sel,
                 External_Input => External_Input,
                 Adder_Input => Sum_Output,
                 Multiplexer_Output => Multiplexer_Output);
    
    REGISTERA: Eight_Bit_Register 
		  port map(Input => Multiplexer_Output,
                 load => LoadA,
                 clk => clk,
                 Output => RegisterA_Output);
    
    SHIFTER: Eight_Bit_Shifter 
		  port map(Input_RegisterA => RegisterA_Output,
                 Output_RegisterD => Shifter_Output);
    
    REGISTERD: Eight_Bit_Register 
		  port map(Input => Shifter_Output,
                 load => LoadD,
                 clk => clk,
                 Output => Output_D);
end Integrated_Hardware_System_Logic;
