library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ULA_Package.all;

--Component do multiplicador
entity multiplicador2x2 is
    port (
        A, B : in  std_logic_vector(1 downto 0);
        P : out std_logic_vector(3 downto 0)
    );
end multiplicador2x2;

architecture logica of multiplicador2x2 is

	 --sinais internos
    signal and0, and1, and2, and3 : std_logic;
    signal sum1, cout1, cout2 : std_logic;

begin

    -- Produtos parciais
    and0 <= A(0) and B(0); -- bit 0
    and1 <= A(1) and B(0);
    and2 <= A(0) and B(1);
    and3 <= A(1) and B(1);

    -- Soma parcial 1: and1 + and2
    FA1: fulladd port map('0', and1, and2, P(1), cout1);

    -- Soma final: and3 + carry anterior
    FA2: fulladd port map('0', and3, cout1, P(2), cout2);

    -- Resultado final
    P(0) <= and0;
    P(3) <= cout2;

end logica;