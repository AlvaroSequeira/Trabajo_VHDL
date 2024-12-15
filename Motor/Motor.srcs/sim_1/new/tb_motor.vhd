library ieee;
use ieee.std_logic_1164.all;

entity tb_Motor is
end tb_Motor;

architecture tb of tb_Motor is

    component Motor
        port (situacion_motor : in std_logic_vector (1 downto 0);
              CLK             : in std_logic;
              act_motor       : out std_logic_vector (1 downto 0));
    end component;

    signal situacion_motor : std_logic_vector (1 downto 0);
    signal CLK             : std_logic;
    signal act_motor       : std_logic_vector (1 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Motor
    port map (situacion_motor => situacion_motor,
              CLK             => CLK,
              act_motor       => act_motor);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        situacion_motor <= "00";
        

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
         situacion_motor <= "01";
        

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
         situacion_motor <= "10";
        

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;
         situacion_motor <= "11";
        

        -- EDIT Add stimuli here
        wait for 5 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Motor of tb_Motor is
    for tb
    end for;
end cfg_tb_Motor;