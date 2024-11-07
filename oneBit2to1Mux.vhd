library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity oneBit2to1Mux is
    Port (
        a   : in  STD_LOGIC; -- 4-bit Input 0
        b   : in  STD_LOGIC; -- 4-bit Input 1
        sel : in  STD_LOGIC;                     -- Selector
        y   : out STD_LOGIC  -- 4-bit Output
    );
end oneBit2to1Mux;

architecture Behavioral of oneBit2to1Mux is
begin
    process(a, b, sel)
    begin
        if sel = '0' then
            y <= a;                               -- Select input a
        else
            y <= b;                               -- Select input b
        end if;
    end process;
end Behavioral;
