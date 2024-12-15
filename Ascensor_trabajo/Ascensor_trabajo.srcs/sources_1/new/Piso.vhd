library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Piso is
    PORT(
        displays_piso: in std_logic_vector(2 downto 0); 
        CLK: in std_logic;                             
        piso_out: out std_logic_vector(2 downto 0)    
    );
end Piso;

architecture Behavioral of Piso is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            piso_out <= displays_piso; 
        end if;
    end process;
end Behavioral;

