library IEEE;
use IEEE.STD_LOGIC_1164.all;

	 --Declaração da component
entity comparador4bits is
    port (
        a, b : in  std_logic_vector(3 downto 0);
        Equ, Grt, Lst : out std_logic
    );
end entity comparador4bits; 

architecture Logica of comparador4bits is

	 --sinais internos
    signal eq, gt, lt : std_logic_vector(3 downto 0);
    signal eq_out, gt_out, lt_out : std_logic;
begin
	 --Primeiros passos do circuito, para podermos comparar e fazer a operação
    gen_comparators: for i in 0 to 3 generate
        eq(i) <= a(i) xnor b(i);
        
        gt(i) <= a(i) and (not b(i));
        
        lt(i) <= (not a(i)) and b(i);
    end generate;
    
	 --se forem iguais, função and somente
    eq_out <= eq(3) and eq(2) and eq(1) and eq(0);
    
	 --se for maior, pegamos o mais significativo e comparamos, diminuindo os bits, vamos comparando um por um
    gt_out <= gt(3) or 
             (eq(3) and gt(2)) or
             (eq(3) and eq(2) and gt(1)) or
             (eq(3) and eq(2) and eq(1) and gt(0));
    
	 --mesma coisa para se for menor
    lt_out <= lt(3) or 
             (eq(3) and lt(2)) or
             (eq(3) and eq(2) and lt(1)) or
             (eq(3) and eq(2) and eq(1) and lt(0));
    
    Equ <= eq_out;
    Grt <= gt_out and not eq_out;
    Lst <= lt_out and not eq_out;
end architecture Logica;