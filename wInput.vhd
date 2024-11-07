library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity wInput is
    Port (
        y0   : in  STD_LOGIC;
		  y1   : in  STD_LOGIC;
		  sst : in STD_LOGIC_VECTOR(2 downto 0);
		  mt : in STD_LOGIC_VECTOR(2 downto 0);
		  msc : in STD_LOGIC_VECTOR(2 downto 0);
		  ssc : in STD_LOGIC_VECTOR(2 downto 0);
		  sscs : in STD_LOGIC;
        w   : out STD_LOGIC
    );
end wInput;
architecture rtl of wInput is
begin
    w <= '1' when (msc = "000" and y1 = '0'and y0 = '0' and sscs = '1') else 
         '1' when (mt = "000" and y1 = '0' and y0 = '1') else 
			'1' when (ssc = "000" and y1 = '1' and y0 = '0') else 
			'1' when (sst = "000" and y1 = '1' and y0 = '1' ) else '0';
end rtl;
