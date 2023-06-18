
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

package program_counter_pkg is
  
  component program_counter is
    port(
      clk           : in std_logic;
      reset         : in std_logic;
      sel           : in std_logic;
			wpc           : in std_logic;
      pc_in         : in std_logic_vector(7 downto 0);
      pc_out        : inout std_logic_vector(7 downto 0)
    );
  end component;
  
end package;
