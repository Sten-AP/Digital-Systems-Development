library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity RGB is
    Port (
		    filter_switch_inverted : in STD_LOGIC;
            filter_switch_b_and_w : in STD_LOGIC;
            filter_switch_colourless : in STD_LOGIC;
            compression_switch : in std_logic;

            Din : in STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_out, G_out, B_out : out STD_LOGIC_VECTOR (7 downto 0));
end RGB;

architecture Behavioral of RGB is

    signal R_inverted, G_inverted, B_inverted : STD_LOGIC_VECTOR (7 downto 0);
    signal R_b_and_w, G_b_and_w, B_b_and_w : STD_LOGIC_VECTOR (7 downto 0);
    signal R_colourless, G_colourless, B_colourless : STD_LOGIC_VECTOR (7 downto 0);

	COMPONENT filter_inverted
	PORT(
    		switch : in STD_LOGIC;
            Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_inverted, G_inverted, B_inverted : out	STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;

	COMPONENT filter_b_and_w
	PORT(
    		switch : in STD_LOGIC;
            Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_b_and_w, G_b_and_w, B_b_and_w : out	STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT filter_colourless
	PORT(
    		switch : in STD_LOGIC;
            Din 	: in	STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_colourless, G_colourless, B_colourless : out	STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;

begin

	Inst_filter_inverted: filter_inverted PORT MAP(
		switch => filter_switch_inverted,
        Din => Din,
        Nblank => Nblank,
		R_inverted => R_inverted,
		G_inverted => G_inverted,
		B_inverted => B_inverted
	);

	Inst_filter_b_and_w: filter_b_and_w PORT MAP(
		switch => filter_switch_b_and_w,
        Din => Din,
        Nblank => Nblank,
		R_b_and_w => R_b_and_w,
		G_b_and_w => G_b_and_w,
		B_b_and_w => B_b_and_w
	);
	
	Inst_filter_colourless: filter_colourless PORT MAP(
		switch => filter_switch_colourless,
        Din => Din,
        Nblank => Nblank,
		R_colourless => R_colourless,
		G_colourless => G_colourless,
		B_colourless => B_colourless
	);


filters: process(filter_switch_inverted, filter_switch_b_and_w, filter_switch_colourless)
begin
    if Nblank = '1' then
        if filter_switch_inverted = '1' then
            R_out <= R_inverted;
            G_out <= G_inverted;
            B_out <= B_inverted;
        elsif filter_switch_b_and_w = '1' then
            R_out <= R_b_and_w;
            G_out <= G_b_and_w;
            B_out <= B_b_and_w;
        elsif filter_switch_colourless = '1' then
            R_out <= R_colourless;
            G_out <= G_colourless;
            B_out <= B_colourless;
        else
            -- Normale video
--            R_out <=  Din(11 downto 8) & Din(11 downto 8);
--            G_out <= Din(7 downto 4) & Din(7 downto 4);
--            B_out <= Din(3 downto 0) & Din(3 downto 0);

            -- Normale video met aangepaste schalingsfactor voor een meer gebalanceerde kleurweergave
            R_out <= std_logic_vector(resize(to_signed(to_integer(unsigned(Din(11 downto 8))) * 17, 8), 8));
            G_out <= std_logic_vector(resize(to_signed(to_integer(unsigned(Din(7 downto 4))) * 17, 8), 8));
            B_out <= std_logic_vector(resize(to_signed(to_integer(unsigned(Din(3 downto 0))) * 17, 8), 8));
        end if;
    else
        R_out <= "00000000";
        G_out <= "00000000";
        B_out <= "00000000";
    end if;
end process;
end Behavioral;

