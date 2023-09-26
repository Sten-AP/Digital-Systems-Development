----------------------------------------------------------------------------------
-- Engineer: github.com/YetAnotherElectronicsChannel
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity main_pll is
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
end main_pll;

architecture Behavioral of main_pll is

signal clk : std_logic;
signal reset: std_logic := '0';

component clk_wiz_0
port(
      clk_in1: in std_logic;
      reset: in std_logic;
      clk_out1: out std_logic;
      locked: out std_logic
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
		reset <= '0';
	end if;
end process;

MCMM : clk_wiz_0
port map(
   clk_in1 => clk_100mhz,
   reset => reset,
   clk_out1 => clk,
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
