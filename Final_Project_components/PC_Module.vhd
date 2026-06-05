library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_Module is
	Port (Next_PC: in STD_LOGIC_VECTOR(31 downto 0);
			clk: in STD_LOGIC;
			reset: in STD_LOGIC;
			Current_PC: out STD_LOGIC_VECTOR(31 downto 0));
end PC_Module;

architecture PC_Logic of PC_Module is
begin

	process(clk, reset)
	begin
		
		if reset = '1' then
			Current_PC <= (others => '0');	
		
		elsif rising_edge(clk) then
			Current_PC <= Next_PC;
		
		end if;
	
	end process;
	
end PC_Logic;
		
		
	