library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_multiplier  is
	Port (Multiplier_A: in STD_LOGIC_VECTOR (3 downto 0);
			Multiplier_B: in STD_LOGIC_VECTOR (3 downto 0);
			Multiplier_Output: out STD_LOGIC_VECTOR (7 downto 0));
end array_multiplier;

architecture array_multiplier_logic of array_multiplier is
	
	component FUllAdder is
		Port (A: in STD_LOGIC;
				B: in STD_LOGIC;
				Cin: in STD_LOGIC;
				Sum: out STD_LOGIC;
				Cout: out STD_LOGIC);
	end component;
	
	signal ab0, ab1, ab2, ab3: STD_LOGIC_VECTOR (3 downto 0);
	signal sum1, sum2, sum3: STD_LOGIC_VECTOR (3 downto 0);
	signal c1, c2, c3: STD_LOGIC_VECTOR (3 downto 0);

begin

	ab0(0) <= Multiplier_A(0) and Multiplier_B(0);
	ab0(1) <= Multiplier_A(1) and Multiplier_B(0);
	ab0(2) <= Multiplier_A(2) and Multiplier_B(0);
	ab0(3) <= Multiplier_A(3) and Multiplier_B(0);
	
	ab1(0) <= Multiplier_A(0) and Multiplier_B(1);
	ab1(1) <= Multiplier_A(1) and Multiplier_B(1);
	ab1(2) <= Multiplier_A(2) and Multiplier_B(1);
	ab1(3) <= Multiplier_A(3) and Multiplier_B(1);
	
	ab2(0) <= Multiplier_A(0) and Multiplier_B(2);
	ab2(1) <= Multiplier_A(1) and Multiplier_B(2);
	ab2(2) <= Multiplier_A(2) and Multiplier_B(2);
	ab2(3) <= Multiplier_A(3) and Multiplier_B(2);
	
	ab3(0) <= Multiplier_A(0) and Multiplier_B(3);
	ab3(1) <= Multiplier_A(1) and Multiplier_B(3);
	ab3(2) <= Multiplier_A(2) and Multiplier_B(3);
	ab3(3) <= Multiplier_A(3) and Multiplier_B(3);
	
	Multiplier_Output(0) <= Multiplier_A(0) and Multiplier_B(0);
	
	FA1_1: FullAdder 
		port map(A => ab0(1), B => ab1(0), Sum => Multiplier_Output(1), Cin => '0', Cout => c1(0));
	
	FA1_2: FullAdder
		port map(A => ab0(2), B => ab1(1), Sum => sum1(1), Cin => c1(0), Cout => c1(1));
		
	FA1_3: FullAdder
		port map(A => ab0(3), B => ab1(2), Sum => sum1(2), Cin => c1(1), Cout => c1(2));
		
	FA1_4: FullAdder
		port map(A => '0', B => ab1(3), Sum => sum1(3), Cin => c1(2), Cout => c1(3));
		
	FA2_1: FullAdder 
		port map(A => sum1(1), B => ab2(0), Sum => Multiplier_Output(2) , Cin => '0', Cout => c2(0));
	
	FA2_2: FullAdder
		port map(A => sum1(2), B => ab2(1), Sum => sum2(1), Cin => c2(0), Cout => c2(1));
		
	FA2_3: FullAdder
		port map(A => sum1(3), B => ab2(2), Sum => sum2(2), Cin => c2(1), Cout => c2(2));
		
	FA2_4: FullAdder
		port map(A => c1(3), B => ab2(3), Sum => sum2(3), Cin => c2(2), Cout => c2(3));
		
	FA3_1: FullAdder 
		port map(A => sum2(1), B => ab3(0), Sum => Multiplier_Output(3) , Cin => '0', Cout => c3(0));
	
	FA3_2: FullAdder
		port map(A => sum2(2), B => ab3(1), Sum => Multiplier_Output(4) , Cin => c3(0), Cout => c3(1));
		
	FA3_3: FullAdder
		port map(A => sum2(3), B => ab3(2), Sum => Multiplier_Output(5) , Cin => c3(1), Cout => c3(2));
		
	FA3_4: FullAdder
		port map(A => c2(3), B => ab3(3), Sum => Multiplier_Output(6), Cin => c3(2), Cout => c3(3));

end array_multiplier_logic;



	
			
	