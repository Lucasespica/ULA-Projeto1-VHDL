library ieee;
use ieee.std_logic_1164.all;

package ULA_Package is
	 
	 -- Somador completo
	 component fulladd
		port ( Cin, x, y : IN STD_LOGIC ;
				 s, Cout : OUT STD_LOGIC ) ;
	 end component;
	 
    -- Somador de 4 bits com carry e overflow
    component somador4
        port (
				 Cin    : in  std_logic;
				 A, B   : in  std_logic_vector(3 downto 0);
				 Cout   : out std_logic;
				 soma   : out std_logic_vector(3 downto 0);
				 Ovf    : out std_logic
    );
    end component;

    -- Multiplicador de 2 bits por 2 bits
    component multiplicador2x2
        port (
            A, B : in std_logic_vector(1 downto 0);
            P    : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Comparador de 4 bits
    component comparador4bits
        port (
            A, B : in std_logic_vector(3 downto 0);
            Equ, Grt, Lst : out std_logic
        );
    end component;

end ULA_Package;