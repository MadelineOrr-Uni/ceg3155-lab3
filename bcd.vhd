library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd is
	i_num1 : in STD_LOGIC_VECTOR(3 downto 0);
	i_num2 : in STD_LOGIC_VECTOR(3 downto 0);
end bcd;


architecture rtl of bcd is

begin
	sevenSeg0 : dec_7seg
	port map (
		i_hexDigit => i_num1; 		
		o_segment_a => ,
		o_segment_b => , 
		o_segment_c => , 
		o_segment_d => , 
		o_segment_e => , 
		o_segment_f => ,
		o_segment_g => 
	);

	sevenSeg1 : dec_7seg
	port map (
		i_hexDigit => i_num2;
		o_segment_a => ,
		o_segment_b => , 
		o_segment_c => , 
		o_segment_d => , 
		o_segment_e => , 
		o_segment_f => ,
		o_segment_g => 
	);
end rtl;
