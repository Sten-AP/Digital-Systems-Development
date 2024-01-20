library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity video_compression is
    Port (
        comp_in   : in STD_LOGIC_VECTOR (11 downto 0);
        comp_out  : out STD_LOGIC_VECTOR (11 downto 0)
    );
end entity video_compression;

architecture Behavioral of video_compression is
begin
    process (comp_in)
    begin
        -- Replace this with your actual compression algorithm
        -- This example averages the values of adjacent pixels

        comp_out(11 downto 8) <= std_logic_vector(to_unsigned((to_integer(unsigned(comp_in(11 downto 8))) + to_integer(unsigned(comp_in(7 downto 4)))) / 2, 4));
        comp_out(7 downto 4) <= std_logic_vector(to_unsigned((to_integer(unsigned(comp_in(7 downto 4))) + to_integer(unsigned(comp_in(3 downto 0)))) / 2, 4));
        comp_out(3 downto 0) <= std_logic_vector(to_unsigned((to_integer(unsigned(comp_in(3 downto 0))) + to_integer(unsigned(comp_in(11 downto 8)))) / 2, 4));


    end process;
end Behavioral;
