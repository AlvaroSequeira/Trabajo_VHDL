----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2024 12:39:51
-- Design Name: 
-- Module Name: Piso - Behavioral
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


entity Piso is
PORT(
    displays_piso: in std_logic_vector(2 downto 0);
    CLK: in std_logic;
    piso_out: out std_logic_vector (1 downto 0)
    );
end Piso;

architecture Behavioral of Piso is

begin


end Behavioral;
