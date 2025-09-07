library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Package da ULA
library work;
use work.ULA_Package.all;

entity ProjetoULA is
    port (
        SW   : in  std_logic_vector(10 downto 0); -- Switches
        HEX0 : out std_logic_vector(0 to 6);  -- ALUOp
        HEX2 : out std_logic_vector(0 to 6);  -- b
        HEX4 : out std_logic_vector(0 to 6);  -- a
        HEX6 : out std_logic_vector(0 to 6);  -- result
        LEDR : out std_logic_vector(5 downto 0)   -- LDR0 a LDR5
    );
end ProjetoULA;

architecture estrutura of ProjetoULA is

	 --Definição dos sinais internos	 
    signal a, b, result : std_logic_vector(3 downto 0);
    signal ALUOp        : std_logic_vector(2 downto 0);
    signal zero, overflow, carryOut, Equ, Grt, Lst : std_logic;

    signal soma, sub, and_out, or_out, not_out, mul_out : std_logic_vector(3 downto 0);
    signal c_out_soma, c_out_sub : std_logic;
    signal ovf_soma, ovf_sub : std_logic;
    signal eq_s, grt_s, lst_s : std_logic;

    -- Conversor para display de 7 segmentos
    function to_hex7seg(input : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable seg : std_logic_vector(6 downto 0);
    begin
        case input is
            when "0000" => seg := "0000001"; -- 0
            when "0001" => seg := "1001111"; -- 1
            when "0010" => seg := "0010010"; -- 2
            when "0011" => seg := "0000110"; -- 3
            when "0100" => seg := "1001100"; -- 4
            when "0101" => seg := "0100100"; -- 5
            when "0110" => seg := "0100000"; -- 6
            when "0111" => seg := "0001111"; -- 7
            when "1000" => seg := "0000000"; -- 8
            when "1001" => seg := "0000100"; -- 9
            when "1010" => seg := "0001000"; -- A
            when "1011" => seg := "1100000"; -- b
            when "1100" => seg := "0110001"; -- C
            when "1101" => seg := "1000010"; -- d
            when "1110" => seg := "0110000"; -- E
            when "1111" => seg := "0111000"; -- F
            when others => seg := "1111111";
        end case;
        return seg;
    end function;

begin

    -- Entrada dos switches
    a     <= SW(10 downto 7);
    b     <= SW(6 downto 3);
    ALUOp <= SW(2 downto 0);

    -- SOMA
    soma_inst : somador4 port map('0', a (3 downto 0), b (3 downto 0), c_out_soma, soma, ovf_soma);

    -- SUBTRAÇÃO
    sub_inst : somador4 port map('1', a (3 downto 0), not b (3 downto 0), c_out_sub, sub, ovf_sub);

    -- MULTIPLICAÇÃO
    mult_inst : multiplicador2x2 port map(a(1 downto 0), b(1 downto 0), mul_out);

    -- COMPARADOR
    comp_inst : comparador4bits port map(a, b, eq_s, grt_s, lst_s);

    -- Operações lógicas
    and_out <= a and b;
    or_out  <= a or b;
    not_out <= not b;

    -- Seletor da operação
    with ALUOp select
        result <=
            (others => '0')     when "000",  -- Nada
            and_out             when "001",
            or_out              when "010",
            not_out             when "011",
            soma                when "100",
            sub                 when "101",
            mul_out             when "110",
            (others => '0')     when others;

    -- Sinais auxiliares
    zero     <= '1' when result = "0000" else '0';
    overflow <= ovf_soma when ALUOp = "100" else ovf_sub when ALUOp = "101" else '0';
    carryOut <= c_out_soma when ALUOp = "100" else c_out_sub when ALUOp = "101" else '0';

    Equ <= eq_s when ALUOp = "111" else '0';
    Grt <= grt_s when ALUOp = "111" else '0';
    Lst <= lst_s when ALUOp = "111" else '0';

    -- Displays de 7 segmentos, Mostrar o numero ou letra na tela
    HEX0 <= to_hex7seg("0" & ALUOp);
    HEX2 <= to_hex7seg(b);
    HEX4 <= to_hex7seg(a);
    HEX6 <= to_hex7seg(result);

    -- LEDs de status
    LEDR(0) <= carryOut;
    LEDR(1) <= zero;
    LEDR(2) <= overflow;
    LEDR(3) <= Equ;
    LEDR(4) <= Grt;
    LEDR(5) <= Lst;

end estrutura;
