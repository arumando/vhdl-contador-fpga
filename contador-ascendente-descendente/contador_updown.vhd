library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contadorde is
Port ( 
    clk: in  std_logic;
    reset: in  std_logic;
    hold: in  std_logic;
    load: in std_logic;
    updown: in std_logic;
    dato: out std_logic_vector (3 downto 0);
    datoload: in std_logic_vector(7 downto 0);
    datoSeg: out std_logic_vector(6 downto 0);
    controlSeg: out std_logic_vector(7 downto 0)
);
end contadorde;

architecture Behavioral of contadorde is
    signal contador: integer range 0 to 100000000 := 0;
    signal contadorms: integer range 0 to 10000 := 0;

    signal clk1s, clkms: std_logic;
  
    signal divdisp,divdato : std_logic := '0';
    

    signal contup1, contup2 ,datomuxup: std_logic_vector(3 downto 0) := "0000";
    signal contdown1, contdown2 ,datomuxdown: std_logic_vector(3 downto 0) := "0000";
    signal datomuxout: std_logic_vector(3 downto 0) := "0000";
   
begin

--divior de frecuencia para controla la sal de 1 seg y 10khz
contador<=contador + 1 when falling_edge(clk) else contador;
clk1s <= '1' when contador = 99999999 else '0';

contadorms<=contadorms + 1 when falling_edge(clk) else contadorms;
clkms <= '1' when contadorms = 9999 else '0';

--señal para controlar la frecuencia de operación del encendido de los displays
divdisp<=not divdisp when falling_edge(clk) and clkms='1';

--Contro de ensendido de los displays unidades y decenas
controlSeg <= "11111110" when divdisp = '1' else "11111101";


--control del contador ascendente

process(clk)
begin
    if falling_edge(clk) then
        if updown='0' then
            contup1<=contdown1;
            contup2<=contdown2;        
        elsif reset = '1' then
            contup1   <= (others => '0');
            contup2 <= (others => '0');
        elsif load='1' then
            contup1   <= datoload(3 downto 0);
            contup2   <= datoload(7 downto 4);
        elsif clk1s = '1' and hold = '0' then
            if contup1 = "1001" and contup2="1001" then
                contup1 <= "0000";
                contup2 <= "0000";            
            elsif contup1 = "1001" then
                contup1 <= "0000";
                contup2 <= std_logic_vector(unsigned(contup2) + 1);
            else
                contup1 <= std_logic_vector(unsigned(contup1) + 1);
            end if;
        end if;
    end if;
end process;


--control del contador descendente

process(clk)
begin
    if falling_edge(clk) then
        if updown='1' then
            contdown1<=contup1;
            contdown2<=contup2;
        elsif reset = '1' then
            contdown1   <= (others => '0');
            contdown2 <= (others => '0');
        elsif load='1' then
            contdown1   <= datoload(3 downto 0);
            contdown2   <= datoload(7 downto 4);            
        elsif clk1s = '1' and hold = '0' then
            if contdown1 = "0000" and contdown2="0000" then
                contdown1 <= "1001";
                contdown2 <= "1001";            
            elsif contdown1 = "0000" then
                contdown1 <= "1001";
                contdown2 <= std_logic_vector(unsigned(contdown2) - 1);
            else
                contdown1 <= std_logic_vector(unsigned(contdown1) - 1);
            end if;
        end if;
    end if;
end process;



--control para desplegar el dato correcto



datomuxup <= contup1 when divdisp='1' else contup2;
datomuxdown <= contdown1 when divdisp='1' else contdown2;

datomuxout<= datomuxup when updown='1' else datomuxdown;


dato<=datomuxout;


--Decodificador de dato de salida
datoSeg <= "1000000" when datomuxout = "0000" else
         "1111001" when datomuxout = "0001" else
         "0100100" when datomuxout = "0010" else
         "0110000" when datomuxout = "0011" else
         "0011001" when datomuxout = "0100" else
         "0010010" when datomuxout = "0101" else
         "0000010" when datomuxout = "0110" else
         "1111000" when datomuxout = "0111" else
         "0000000" when datomuxout = "1000" else
         "0010000" when datomuxout = "1001" else
         "0001000" when datomuxout = "1010" else
         "0000011" when datomuxout = "1011" else
         "1000110" when datomuxout = "1100" else
         "0100001" when datomuxout = "1101" else
         "0000110" when datomuxout = "1110" else
         "0001110";

end Behavioral;