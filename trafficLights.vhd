library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trafficLights is
	global_reset : in STD_LOGIC;
	clk : in STD_LOGIC;
	SSCS : in STD_LOGIC;
	MSC_ISP, SSC_ISP : in STD_LOGIC_VECTOR(2 downto 0);
	MSTL, SSTL : out STD_LOGIC_VECTOR(2 downto 0)
end trafficLights;

architecture rtl of trafficLights is
-- Components
component debouncer_2 is
	Port (	
		i_resetBar : in STD_LOGIC;
		i_clock : in STD_LOGIC;
		i_raw : in STD_LOGIC;
		o_clean : out STD_LOGIC;
	);
end component;

component trafficController is
	Port (
		sst, mt, msc, ssc : in STD_LOGIC_VECTOR(2 downto 0);
		sscs : in STD_LOGIC;
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		mstl, sstl : out STD_LOGIC_VECTOR(2 downto 0);
		bcd1, bcd2 : out STD_LOGIC_VECTOR(3 downto 0)
	);
end component;

component clk_div is
    Port (	
	clock_25Mhz : in STD_LOGIC;
	clock_1Hz : out STD_LOGIC
    );
end component;

component counterController is
	Port (
		MSC_ISP, SST_ISP : in STD_LOGIC_VECTOR(2 downto 0); -- Switches
		MSTL, SSTL : in STD_LOGIC_VECTOR(2 downto 0);
		clk : in STD_LOGIC;
		MSC, MT_SSC, SST : out STD_LOGIC_VECTOR(2 downto 0)

	);
end component;

-- Signals
	-- Internal/Processed Signals
	signal internal_clk : STD_LOGIC;

	-- Switch Signals
	signal ic_msc_isp : STD_LOGIC_VECTOR(2 downto 0);
	signal ic_ssc_isp : STD_LOGIC_VECTOR(2 downto 0);
	signal ic_sscs : STD_LOGIC_VECTOR(2 downto 0);

	-- Counter signals
	signal i_msc : STD_LOGIC_VECTOR(2 downto 0);
	signal i_mt_ssc : STD_LOGIC_VECTOR(2 downto 0);
	signal i_sst : STD_LOGIC_VECTOR(2 downto 0);
begin

	clkDiv : clk_div
	port map (
		clock_25Mhz => clk; -- TODO: Replace 25MHz clock with board clock
		clock_1Hz => internal_clk;
	);


	-- Switches 1-3
	debncr1_1 : debouncer_2
	port map (
		i_resetBar => global_reset,
		i_clock => internal_clk,
		i_raw => MSC_ISP(0),
		o_clean => ic_msc_isp(0)
	);

	debncr1_2 : debouncer_2
	port map (
		i_resetBar => global_reset,
		i_clock => internal_clk,
		i_raw => MSC_ISP(1),
		o_clean => ic_msc_isp(1)
	);

	debncr1_3 : debouncer_2
	port map (
		i_resetBar => global_reset,
		i_clock => internal_clk,
		i_raw => MSC_ISP(2),
		o_clean => ic_msc_isp(2)
	);

	-- Switches 4-6
	debncr2_1 : debouncer_2
	port map (
		i_resetBar => global_reset,
		i_clock => internal_clk,
		i_raw => SSC_ISP(0),
		o_clean => ic_ssc_isp(0)
	);

	debncr2_2 : debouncer_2
	port map (
		i_resetBar => global_reset,
		i_clock => internal_clk,
		i_raw => SSC_ISP(1),
		o_clean => ic_ssc_isp(1)
	);

	debncr2_3 : debouncer_2
	port map (
		i_resetBar => global_reset,
		i_clock => internal_clk,
		i_raw => SSC_ISP(2),
		o_clean => ic_ssc_isp(2)
	);

	debncrSSCS : debouncer_2
	port map (
		i_resetBar => global_reset,
		i_clock => internal_clk,
		i_raw => SSCS,
		o_clean => ic_sscs
	);


	counters : counterController
	port map (
		MSC_ISP	=> ic_msc_isp,
		SSC_ISP => ic_ssc_isp,
		clk => internal_clk,
		MSC => i_msc,
		MT_SSC => i_mt_ssc,
		SST => i_sst
	);

	trafficCtrl : trafficController
	port map (
		clk => internal_clk,
		reset => global_reset,
		msc => i_msc,
		ssc => i_mt_ssc,
		mt => i_mt_ssc,
		sst => i_sst,
		sscs => ic_sscs,
		mstl => MSTL,
		sstl => SSTL
		-- bcd1 => ,
		-- bcd2 => 
	);
	

	
end rtl;
