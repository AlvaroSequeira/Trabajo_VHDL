library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Temporizador is
    PORT(
        abrir_cerrar: in std_logic;
        CLK: in std_logic;
        temp_out: out std_logic
    );
end Temporizador;

architecture Behavioral of Temporizador is

    signal contador: unsigned(1 downto 0) := (others => '0'); -- Contador para medir 3 ciclos
    signal temp_signal: std_logic := '0'; -- Señal interna para temp_out

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if abrir_cerrar = '1' then
                if contador < 3 then
                    contador <= contador + 1;
                else
                    temp_signal <= '1'; -- Activar salida después de 3 ciclos
                end if;
            else
                contador <= (others => '0'); -- Reiniciar contador si abrir_cerrar es '0'
                temp_signal <= '0'; -- Reiniciar salida
            end if;
        end if;
    end process;

    temp_out <= temp_signal; -- Asignar señal interna a la salida

end Behavioral;