
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.instruction_memory_pkg.all;

entity impl_mp is
  port(
    address     : in std_logic_vector(9 downto 0);
    instruction : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behavior of impl_mp is

begin
  
  memoria_programa : instruction_memory
  port map(
    address     => address,
    instruction => instruction
  );
  
end architecture;
