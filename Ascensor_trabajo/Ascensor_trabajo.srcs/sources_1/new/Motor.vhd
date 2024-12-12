----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2024 12:39:39
-- Design Name: 
-- Module Name: Motor - Behavioral
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


entity Motor is
PORT(
    situacion_motor: in std_logic_vector (1 downto 0);
    CLK: in std_logic;
    act_motor: out std_logic_vector (1 downto 0)
    );
    
end Motor;

architecture Behavioral of Motor is

begin


end Behavioral;
