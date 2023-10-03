----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 11:12:20 AM
-- Design Name: 
-- Module Name: volume_control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity volume_control is
    Port (
           clk: in std_logic;
           din : in std_logic;
           dout : out std_logic
           );
end volume_control;

architecture Behavioral of volume_control is

signal volume : STD_LOGIC := din;
signal volume_up : STD_LOGIC;
signal volume_down : STD_LOGIC;

begin



process (volume_down, volume_up)
begin

    if (rising_edge(clk) and rising_edge(volume_up)) then
        volume <= volume;
    end if;

    if (rising_edge(clk) and rising_edge(volume_down)) then
        volume <= volume;
    end if;
    
    dout <= volume;

end process;





end Behavioral;
