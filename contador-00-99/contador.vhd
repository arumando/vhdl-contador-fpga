library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Contador is
Port ( 
    clk : in std_logic;
    dato : out std_logic_vector (3 downto 0);
    datoSeg : out std_logic_vector(6 downto 0);
    reset : in std_logic;
hold  : in std_logic;

    controlSeg : out std_logic_vector(7 downto 0)
);
end Contador;


architecture Behavioral of Contador is
    signal contador : integer range 0 to 100000000:=0;
    signal contadorms : integer range 0 to 1000:=0;
    signal contmax : std_logic;
    signal clk1s : std_logic;
    signal clkms : std_logic;
    signal com : std_logic:='0';
    signal deco1 : std_logic_vector(6 downto 0);
    signal deco2 : std_logic_vector(6 downto 0);
    signal countup,contador2 : std_logic_vector(3 downto 0) := "0000";
begin

    contador <= contador+1 when falling_edge(clk) else 
                contador;
    contadorms <= contadorms+1 when falling_edge(clk) else 
                contadorms;
    clk1s <= '1' when contador = 99999999 else '0';
    clkms <= '1' when contadorms = 999 else '0';
    
process(clk)
begin
if falling_edge(clk) then

    if reset='1' then
        countup   <= "0000";
        contador2 <= "0000";

    elsif hold='0' then

        if clk1s='1' then

            if countup="1001" then
                countup <= "0000";
            else
                countup <= std_logic_vector(unsigned(countup)+1);
            end if;

            if contmax='1' then
                if contador2="1001" then
                    contador2 <= "0000";
                else
                    contador2 <= std_logic_vector(unsigned(contador2)+1);
                end if;
            end if;

        end if;

    end if;

end if;
end process;


                 
    contmax <= countup(3) and (not countup(2)) and (not countup(1)) and countup(0);
      
    dato <= countup;
    
    com <= not com when falling_edge(clk) and clkms = '1';
    
    datoSeg <= deco1 when com = '1' else
               deco2;
    
    deco1 <= "1000000" when countup = "0000" else-- 0
           "1111001" when countup = "0001" else -- 1
           "0100100" when countup = "0010" else-- 2
           "0110000" when countup = "0011" else-- 3
           "0011001" when countup = "0100" else-- 4
           "0010010" when countup = "0101" else-- 5
           "0000010" when countup = "0110" else-- 6
           "1111000" when countup = "0111" else -- 7
           "0000000" when countup = "1000" else-- 8
           "0010000" when countup = "1001";-- F
           
     deco2 <= "1000000" when contador2 = "0000" else-- 0
           "1111001" when contador2 = "0001" else -- 1
           "0100100" when contador2 = "0010" else-- 2
           "0110000" when contador2 = "0011" else-- 3
           "0011001" when contador2 = "0100" else-- 4
           "0010010" when contador2 = "0101" else-- 5
           "0000010" when contador2 = "0110" else-- 6
           "1111000" when contador2 = "0111" else -- 7
           "0000000" when contador2 = "1000" else-- 8
           "0010000" when contador2 = "1001";
           
     controlSeg <= "11111110" when com = '1' else
                   "11111101";
           
           
    
    
end Behavioral;