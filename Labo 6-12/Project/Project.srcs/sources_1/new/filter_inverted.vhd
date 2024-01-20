library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_inverted is
    Port (
        Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
        R_inverted, G_inverted, B_inverted : out STD_LOGIC_VECTOR (3 downto 0)
    );
end filter_inverted;

architecture Behavioral of filter_inverted is
begin

    filters: process(Din)
    begin
        -- Inverted video
        R_inverted <= not Din(11 downto 8);
        G_inverted <= not Din(7 downto 4);
        B_inverted <= not Din(3 downto 0);
    end process;
end Behavioral;
