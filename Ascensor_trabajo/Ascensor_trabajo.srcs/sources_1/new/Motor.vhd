library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Motor is
    PORT(
        situacion_motor: in std_logic_vector(1 downto 0);
        CLK: in std_logic;
        act_motor: out std_logic_vector(1 downto 0)
    );
end Motor;

architecture Behavioral of Motor is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            act_motor <= situacion_motor; 
        end if;
    end process;
end Behavioral;

