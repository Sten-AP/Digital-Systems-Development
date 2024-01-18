library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_colourless is
    Port ( 
    		switch : in STD_LOGIC;
            Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_colourless, G_colourless, B_colourless : out STD_LOGIC_VECTOR (7 downto 0)
          );
end filter_colourless;

architecture Behavioral of filter_colourless is
    type lut_type is array (0 to 4095) of std_logic_vector(7 downto 0);
    signal lut : lut_type := (others => "00000000");
begin
    
filters: process(Din, Nblank)
begin
    if Nblank = '1' then
        if switch = '1' then
            -- Collorless video
            for i in 0 to 4095 loop
                lut(i) <= std_logic_vector(to_unsigned(i, 8));
            end loop;
          
            R_colourless <= lut(to_integer(unsigned(Din)));
            G_colourless <= lut(to_integer(unsigned(Din)));
            B_colourless <= lut(to_integer(unsigned(Din)));
        end if;
    end if;
end process;
end Behavioral;