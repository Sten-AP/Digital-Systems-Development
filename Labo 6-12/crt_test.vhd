-- Monitor display test
-- Generates horiz and vert sync pulses for 1024x768 resolution

-- The color of the screen is set by user inputs from the dip switch
-- and the pushbuttons. Each of the 3 pushbuttons corresponds to
-- either red, blue or green. Pushing one of these buttons will set the
-- respective color to the 8-bit value on the dip switches.

-- To change the resolution change the constants for the resolution, and the
-- sync and porch times below. Also change the lpm altclk clock multiplier/divider.

library ieee;
use  ieee.std_logic_1164.all;
use  ieee.std_logic_arith.all;
use  ieee.std_logic_unsigned.all;

entity crt_test is
	port(	signal clk,
				   reset: in std_logic;
			signal set_color: in std_logic_vector(7 downto 0);
			signal red,
			       green,
			       blue: out std_logic_vector(7 downto 0);
			signal goRed,
				   goBlue,
				   goGreen: std_logic;
			signal Hsync,
				   Vsync: out std_logic;
			signal blank: out std_logic;
			signal clockout: out std_logic
	);
end crt_test;

architecture mixed of crt_test is
	signal clock: std_logic;
	signal h,
		   v: std_logic_vector(7 downto 0);

	constant h_res: integer:= 1024;
	constant v_res: integer:= 768;

	constant h_front_porch: integer := 56;
	constane h_sync_time : integer := 104;
	constant h_back_porch: integer := 160;
	constant v_front_porch: integer := 1;
	constane v_sync_time : integer := 3;
	constant v_back_porch: integer := 24;

	
	constant h_sync_start: integer:= h_res + h_front_porch;
	constant h_sync_end: integer:= h_sync_start + h_sync_time;
	constant max_h: integer:= h_sync_end + h_back_porch;

	constant v_sync_start: integer:= v_res + v_front_porch;
	constant v_sync_end: integer:= v_sync_start + v_sync_time;
	constant max_v: integer:= v_sync_end + v_back_porch;

COMPONENT clklock
	GENERIC (INPUT_FREQUENCY: POSITIVE;
		CLOCKBOOST: POSITIVE);
	PORT (inclk: IN STD_LOGIC;
		outclk: OUT STD_LOGIC);
END COMPONENT;

COMPONENT registerN
    generic(N : positive := 4);
    port (	Input   : in std_logic_vector(N-1 downto 0);
          	Load  	: in std_logic;
	  		Reset	: in std_logic;
          	Output  : out std_logic_vector(N-1 downto 0));
END COMPONENT;

	
begin

clockout <= clock;

doubleclock: clklock
	generic map (
		INPUT_FREQUENCY => 33,
		CLOCKBOOST => 2
		)
	port map (
		inclk => clk,
		outclk => clock
		);

red_reg: registerN
	generic map(
		N => 8
		)
	port map(
		Input => set_color,
		Load => goRed,
		Reset => reset,
		Output => red
		);
		
green_reg: registerN
	generic map(
		N => 8
		)
	port map(
		Input => set_color,
		Load => goGreen,
		Reset => reset,
		Output => green
		);

blue_reg: registerN
	generic map(
		N => 8
		)
	port map(
		Input => set_color,
		Load => goBlue,
		Reset => reset,
		Output => blue
		);


sync_count: process(clock,reset)
begin
	if rising_edge(clock) then
		h <= h + '1';

		if h > max_h then
			h <= (others => '0');
			v <= v + '1';

			if v > max_v then
				v <= (others => '0');
			end if;
		end if;

		if (h > h_sync_start) and (h < h_sync_end) then
			Hsync <= '1';
		else
			Hsync <= '0';
		end if;

		if (v > v_sync_start) and (v < v_sync_end) then
			Vsync <= '1';
		else
			Vsync <= '0';
		end if;
	end if;
end process sync_count;

-- On our VDAC, asserting blank low, automatically set all color lines to 0
-- If your VDAC does not have a blank signal, then simply set all the colors
-- to 0 whenever blank = 0 in our code.
on_off: process(clock)
begin
	if rising_edge(clock) then

		if (h >= h_res) or (v >= v_res) then
			blank <= '0';
		else
			blank <= '1';
		end if;
	end if;
end process on_off;


end mixed;