
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package instruction_memory_pkg is

  component instruction_memory is
    port(
      address     : in std_logic_vector(9 downto 0);
      instruction : out std_logic_vector(31 downto 0)
    );
  end component;

end package;
