library ieee;
use ieee.std_logic_1164.all;

entity tb_Analizador is
end tb_Analizador;

architecture tb of tb_Analizador is

    component Analizador
        port (
            ED_1 : in std_logic;
            ED_2 : in std_logic;
            ED_3 : in std_logic;
            ED_4 : in std_logic;
            ED_5 : in std_logic;
            CLK  : in std_logic;
            piso : out std_logic_vector (2 downto 0)
        );
    end component;

    signal ED_1 : std_logic := '0';
    signal ED_2 : std_logic := '0';
    signal ED_3 : std_logic := '0';
    signal ED_4 : std_logic := '0';
    signal ED_5 : std_logic := '0';
    signal CLK  : std_logic := '0';
    signal piso : std_logic_vector (2 downto 0) := (others => '0'); -- Señal inicializada

    constant TbPeriod : time := 100 ns; -- Periodo del reloj

begin

    -- Instancia del DUT (Device Under Test)
    dut : Analizador
        port map (
            ED_1 => ED_1,
            ED_2 => ED_2,
            ED_3 => ED_3,
            ED_4 => ED_4,
            ED_5 => ED_5,
            CLK  => CLK,
            piso => piso
        );

    -- Generador del reloj
    clock_process : process
    begin
        while true loop
            CLK <= '0';
            wait for TbPeriod / 2;
            CLK <= '1';
            wait for TbPeriod / 2;
        end loop;
    end process;

    -- Proceso de estimulación
    stimuli : process
    begin
        -- Ciclo inicial
        wait for 2 * TbPeriod;

        -- Activar ED_1, ED_2, ED_3, ED_4 y ED_5 simultáneamente
        ED_1 <= '1';
        ED_2 <= '1';
        ED_3 <= '1';
        ED_4 <= '1';
        ED_5 <= '1';
        wait for 2 * TbPeriod;

        -- Desactivar todas las señales simultáneamente
        ED_1 <= '0';
        ED_2 <= '0';
        ED_3 <= '0';
        ED_4 <= '0';
        ED_5 <= '0';
        wait for 2 * TbPeriod;

        -- Activar algunas combinaciones de señales

        ED_2 <= '1';
        ED_5 <= '1';
        wait for 2 * TbPeriod;
        ED_2 <= '0';
        ED_5 <= '0';
        
        ED_3 <= '1';
        ED_4 <= '1';
        wait for 2 * TbPeriod;
        ED_3 <= '0';
        ED_4 <= '0';

        -- Finalizar la simulación
        wait for 5 * TbPeriod;
        assert false report "Simulation complete" severity note;
        wait;
    end process;

end tb;