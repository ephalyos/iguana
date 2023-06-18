
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.instruction_memory_pkg.all;

entity sim_mp is
end entity;

architecture behavior of sim_mp is

signal address      : std_logic_vector(9 downto 0);
signal instruction  : std_logic_vector(31 downto 0);

begin
  
  memoria_programa : instruction_memory
  port map(
    address     => address,
    instruction => instruction
  );
  
  read_mp : process
  begin
    
    address <= "0000000000";
    wait for 20 ns;
    
    address <= "0000000001";
    wait for 20 ns;
    
    address <= "0000000010";
    wait for 20 ns;
    
    address <= "0000000011";
    wait for 20 ns;
    
    address <= "0000000100";
    wait for 20 ns;
    
    address <= "0000000101";
    wait for 20 ns;
    
  end process;
  
end architecture;