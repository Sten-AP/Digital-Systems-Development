library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity video_compression is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        input_pixel : in STD_LOGIC;
        compression_switch : in STD_LOGIC;
        compressed_data : out STD_LOGIC_VECTOR (11 downto 0)
    );
end video_compression;

architecture Behavioral of video_compression is
    signal count : integer := 0;
    signal prev_pixel : STD_LOGIC := '0';
    signal compressed_value : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
    signal compression_ratio : integer := 256;  -- Default is 0% compression (1.0 * 256)

    constant COMPRESSION_RATIO_50 : integer := 128;  -- 50% compression (0.5 * 256)

begin

    process(clk, reset)
    begin
        if reset = '1' then
            count <= 0;
            prev_pixel <= '0';
            compressed_value <= (others => '0');
            compression_ratio <= 256;
        elsif rising_edge(clk) then
            if input_pixel = prev_pixel then
                count <= count + 1;
            else
                compressed_value <= std_logic_vector(to_unsigned(count, 12));
                count <= 1;
            end if;
            prev_pixel <= input_pixel;
        end if;
    end process;

    process(compression_switch)
    begin
        if compression_switch = '1' then
            compression_ratio <= COMPRESSION_RATIO_50;  -- 50% compression
        else
            compression_ratio <= 256;  -- 0% compression
        end if;
    end process;

    compressed_data <= std_logic_vector(to_unsigned(to_integer(unsigned(compressed_value)) * compression_ratio, 12));

end Behavioral;
