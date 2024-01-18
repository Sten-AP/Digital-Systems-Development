library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_b_and_w is
    Port ( 
    		switch : in STD_LOGIC;
            Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_b_and_w, G_b_and_w, B_b_and_w : out	STD_LOGIC_VECTOR (7 downto 0)
          );
end filter_b_and_w;

architecture Behavioral of filter_b_and_w is
begin

filters: process(Din, Nblank)
begin
    if Nblank = '1' then
        if switch = '1' then
            -- Black and white video
            if (Din(11 downto 0) > 2047) then
                R_b_and_w <= "11111111";
                G_b_and_w <= "11111111";
                B_b_and_w <= "11111111";
            else
                R_b_and_w <= std_logic_vector(to_unsigned((to_integer(unsigned(Din(11 downto 8))) + to_integer(unsigned(Din(7 downto 4))) + to_integer(unsigned(Din(3 downto 0)))) / 3, 8));
                G_b_and_w <= std_logic_vector(to_unsigned((to_integer(unsigned(Din(11 downto 8))) + to_integer(unsigned(Din(7 downto 4))) + to_integer(unsigned(Din(3 downto 0)))) / 3, 8));
                B_b_and_w <= std_logic_vector(to_unsigned((to_integer(unsigned(Din(11 downto 8))) + to_integer(unsigned(Din(7 downto 4))) + to_integer(unsigned(Din(3 downto 0)))) / 3, 8));
            end if;
        end if;
    end if;
end process;
end Behavioral;
