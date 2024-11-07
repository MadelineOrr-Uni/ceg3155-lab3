library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter3Bit is
	Port ( 
		clk   : in STD_LOGIC;
		reset : in STD_LOGIC;
		enable : in STD_LOGIC;
		max : in STD_LOGIC_VECTOR(2 downto 0);
		count : out STD_LOGIC_VECTOR(2 downto 0)
	);
end counter3Bit;

architecture rtl of counter3Bit is
    signal counter_reg : STD_LOGIC_VECTOR(2 downto 0);
begin

	process(clk, reset)
	begin
		if rising_edge(reset) then
			counter_reg <= max;
		end if;
		if rising_edge(clk) then
			if enable = '1' then
				counter_reg <= counter_reg - 1;
			end if;
		end if;
	end process;

	count <= counter_reg;

end rtl;

