library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counterController is
	Port (
		MSC_ISP, SST_ISP : in STD_LOGIC_VECTOR(2 downto 0); -- Switches
		clk : in STD_LOGIC;
		MSC, MT, SSC, SST : out STD_LOGIC_VECTOR(2 downto 0)
	);
end counterController;


architecture rtl of counterController is

component stateComparator is
	Port (
		mstl, sstl, msc_max, ssc_max : in STD_LOGIC_VECTOR(2 downto 0);
		state_out : out STD_LOGIC_VECTOR(1 downto 0)
	);
end component;

component counter3Bit is
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		enable : in STD_LOGIC;
		count : out STD_LOGIC_VECTOR(2 downto 0)
	);
end component;

signal o_state : STD_LOGIC_VECTOR(1 downto 0);
signal state1  : STD_LOGIC_VECTOR(1 downto 0);
signal state2 : STD_LOGIC_VECTOR(1 downto 0);
signal state3 : STD_LOGIC_VECTOR(1 downto 0);
signal state4 : STD_LOGIC_VECTOR(1 downto 0);

begin

	comp1 : stateComparator
	Port map (
		mstl => MSTL,
		sstl => SSTL,
		state_out => o_state
	);

	mstl_counter : counter3Bit
	Port map (
		reset => state1,
		enable => state1,
		clk => clk,
		count => MSTL
	);

	ss_counter : counter3Bit
	Port map (
		reset => state2,
		enable => state2,
		clk => clk,
		count => MTSS
	);

	mt_counter : counter3Bit
	Port map (
		reset => state3,
		enable => state3,
		clk => clk,
		count => MTSS
	);
	
	sstl_counter : counter3Bit
	Port map (
		reset => state4,
		enable => state4,
		clk => clk,
		count => SSTL
	);

	if o_state = "00" then 
		state1 := '1';
		state2 := '0';
		state3 := '0';
		state4 := '0';
	elsif o_state = "01" then
		state1 := '0';
		state2 := '1';
		state3 := '0';
		state4 := '0';
	elsif o_state = "10" then
		state1 := '0';
		state2 := '0';
		state3 := '1';
		state4 := '0';
	elsif o_state = "11" then
		state1 := '0';
		state2 := '0';
		state3 := '0';
		state4 := '1';
	else 
		state1 := '0';
		state2 := '0';
		state3 := '0';
		state4 := '0';
	end if;




end rtl;
