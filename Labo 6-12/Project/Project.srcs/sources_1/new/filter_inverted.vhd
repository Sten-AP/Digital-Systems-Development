library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_inverted is
    Port ( 
    		switch : in STD_LOGIC;
            Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_inverted, G_inverted, B_inverted : out STD_LOGIC_VECTOR (7 downto 0)
          );
end filter_inverted;

architecture Behavioral of filter_inverted is
begin

filters: process(Din, Nblank)
begin
    if Nblank = '1' then
        if switch = '1' then
            -- Geinverteerde video
--            R_inverted <= not Din(11 downto 8) & Din(11 downto 8);
--            G_inverted <= not Din(7 downto 4)  & Din(7 downto 4);
--            B_inverted <= not Din(3 downto 0)  & Din(3 downto 0);
            
            -- Geinverteerde video met aangepaste schalingsfactor voor een meer gebalanceerde kleurweergave
            R_inverted <= not std_logic_vector(resize(to_signed(to_integer(unsigned(Din(11 downto 8))) * 17, 8), 8));
            G_inverted <= not std_logic_vector(resize(to_signed(to_integer(unsigned(Din(7 downto 4))) * 17, 8), 8));
            B_inverted <= not std_logic_vector(resize(to_signed(to_integer(unsigned(Din(3 downto 0))) * 17, 8), 8));
        end if;
    end if;
end process;
end Behavioral;
