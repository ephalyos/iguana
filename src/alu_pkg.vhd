
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package alu_pkg is

  component alu is
    port(
      code  : in std_logic_vector(4 downto 0);
      op1   : in std_logic_vector(7 downto 0);
      op2   : in std_logic_vector(7 downto 0);
      flag  : out std_logic_vector(9 downto 0);
      res   : out std_logic_vector(7 downto 0)
    );
  end component;

end package;
