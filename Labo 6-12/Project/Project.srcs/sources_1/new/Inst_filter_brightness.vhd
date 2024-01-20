library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity filter_brightness is
    Port (
        Din      : in STD_LOGIC_VECTOR (11 downto 0);
        Dout     : out STD_LOGIC_VECTOR (11 downto 0);
        BrightnessLevel: in integer range 0 to 255
    );
end filter_brightness;

architecture Behavioral of filter_brightness is
    signal R, G, B   : unsigned(3 downto 0);
    signal Temp_R     : unsigned(7 downto 0);
    signal Temp_G     : unsigned(7 downto 0);
    signal Temp_B     : unsigned(7 downto 0);
begin

    process (Din, BrightnessLevel)
    begin
        Temp_R <= unsigned(Din(11 downto 8)) + to_unsigned(BrightnessLevel, 8);
        Temp_G <= unsigned(Din(7 downto 4))  + to_unsigned(BrightnessLevel, 8);
        Temp_B <= unsigned(Din(3 downto 0))  + to_unsigned(BrightnessLevel, 8);

        R <= resize(Temp_R, 4);
        G <= resize(Temp_G, 4);
        B <= resize(Temp_B, 4);

        Dout <= std_logic_vector(R & G & B);
    end process;
end Behavioral;
