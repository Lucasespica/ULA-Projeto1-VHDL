library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ULA_Package.all;

--Declaração da component
entity somador4 is
    port (
        Cin    : in  std_logic;
		  A, B   : in  std_logic_vector(3 downto 0);
        Cout   : out std_logic;
        soma   : out std_logic_vector(3 downto 0);
		  Ovf    : out std_logic
    );
end somador4;

architecture Behavioral of somador4 is

	 --sinais internos
    signal c : std_logic_vector(4 downto 0); --c(4) = Cout final
	 signal S : std_logic_vector(3 downto 0);
begin

	 --Somadador de 4 bits utiliza do fulladder com o package
    adicao0: fulladd port map(Cin , A(0) , B(0) , S(0) , c(1));
    adicao1: fulladd port map(c(1) , A(1) , B(1) , S(1) , c(2));
    adicao2: fulladd port map(c(2) , A(2) , B(2) , S(2) , c(3));
    adicao3: fulladd port map(c(3) , A(3) , B(3) , S(3) , c(4));
	 
    Cout <= c(4);
    Ovf  <= ((not a(3)) and (not b(3)) and S(3)) or (a(3) and b(3) and (not S(3))); -- Na não sinalizada é igual ao cout
	 soma <= S;

end Behavioral;