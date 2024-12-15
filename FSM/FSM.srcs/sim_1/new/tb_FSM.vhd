library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_FSM is
end tb_FSM;

architecture tb of tb_FSM is

    -- Componente FSM a probar
    component FSM
        port (
            temp_out        : in std_logic;
            sensor_pos      : in std_logic;
            sensor_puertas  : in std_logic;
            EMER            : in std_logic;
            piso            : in std_logic_vector (2 downto 0);
            CLK             : in std_logic;
            subir_bajar     : in std_logic_vector (1 downto 0);
            abrir_cerrar    : out std_logic;
            situacion_motor : out std_logic_vector (1 downto 0);
            puertas_in      : out std_logic;
            displays_piso   : out std_logic_vector (2 downto 0)
        );
    end component;

    -- Señales internas
    signal temp_out        : std_logic := '1';
    signal sensor_pos      : std_logic := '1';
    signal sensor_puertas  : std_logic := '1';
    signal EMER            : std_logic := '0';
    signal piso            : std_logic_vector (2 downto 0) := "001";
    signal CLK             : std_logic := '0';
    signal subir_bajar     : std_logic_vector (1 downto 0) := "00";
    signal abrir_cerrar    : std_logic;
    signal situacion_motor : std_logic_vector (1 downto 0);
    signal puertas_in      : std_logic;
    signal displays_piso   : std_logic_vector (2 downto 0);

    -- Constantes y variables auxiliares
    constant TbPeriod : time := 1000 ns; -- Periodo del reloj
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    -- Instancia de la FSM
    dut : FSM
        port map (
            temp_out        => temp_out,
            sensor_pos      => sensor_pos,
            sensor_puertas  => sensor_puertas,
            EMER            => EMER,
            piso            => piso,
            CLK             => CLK,
            subir_bajar     => subir_bajar,
            abrir_cerrar    => abrir_cerrar,
            situacion_motor => situacion_motor,
            puertas_in      => puertas_in,
            displays_piso   => displays_piso
        );

    -- Generador de reloj
    TbClock <= not TbClock after TbPeriod / 2 when TbSimEnded /= '1' else '0';
    CLK <= TbClock;

    -- Proceso de estímulos
    stimuli : process
    begin
        -- Estado inicial (REPOSO)
        temp_out <= '1';
        sensor_pos <= '1';
        sensor_puertas <= '1';
        EMER <= '0';
        piso <= "001"; -- Piso 1
        subir_bajar <= "00"; -- Reposo
        wait for 5 * TbPeriod;

        -- Subir al piso 2
        temp_out <= '1';
        sensor_pos <= '0'; -- Motor en movimiento
        sensor_puertas <= '1';
        piso <= "010"; -- Piso 2
        subir_bajar <= "10"; -- Subir
        wait for 10 * TbPeriod;

        -- Llegar al piso 2
        temp_out <= '1';
        sensor_pos <= '1'; -- Motor detenido
        sensor_puertas <= '1';
        subir_bajar <= "00"; -- Reposo
        wait for 5 * TbPeriod;

        -- Bajar al piso 1
        temp_out <= '1';
        sensor_pos <= '0'; -- Motor en movimiento
        sensor_puertas <= '1';
        piso <= "001"; -- Piso 1
        subir_bajar <= "01"; -- Bajar
        wait for 10 * TbPeriod;

        -- Llegar al piso 1
        temp_out <= '1';
        sensor_pos <= '1'; -- Motor detenido
        sensor_puertas <= '1';
        subir_bajar <= "00"; -- Reposo
        wait for 5 * TbPeriod;

        -- Subir al piso 4
        temp_out <= '1';
        sensor_pos <= '0'; -- Motor en movimiento
        sensor_puertas <= '1';
        piso <= "100"; -- Piso 4
        subir_bajar <= "10"; -- Subir
        wait for 15 * TbPeriod;

        -- Llegar al piso 4
        temp_out <= '1';
        sensor_pos <= '1'; -- Motor detenido
        sensor_puertas <= '1';
        subir_bajar <= "00"; -- Reposo
        wait for 10 * TbPeriod;

        -- Activar emergencia
        EMER <= '1';
        wait for 5 * TbPeriod;

        -- Finalizar simulación
        TbSimEnded <= '1';
        wait;
    end process;

end tb;


