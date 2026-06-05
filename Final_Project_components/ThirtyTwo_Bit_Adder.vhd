library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ThirtyTwo_Bit_Adder is
	Port (A: in STD_LOGIC_VECTOR(31 downto 0);
			B: in STD_LOGIC_VECTOR(31 downto 0);
			Cin: in STD_LOGIC;
			Sum: out STD_LOGIC_VECTOR(31 downto 0);
			Cout: out STD_LOGIC);
end ThirtyTwo_Bit_Adder;

architecture ThirtyTwo_Bit_Adder_Logic of ThirtyTwo_Bit_Adder is
	
	component Eight_Bit_Adder
		Port (A: in STD_LOGIC_VECTOR(7 downto 0);
				B: in STD_LOGIC_VECTOR(7 downto 0);
				Cin: in STD_LOGIC;
				Sum: out STD_LOGIC_VECTOR(7 downto 0);
				Cout: out STD_LOGIC);
	end component;
	
	signal c1, c2, c3: STD_LOGIC;
	
begin

	Adder_0:
		Eight_Bit_Adder 
			port map(A => A(7 downto 0),
						B => B(7 downto 0),
						Cin => Cin,
						Sum => Sum(7 downto 0),
						Cout => c1);
	Adder_1:
		Eight_Bit_Adder 
			port map(A => A(15 downto 8),
						B => B(15 downto 8),
						Cin => Cin,
						Sum => Sum(15 downto 8),
						Cout => c2);
	Adder_2:
		Eight_Bit_Adder 
			port map(A => A(23 downto 16),
						B => B(23 downto 16),
						Cin => Cin,
						Sum => Sum(23 downto 16),
						Cout => c3);
	Adder_3:
		Eight_Bit_Adder 
			port map(A => A(31 downto 24),
						B => B(31 downto 24),
						Cin => Cin,
						Sum => Sum(31 downto 24),
						Cout => Cout);

end ThirtyTwo_Bit_Adder_Logic;