library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Puertas is
    PORT(
        puertas: in std_logic;  
        CLK: in std_logic;       
        accion: out std_logic    
    );
end Puertas;

architecture Behavioral of Puertas is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            accion <= puertas; 
        end if;
    end process;
end Behavioral;
