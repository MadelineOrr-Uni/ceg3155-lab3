library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity threeBit4to1Mux is
    Port (
        a   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 0
        b   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 1
        c   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 2
        d   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 3
        sel : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit Selector
        y   : out STD_LOGIC_VECTOR(2 downto 0)  -- 3-bit Output
    );
end threeBit4to1Mux;
architecture Behavioral of threeBit4to1Mux is
begin
    process(a, b, c, d, sel)
    begin
        case sel is
            when "00" =>
                y <= a;                             -- Select input a
            when "01" =>
                y <= b;                             -- Select input b
            when "10" =>
                y <= c;                             -- Select input c
            when "11" =>
                y <= d;                             -- Select input d
            when others =>
                y <= (others => '0');              -- Default case (if needed)
        end case;
    end process;
end Behavioral;
