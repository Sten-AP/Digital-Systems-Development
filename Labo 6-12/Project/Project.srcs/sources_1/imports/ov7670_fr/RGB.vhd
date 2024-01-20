library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity RGB is
    Port (
        filter_switch_inverted : in STD_LOGIC;
        filter_switch_b_and_w : in STD_LOGIC;
        filter_switch_colourless : in STD_LOGIC;
        filter_switch_brightness: in std_logic;
        compression_switch : in std_logic;
        
        Din : in STD_LOGIC_VECTOR (11 downto 0);
        Nblank : in	STD_LOGIC;
        R_out, G_out, B_out : out STD_LOGIC_VECTOR (3 downto 0));
end RGB;

architecture Behavioral of RGB is
    signal Dout : STD_LOGIC_VECTOR (11 downto 0);
    signal Dout_compressed : STD_LOGIC_VECTOR (11 downto 0);
    signal Dout_brightened : STD_LOGIC_VECTOR (11 downto 0);

    signal R_inverted, G_inverted, B_inverted : STD_LOGIC_VECTOR (3 downto 0);
    signal R_b_and_w, G_b_and_w, B_b_and_w : STD_LOGIC_VECTOR (3 downto 0);
    signal R_colourless, G_colourless, B_colourless : STD_LOGIC_VECTOR (3 downto 0);

    COMPONENT video_compression
        PORT (
            comp_in   : in STD_LOGIC_VECTOR (11 downto 0);
            comp_out  : out STD_LOGIC_VECTOR (11 downto 0)
        );
    END COMPONENT;

    COMPONENT filter_brightness
        PORT (
            Din      : in STD_LOGIC_VECTOR (11 downto 0);
            Dout     : out STD_LOGIC_VECTOR (11 downto 0);
            BrightnessLevel: in integer range 0 to 255
        );
    END COMPONENT;

    COMPONENT filter_inverted
        PORT(
            Din : in STD_LOGIC_VECTOR (11 downto 0);
            R_inverted, G_inverted, B_inverted : out STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT;

    COMPONENT filter_b_and_w
        PORT(
            Din : in STD_LOGIC_VECTOR (11 downto 0);
            R_b_and_w, G_b_and_w, B_b_and_w : out STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT;

    COMPONENT filter_colourless
        PORT(
            Din : in STD_LOGIC_VECTOR (11 downto 0);
            R_colourless, G_colourless, B_colourless : out STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT;

begin

    Inst_video_compression: video_compression  PORT MAP(
            comp_in => Din,
            comp_out => Dout_compressed
        );

    Inst_filter_inverted: filter_inverted PORT MAP(
            Din => Dout,
            R_inverted => R_inverted,
            G_inverted => G_inverted,
            B_inverted => B_inverted
        );

    Inst_filter_b_and_w: filter_b_and_w PORT MAP(
            Din => Dout,
            R_b_and_w => R_b_and_w,
            G_b_and_w => G_b_and_w,
            B_b_and_w => B_b_and_w
        );

    Inst_filter_colourless: filter_colourless PORT MAP(
            Din => Dout,
            R_colourless => R_colourless,
            G_colourless => G_colourless,
            B_colourless => B_colourless
        );

    Inst_brightness_filter: filter_brightness PORT MAP(
        Din => Dout,
        Dout => Dout_brightened,
        BrightnessLevel => 50
    );

    filters: process(filter_switch_inverted, filter_switch_b_and_w, filter_switch_colourless, Dout, Dout_compressed, Din)
    begin
        if Nblank = '1' then
            if compression_switch = '1' then
                Dout <= Dout_compressed;
            elsif filter_switch_brightness = '1' then
                Dout <= Dout_brightened;
            else
                Dout <= Din;
            end if;

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
                -- Normal video
                R_out <= Dout(11 downto 8);
                G_out <= Dout(7 downto 4);
                B_out <= Dout(3 downto 0);
            end if;
        else
            R_out <= "0000";
            G_out <= "0000";
            B_out <= "0000";
        end if;
    end process;
end Behavioral;

