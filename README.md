---

# ProjetoULA: Uma ULA Simples em VHDL

Este repositório contém o código VHDL para uma Unidade Lógica e Aritmética (ULA) simples. A ULA foi projetada para realizar várias operações em dois valores de entrada de 4 bits, **`a`** e **`b`**, e exibir os resultados em um display de 7 segmentos. O design também inclui LEDs de status para indicar condições como overflow e zero.

## Funcionalidades

A ULA suporta as seguintes operações, selecionadas por um sinal de controle de 3 bits, **`ALUOp`**:

| `ALUOp` | Operação | Descrição |
| :--- | :--- | :--- |
| `000` | Nada | Nenhuma operação é realizada. |
| `001` | AND | AND bit a bit entre `a` e `b`. |
| `010` | OR | OR bit a bit entre `a` e `b`. |
| `011` | NOT | ]NOT bit a bit em `b`. |
| `100` | Soma | Adição de 4 bits de `a` e `b`. |
| `101` | Subtração | Subtração de 4 bits de `a` e `b`. |
| `110` | Multiplicação | Multiplicação de 2 bits por 2 bits de `a(1 downto 0)` e `b(1 downto 0)`. |
| `111` | Comparação | Compara se `a` é igual, maior ou menor que `b`. |

## Descrição dos Arquivos

* `ProjetoULA.vhd`: A entidade principal que conecta todos os componentes. Ela gerencia as entradas dos switches (**`SW`**), as saídas dos displays (**`HEX0`**, **`HEX2`**, **`HEX4`**, **`HEX6`**) e os LEDs de status (**`LEDR`**). Também contém a função **`to_hex7seg`** para converter um valor de 4 bits para o padrão de um display de 7 segmentos.
* `ULA_Package.vhd`: Um pacote VHDL que define os componentes utilizados no projeto principal, incluindo **`fulladd`**, **`somador4`**, **`multiplicador2x2`** e **`comparador4bits`**.
* `somador4.vhd`: Um componente de somador de 4 bits que usa quatro componentes **`fulladd`** para realizar a adição. Ele calcula a soma e os sinais de overflow (**`Ovf`**) e carry-out (**`Cout`**).
* `fulladd.vhd`: Um componente de somador completo básico que realiza uma adição de 1 bit com carry-in e gera uma soma e um carry-out (Serve de package para o somador4).
* `multiplicador2x2.vhd`: Um componente de multiplicador de 2 bits por 2 bits. Ele usa componentes **`fulladd`** para calcular o produto de duas entradas de 2 bits.
* `comparador4bits.vhd`: Um comparador de 4 bits que determina se `a` é igual, maior ou menor que `b`. Os resultados são indicados pelos sinais **`Equ`**, **`Grt`** e **`Lst`**.

## Atribuições de Pinos

O projeto foi feito para ser usado em uma placa de hardware onde as entradas e saídas são mapeadas para componentes físicos[cite: 32].

| Pino | Descrição |
| :--- | :--- |
| `SW(10:7)` | Entrada **`a`** (4 bits). |
| `SW(6:3)` | Entrada **`b`** (4 bits). |
| `SW(2:0)` | **`ALUOp`** (seletor de operação). |
| `HEX6` | Resultado da operação. |
| `HEX4` | Display para a entrada **`a`**. |
| `HEX2` | Display para a entrada **`b`**. |
| `HEX0` | Display para o **`ALUOp`**. |
| `LEDR(0)` | LED de status **`carryOut`**. |
| `LEDR(1)` | LED de status **`zero`**. |
| `LEDR(2)` | LED de status **`overflow`**. |
| `LEDR(3)` | LED de status **`Equ`** (Igual)]. |
| `LEDR(4)` | LED de status **`Grt`** (Maior). |
| `LEDR(5)` | LED de status **`Lst`** (Menor). |

---
