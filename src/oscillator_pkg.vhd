
-- libraries

library ieee;
use ieee.std_logic_1164.all;

library lattice;
use lattice.all;

-- package

package oscillator_pkg is
  
  component internal_oscillator is
    port(
      osc_freq : out std_logic
    );
  end component;
  
  component freqdiv is
    port(
      in_freq     : in std_logic;
      div_factor  : in std_logic;
      out_freq    : inout std_logic
    );
  end component;
  
  component oscillator is
    port(
      div_factor  : in std_logic;
      out_freq    : inout std_logic
    );
  end component;
  
end package;
