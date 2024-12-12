library ieee;
use ieee.std_logic_1164.all;

entity tb_Analizador is
end tb_Analizador;

architecture tb of tb_Analizador is

    component Analizador
        port (
            ED_1        : in std_logic;
            ED_2        : in std_logic;
            ED_3        : in std_logic;
            ED_4        : in std_logic;
            ED_5        : in std_logic;
            CLK         : in std_logic;
            subir_bajar : out std_logic;
            piso        : out std_logic_vector(2 downto 0)
        );
    end component;

    signal ED_1        : std_logic := '0';
    signal ED_2        : std_logic := '0';
    signal ED_3        : std_logic := '0';
    signal ED_4        : std_logic := '0';
    signal ED_5        : std_logic := '0';
    signal CLK         : std_logic := '0';
    signal subir_bajar : std_logic;
    signal piso        : std_logic_vector(2 downto 0);

    constant TbPeriod : time := 100 ns; -- Periodo del reloj de simulación
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Analizador
    port map (
        ED_1        => ED_1,
        ED_2        => ED_2,
        ED_3        => ED_3,
        ED_4        => ED_4,
        ED_5        => ED_5,
        CLK         => CLK,
        subir_bajar => subir_bajar,
        piso        => piso
    );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- CLK es el reloj principal
    CLK <= TbClock;

    stimuli : process
    begin
        -- Caso 1: ED_1 = 1, otros = 0
        wait for 100 ns;
        ED_1 <= '1';

        -- Caso 2: ED_2 = 1, otros = 0
        wait for 100 ns;
        ED_1 <= '0';
        ED_2 <= '1';

        -- Caso 3: ED_3 = 1, otros = 0
        wait for 100 ns;
        ED_2 <= '0';
        ED_1 <= '1';

        -- Caso 4: ED_4 = 1, otros = 0
        wait for 100 ns;
        ED_3 <= '0';
        ED_4 <= '1';

        -- Caso 5: ED_5 = 1, otros = 0
        wait for 100 ns;
        ED_4 <= '0';
        ED_5 <= '1';

        -- Detener la simulación
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
