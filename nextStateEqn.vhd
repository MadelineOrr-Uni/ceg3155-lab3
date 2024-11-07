library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity nextStateEqn is
    Port (
        y0   : in  STD_LOGIC;
		  y1   : in  STD_LOGIC;
		  wInput : in STD_LOGIC;
        nextY0   : out STD_LOGIC;
		  nextY1   : out STD_LOGIC
    );
end nextStateEqn;
architecture rtl of nextStateEqn is
begin
	nextY0 <= (wInput and not y0) or (not wInput and y0);
	nextY1 <= (wInput and not y1 and y0) or (not wInput and y1) or (y1 and not y0);
	
end rtl;
