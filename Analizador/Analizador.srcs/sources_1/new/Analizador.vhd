library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Analizador is
PORT(
    ED_1: in std_logic;
    ED_2: in std_logic;
    ED_3: in std_logic;
    ED_4: in std_logic;
    ED_5: in std_logic;
    CLK: in std_logic;
    subir_bajar: out std_logic_vector(1 downto 0);
    piso: out std_logic_vector(2 downto 0)
    );
end Analizador;

architecture Behavioral of Analizador is
    signal P: std_logic_vector(2 downto 0) := "000"; -- Sensor de posición del ascensor
    signal piso_1: std_logic_vector(2 downto 0);
    signal piso_2: std_logic_vector(2 downto 0);
    signal piso_3: std_logic_vector(2 downto 0);
    signal piso_4: std_logic_vector(2 downto 0);
    signal piso_5: std_logic_vector(2 downto 0);
    signal vector_almacenar: std_logic_vector(14 downto 0); -- Almacenamiento de solicitudes de piso
begin

    process (CLK, ED_1, ED_2, ED_3, ED_4, ED_5)
        variable max_dist: integer := 6;
        variable distancia: integer;
        variable piso_cercano: std_logic_vector(2 downto 0) := "000";
        variable temp_vector: std_logic_vector(14 downto 0) := (others => '0');
        variable tam: integer := 0; 
        variable contador_piso: integer := 0;
    begin
        if rising_edge(CLK) then
            -- Determinar valores para cada piso
            if ED_1 = '1' then
                piso_1 <= "001";
            else
                piso_1 <= "000";
            end if;

            if ED_2 = '1' then
                piso_2 <= "010";
            else
                piso_2 <= "000";
            end if;

            if ED_3 = '1' then
                piso_3 <= "011";
            else
                piso_3 <= "000";
            end if;

            if ED_4 = '1' then
                piso_4 <= "100";
            else
                piso_4 <= "000";
            end if;

            if ED_5 = '1' then
                piso_5 <= "101";
            else
                piso_5 <= "000";
            end if;

            -- Concatenar los valores de los pisos en el vector de almacenamiento solo si no son "000"
            tam := 0;
            contador_piso := 0;
            if piso_1 /= "000" then
                temp_vector(tam*3+2 downto tam*3) := piso_1;
                tam := tam + 1;
                contador_piso := contador_piso + 1;
            end if;
            if piso_2 /= "000" then
                temp_vector(tam*3+2 downto tam*3) := piso_2;
                tam := tam + 1;
                contador_piso := contador_piso + 1;
            end if;
            if piso_3 /= "000" then
                temp_vector(tam*3+2 downto tam*3) := piso_3;
                tam := tam + 1;
                contador_piso := contador_piso + 1;
            end if;
            if piso_4 /= "000" then
                temp_vector(tam*3+2 downto tam*3) := piso_4;
                tam := tam + 1;
                contador_piso := contador_piso + 1;
            end if;
            if piso_5 /= "000" then
                temp_vector(tam*3+2 downto tam*3) := piso_5;
                tam := tam + 1;
                contador_piso := contador_piso + 1;
            end if;

            vector_almacenar <= temp_vector;

            -- Lógica para determinar el piso más cercano
            if contador_piso = 1 then
                piso_cercano := temp_vector(2 downto 0);
                P <= piso_cercano;
                vector_almacenar(2 downto 0) <= "000"; -- Borrar el piso procesado
            elsif P = "000" then
                P <= "001";
                max_dist := 7;
                for i in 0 to tam - 1 loop
                    distancia := abs(to_integer(unsigned(temp_vector(i*3+2 downto i*3))) - to_integer(unsigned(P)));
                    if distancia < max_dist then
                        max_dist := distancia;
                        piso_cercano := temp_vector(i*3+2 downto i*3);
                    end if;
                end loop;
                P <= piso_cercano;
                for i in 0 to tam - 1 loop
                    if temp_vector(i*3+2 downto i*3) = piso_cercano then
                        temp_vector(i*3+2 downto i*3) := "000";
                    end if;
                end loop;
                vector_almacenar <= temp_vector;
            else
                max_dist := 7;
                for i in 0 to tam - 1 loop
                    distancia := abs(to_integer(unsigned(temp_vector(i*3+2 downto i*3))) - to_integer(unsigned(P)));
                    if distancia < max_dist then
                        max_dist := distancia;
                        piso_cercano := temp_vector(i*3+2 downto i*3);
                    end if;
                end loop;
                P <= piso_cercano;
                for i in 0 to tam - 1 loop
                    if temp_vector(i*3+2 downto i*3) = piso_cercano then
                        temp_vector(i*3+2 downto i*3) := "000";
                    end if;
                end loop;
                vector_almacenar <= temp_vector;
            end if;

            -- Asignar el piso más cercano a la salida
            piso <= piso_cercano;

            -- Lógica para determinar subir_bajar (2 bits)
            if piso_cercano = "000" then
                subir_bajar <= "00"; -- No hay llamada
            elsif to_integer(unsigned(piso_cercano)) < to_integer(unsigned(P)) then
                subir_bajar <= "01"; -- Llamada desde un piso inferior
            elsif to_integer(unsigned(piso_cercano)) > to_integer(unsigned(P)) then
                subir_bajar <= "10"; -- Llamada desde un piso superior
            else
                subir_bajar <= "00"; -- Reposo o sin movimiento
            end if;
        end if;
    end process;

end Behavioral;

