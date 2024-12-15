----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2024 11:48:36
-- Design Name: 
-- Module Name: Gestor_ascensor - Behavioral
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

entity Gestor_ascensor is
PORT(
    CLK: in std_logic;
    EMER:in std_logic;
    ED_1: in std_logic;
    ED_2: in std_logic;
    ED_3: in std_logic;
    ED_4: in std_logic;
    ED_5: in std_logic;
    sensor_pos: in std_logic;
    sensor_puertas: in std_logic;
    situacion_motor: out std_logic_vector (1 downto 0);
    puertas: out std_logic;
    displays_piso: out std_logic_vector(2 downto 0)
    );
end Gestor_ascensor;

architecture Behavioral of Gestor_ascensor is
signal abrir_cerrar : std_logic;
signal temp_out : std_logic;
signal subir_bajar: std_logic;
signal piso: std_logic_vector( 2 downto 0);

COMPONENT Analizador
PORT(
    ED_1: in std_logic;
    ED_2: in std_logic;
    ED_3: in std_logic;
    ED_4: in std_logic;
    ED_5: in std_logic;
    subir_bajar: out std_logic;
    piso: out std_logic_vector(2 downto 0)
);
END COMPONENT;
COMPONENT Temporizador
PORT(
    abrir_cerrar: in std_logic;
    CLK: in std_logic;
    temp_out: out std_logic
);
END COMPONENT;
COMPONENT FSM
PORT(
    temp_out: in std_logic;
    sensor_pos: in std_logic;
    sensor_puertas: in std_logic;
    EMER: in std_logic;
    piso: in std_logic_vector(2 downto 0);
    CLK: in std_logic;
    subir_bajar: in std_logic;
    abrir_cerrar: out std_logic;
    situacion_motor: out std_logic_vector(1 downto 0);
    puertas: out std_logic;
    displays_piso: out std_logic_vector(2 downto 0)
);
END COMPONENT;
begin

Inst_Analizador: Analizador 
PORT MAP(
    ED_1 => ED_1,
    ED_2 => ED_2,
    ED_3 => ED_3,
    ED_4 => ED_4,
    ED_5 => ED_5,
    subir_bajar => subir_bajar,
    piso => piso
    
);
Inst_Temporizador: Temporizador 
PORT MAP(
    CLK => CLK,
    abrir_cerrar => abrir_cerrar,
    temp_out => temp_out
);
Inst_FSM: FSM 
PORT MAP(
    piso => piso,
    sensor_pos => sensor_pos,
    sensor_puertas => sensor_puertas,
    subir_bajar => subir_bajar,
    EMER => EMER,
    CLK => CLK,
    temp_out => temp_out,
    situacion_motor => situacion_motor,
    puertas => puertas,
    displays_piso => displays_piso
);
end Behavioral;
