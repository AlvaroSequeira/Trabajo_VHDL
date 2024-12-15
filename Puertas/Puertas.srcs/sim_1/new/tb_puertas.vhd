library ieee;
use ieee.std_logic_1164.all;

entity tb_Puertas is
end tb_Puertas;

architecture tb of tb_Puertas is

    component Puertas
        port (puertas : in std_logic;
              CLK     : in std_logic;
              accion  : out std_logic);
    end component;

    signal tb_puertas : std_logic; -- Cambio de nombre de 'puertas' a 'tb_puertas'
    signal CLK        : std_logic;
    signal accion     : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock    : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Puertas
    port map (puertas => tb_puertas, -- Usar la nueva señal tb_puertas
              CLK     => CLK,
              accion  => accion);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        tb_puertas <= '0';

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
        tb_puertas <= '1';

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
        tb_puertas <= '0';

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Puertas of tb_Puertas is
    for tb
    end for;
end cfg_tb_Puertas;
