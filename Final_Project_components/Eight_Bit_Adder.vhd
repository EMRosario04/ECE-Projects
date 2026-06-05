library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Eight_Bit_Adder is
    Port (A: in STD_LOGIC_VECTOR(7 downto 0);
          B: in STD_LOGIC_VECTOR(7 downto 0);
			 Cin: in STD_LOGIC;
          Sum: out STD_LOGIC_VECTOR(7 downto 0);
          Cout: out STD_LOGIC);
end Eight_Bit_Adder;

architecture Eight_Bit_Adder_Logic of Eight_Bit_Adder is
    component FullAdder
        Port(A: in STD_LOGIC;
             B: in STD_LOGIC;
             Cin: in STD_LOGIC;
             Sum: out STD_LOGIC;
             Cout: out STD_LOGIC);
    end component;
    
    signal Carry_Out: STD_LOGIC_VECTOR(8 downto 0);
    
begin
	Carry_Out(0) <= Cin;
	
	FullAdder_Bits: for i in 0 to 7 generate
		Adder: FullAdder port map(A => A(i),
										  B => B(i),
										  Cin => Carry_Out(i),
										  Sum => Sum(i),
										  Cout => Carry_Out(i+1));
	end generate;
	Cout <= Carry_Out(8);
end Eight_Bit_Adder_Logic;
