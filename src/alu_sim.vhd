
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.alu_pkg.all;

entity sim_alu is
end entity;

architecture behavior of sim_alu is
  
  -- arithmetic
  constant op_addition      : std_logic_vector(4 downto 0) := "00001"; -- 1
  constant op_substraction  : std_logic_vector(4 downto 0) := "00010"; -- 2
  constant op_product       : std_logic_vector(4 downto 0) := "00011"; -- 3
  constant op_division      : std_logic_vector(4 downto 0) := "00100"; -- 4
  -- boolean
  constant op_not   : std_logic_vector(4 downto 0) := "00101"; -- 5
  constant op_and   : std_logic_vector(4 downto 0) := "00110"; -- 6
  constant op_or    : std_logic_vector(4 downto 0) := "00111"; -- 7
  constant op_xor   : std_logic_vector(4 downto 0) := "01000"; -- 8
  constant op_nor   : std_logic_vector(4 downto 0) := "01001"; -- 9
  constant op_nand  : std_logic_vector(4 downto 0) := "01010"; -- 10
  constant op_xnor  : std_logic_vector(4 downto 0) := "01011"; -- 11
  -- comparison
  constant op_cmp : std_logic_vector(4 downto 0) := "01100"; -- 12
  
  signal code   : std_logic_vector(4 downto 0);
  signal op1   : std_logic_vector(7 downto 0);
  signal op2   : std_logic_vector(7 downto 0);
  signal flag  : std_logic_vector(9 downto 0);
  signal res : std_logic_vector(7 downto 0);
  
  constant a1 : std_logic_vector(7 downto 0) := "01001000"; -- 72
  constant a2 : std_logic_vector(7 downto 0) := "10111000"; -- -72
  constant b1 : std_logic_vector(7 downto 0) := "00111111"; -- 63
  constant b2 : std_logic_vector(7 downto 0) := "11000001"; -- -63
  
begin
  
  alu_1 : alu
  port map(
    code  => code,
    op1   => op1,
    op2   => op2,
    flag  => flag,
    res   => res
  );
  
  simulation : process
  begin
    
    code <= op_product;
    op1 <= "00001111"; -- 15
    op2 <= "00001111"; -- 15
    wait for 20 ns;
    op1 <= "00001010"; -- 10
    op2 <= "00001010"; -- 10
    wait for 20 ns;
    op1 <= "00010001"; -- 17
    op2 <= "00010001"; -- 17
    wait for 20 ns;
    
    code <= op_cmp;
    op1 <= a1;
    op2 <= a2;
    wait for 20 ns;
    op1 <= b1;
    op2 <= a1;
    wait for 20 ns;
    op1 <= b2;
    op2 <= b2;
    wait for 20 ns;
    
    code <= op_and;
    op1 <= a1;
    op2 <= a2;
    wait for 20 ns;
    
    code <= op_nand;
    op1 <= a1;
    op2 <= a2;
    wait for 20 ns;
    
  end process;
  
end architecture;
