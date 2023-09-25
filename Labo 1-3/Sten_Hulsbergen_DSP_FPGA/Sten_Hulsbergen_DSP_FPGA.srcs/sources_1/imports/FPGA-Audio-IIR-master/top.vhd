----------------------------------------------------------------------------------
-- Engineer: github.com/YetAnotherElectronicsChannel
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity main is
    port (
    clk_100mhz : in std_logic;
	
    i2s_mclk_adc : out std_logic;
    i2s_bclk_adc : out std_logic;
    i2s_lr_adc : out std_logic;
    i2s_din : in std_logic;
	
    i2s_mclk_dac : out std_logic;
    i2s_bclk_dac : out std_logic;
    i2s_lr_dac : out std_logic;
	i2s_dout : out std_logic
    );

    

end main;

architecture Behavioral of main is

signal clk : std_logic;
signal reset: std_logic := '0';

--component main_pll is
--port(
--      REFERENCECLK: in std_logic;
--      RESET: in std_logic;
--      PLLOUTCORE: out std_logic;
--      PLLOUTGLOBAL: out std_logic;
--      LOCK: out std_logic
--    );
--end component;

component MMCM
port (
    clk_out1        : out   std_logic;
    reset           : in    std_logic;
    locked          : out   std_logic;
    clk_in1         : in    std_logic
);
end component;


component audiosystem is 
port(
    clk  : in std_logic;    
	
    i2s_mclk_adc : out std_logic;
    i2s_bclk_adc : out std_logic;
    i2s_lr_adc : out std_logic;
    i2s_din : in std_logic;
	
    i2s_mclk_dac : out std_logic;
    i2s_bclk_dac : out std_logic;
    i2s_lr_dac : out std_logic;
	i2s_dout : out std_logic
        
  
    );
end component;

begin

-- generatore low-to-high transition for PLL reset input
process (clk_100mhz)
begin
	if (rising_edge(clk_100mhz)) then
		reset <= '1';
	end if;
end process;



--pll:    main_pll
--port map(

--   REFERENCECLK => clk_100mhz,
--      RESET => reset,
--      PLLOUTCORE => open,
--      PLLOUTGLOBAL => clk,
--      LOCK=> open
--);

pll:    MMCM
port map(

    clk_in1 => clk_100mhz ,
    clk_out1 => clk,
    reset => reset,
    locked => open
);

audiomodule : audiosystem
port map (
    clk => clk,
    i2s_mclk_adc => i2s_mclk_adc,
    i2s_bclk_adc => i2s_bclk_adc,
    i2s_lr_adc => i2s_lr_adc,
    i2s_din => i2s_din,    
    i2s_mclk_dac => i2s_mclk_dac,
    i2s_bclk_dac => i2s_bclk_dac,
    i2s_lr_dac => i2s_lr_dac,
    i2s_dout => i2s_dout   
    );
    

end Behavioral;
