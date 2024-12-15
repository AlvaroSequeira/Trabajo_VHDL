library ieee;
use ieee.std_logic_1164.all;

entity tb_Piso is
end tb_Piso;

architecture tb of tb_Piso is

    component Piso
        port (displays_piso : in std_logic_vector (2 downto 0);
              CLK           : in std_logic;
              piso_out      : out std_logic_vector (2 downto 0));
    end component;

    signal displays_piso : std_logic_vector (2 downto 0);
    signal CLK           : std_logic;
    signal piso_out      : std_logic_vector (2 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Piso
    port map (displays_piso => displays_piso,
              CLK           => CLK,
              piso_out      => piso_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        displays_piso <= "001";

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
        displays_piso <= "010";

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
        displays_piso <= "011";

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
        displays_piso <= "100";

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
        displays_piso <= "101";

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Piso of tb_Piso is
    for tb
    end for;
end cfg_tb_Piso;