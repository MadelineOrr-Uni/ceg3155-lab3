library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity stateComparator is
	Port (
		SSTL_max : in STD_LOGIC_VECTOR(2 downto 0);
		MSTL_max : in STD_LOGIC_VECTOR(2 downto 0);
		mstl : in STD_LOGIC_VECTOR(2 downto 0);
		sstl : in STD_LOGIC_VECTOR(2 downto 0);
		state_out : out STD_LOGIC_VECTOR(1 downto 0)
	)
end counters;


architecture rtl of counters is

begin
	if mstl = "010" and sstl = "100" then 
		state_out <= "00";
	elsif mstl = "001" and sstl = "100" then 
		state_out <= "01";
	elsif mstl = "100" and sstl = "010" then 
		state_out <= "10";
	elsif mstl = "100" and sstl = "001" then 
		state_out <= "11";
	end if;

end rtl;
