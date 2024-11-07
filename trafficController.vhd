library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trafficController is
    Port (
	sst, mt, msc, ssc : in STD_LOGIC_VECTOR(2 downto 0);
	sscs : in STD_LOGIC;
	clk : in STD_LOGIC;
	reset : in STD_LOGIC;
	mstl, sstl : out STD_LOGIC_VECTOR(2 downto 0);
	-- bcd1, bcd2 : out STD_LOGIC_VECTOR(3 downto 0)
    );
end trafficController;

architecture rtl of trafficController is

component wInput is
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
end component;

component nextStateEqn is
    Port (
        y0   : in  STD_LOGIC;
	y1   : in  STD_LOGIC;
	wInput : in STD_LOGIC;
        nextY0   : out STD_LOGIC;
	nextY1   : out STD_LOGIC
    );
end component;

component dTypeFlipFlop is
    Port (
	i_resetBar	: IN	STD_LOGIC;
	i_d		: IN	STD_LOGIC;
	i_clock		: IN	STD_LOGIC;
	i_enable	: IN	STD_LOGIC;
	o_q, o_qBar	: OUT	STD_LOGIC
    );
end component;

component oneBit2to1Mux is
    Port (
        a   : in  STD_LOGIC; 
        b   : in  STD_LOGIC; 
        sel : in  STD_LOGIC;                     
        y   : out STD_LOGIC  
    );
end component;

component threeBit4to1Mux is
    Port (
        a   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 0
        b   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 1
        c   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 2
        d   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit Input 3
        sel : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit Selector
        y   : out STD_LOGIC_VECTOR(2 downto 0)  -- 3-bit Output
    );
end component;

-- component bcd is
--     Port (
-- 	bcd1, bcd2 : in STD_LOGIC_VECTOR(3 downto 0)
--     );
-- end component;

    signal wOut : STD_LOGIC;
    signal nextStateY0 : STD_LOGIC;
    signal nextStateY1 : STD_LOGIC;
    signal internal_y0 : STD_LOGIC;
    signal internal_y1 : STD_LOGIC;
	 
    signal internal_not_y0 : STD_LOGIC;
    signal internal_not_y1 : STD_LOGIC;
    signal clk : STD_LOGIC;
    signal internal_reset : STD_LOGIC;

begin	
    internal_reset <= reset;

    w0 : wInput
    port map (
        y0 => internal_y0,
	y1 => internal_y1,
	sst => sst,
	mt => mt,
	msc => msc,
	ssc => ssc,
	sscs => sscs,
        w => wOut
    );
	 
    nextState : nextStateEqn
    port map (
        y0 => internal_y0,
	y1 => internal_y1,
	wInput => wOut,
        nextY0 => nextStateY0,
	nextY1 => nextStateY1
    );
	 
    y0_dff : dTypeFlipFlop
    port map(
	i_resetBar => internal_reset,
	i_d => nextStateY0,
	i_clock => clk,
	i_enable => '1',
	o_q => internal_y0,
	o_qBar => internal_not_y0
    );
	
    y1_dff : dTypeFlipFlop
    port map(
	i_resetBar => internal_reset,
	i_d => nextStateY1,
	i_clock => clk,
	i_enable => '1',
	o_q => internal_y1,
	o_qBar => internal_not_y1
    );
	
    sstl_outMux : threeBit4to1Mux
    port map (
        a => "100",
        b => "100",
        c => "010",
        d => "001",
        sel(0) => internal_y0,
	sel(1) => internal_y1,
        y => sstl
    );
    
    mstl_outMux : threeBit4to1Mux
    port map (
        a => "010",
        b => "001",
        c => "100",
        d => "110",
        sel(0) => internal_y0,
	sel(1) => internal_y1,
        y => mstl
    );

    
 --    bcd : bcd
 --    port map (
	-- bcd1 => ,
	-- bcd2 =>
 --    );
	 
end rtl;
