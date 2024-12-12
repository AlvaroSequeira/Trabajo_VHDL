----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2024 12:24:08
-- Design Name: 
-- Module Name: FSM - Behavioral
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



entity FSM is
PORT(
    temp_out: in std_logic;
    sensor_pos: in std_logic;
    sensor_puertas: in std_logic;
    EMER: in std_logic;
    piso: in std_logic_vector(2 downto 0);
    CLK: in std_logic;
    abrir_cerrar: out std_logic;
    situacion_motor: out std_logic_vector(1 downto 0);
    puertas_in: out std_logic;
    displays_piso: out std_logic_vector(2 downto 0)
    );
end FSM;

architecture Behavioral of FSM is

begin


end Behavioral;
