library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_colourless is
    Port (
        Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
        R_colourless, G_colourless, B_colourless : out STD_LOGIC_VECTOR (3 downto 0)
    );
end filter_colourless;

architecture Behavioral of filter_colourless is
    -- Colour lookup-table
    type lut_type is array (0 to 6138) of std_logic_vector(3 downto 0);
    signal lut : lut_type := (others => "0000");
begin

    filters: process(Din)
    begin
        -- Colourless video
        for i in 0 to 6138 loop
            -- Scale input to a range 0 to 15
            lut(i) <= std_logic_vector(to_unsigned(i * 15 / 6138, 4));
        end loop;

        R_colourless <= lut(to_integer(unsigned(Din)));
        G_colourless <= lut(to_integer(unsigned(Din)));
        B_colourless <= lut(to_integer(unsigned(Din)));
    end process;
end Behavioral;