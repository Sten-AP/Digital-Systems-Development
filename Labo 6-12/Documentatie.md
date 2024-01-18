# Project DSD

Hulsbergen Sten  - 3ITIOT

## Ontwikkelingsplan

1. Bestuderen van de code op FPGA4Student.
2. Verbinden van de camera en het VGA-scherm met de FPGA.
3. Code instellen op FPGA om camera te testen en beelden te tonen via VGA.
4. Uitzoeken wat voor filters er gebruikt gaan worden.
   - Geinverteerd
   - Zwart en wit
   - Kleurloos (grijswaarden)
5. Ontwikkelen van de filters in vhdl en toevoegen aan bestaande code.
6. Video-compressieblok toevoegen aan de code.
7. Testen van het project.
8. Rapport over de resultaten en de leerpunten maken.
9. Presentatie voorbereiden.

## Testplan

1. Test de functionaliteit van de video-opname- en weergavefuncties.
2. Test de effecten van de filters op de video.
3. Test van het video-compressieblok.
4. Valideer de resultaten van het projectrapport.

## Filters

### Geinverteerd

De kleuren inverteren is niet moeilijk, hierbij moest alleen `not` geplaatst worden voor de kleuren om te draaien. Hierbij heb ik extra lijnen geplaatst waarbij de kleuren geschaald worden naar 255. Dit is als volgt:

```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_inverted is
    Port ( 
    		switch : in STD_LOGIC;
            Din : in STD_LOGIC_VECTOR (11 downto 0);
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
```

### Zwart en wit

Dit is wat moeilijker, met een korte berekening kom je uit op alleen wit en zwart waardes, waardoor deze alleen overblijven. Dit is als volgt:

```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_b_and_w is
    Port ( 
    		switch : in STD_LOGIC;
            Din : in STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_b_and_w, G_b_and_w, B_b_and_w : out STD_LOGIC_VECTOR (7 downto 0)
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
```

### Kleurloos

Om de kleuren weg te laten en gebruik te maken van grijswaardes was het moeilijkst. Hierbij heb ik grondig gebruik gemaakt van bepaalde bronnen. Dit is als volgt:

```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity filter_colourless is
    Port ( 
    		switch : in STD_LOGIC;
            Din : in STD_LOGIC_VECTOR (11 downto 0);
		    Nblank : in	STD_LOGIC;
            R_colourless, G_colourless, B_colourless : out STD_LOGIC_VECTOR (7 downto 0)
          );
end filter_colourless;

architecture Behavioral of filter_colourless is
    type lut_type is array (0 to 4095) of std_logic_vector(7 downto 0);
    signal lut : lut_type := (others => "00000000");
begin
    
filters: process(Din, Nblank)
begin
    if Nblank = '1' then
        if switch = '1' then
            -- Colourless video
            for i in 0 to 4095 loop
                lut(i) <= std_logic_vector(to_unsigned(i, 8));
            end loop;
          
            R_colourless <= lut(to_integer(unsigned(Din)));
            G_colourless <= lut(to_integer(unsigned(Din)));
            B_colourless <= lut(to_integer(unsigned(Din)));
        end if;
    end if;
end process;
end Behavioral;
```

## Datasheets

[OV7670 Camera](https://www.voti.nl/docs/OV7670.pdf)

## Bronnen

[FPGA4Student: videobeelden via VGA](https://www.fpga4student.com/2018/08/basys-3-fpga-ov7670-camera.html)</br>
[Startingelectronics: inverteerde kleuren filter](https://startingelectronics.com/software/VHDL-CPLD-course/tut1-inverter-buffer/)</br>
[Electronics-stackexchange: zwart en wit filter](https://electronics.stackexchange.com/questions/481870/how-to-implement-vga-controller-for-changing-background-color-in-vhdl)</br>
[Support-xilinx: kleurloos filter](https://support.xilinx.com/s/question/0D52E00006iHtaVSAS/lens-distortion-correction-in-fpga-how-to-get-started-vhdl-vivado?language=zh_CN)</br>
[Esd-cs: kleurloos filter](http://esd.cs.ucr.edu/labs/tutorial/)</br>
