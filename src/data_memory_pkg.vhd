
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_md is
  
  component md is
    port(
      clk   : in std_logic;
      we    : in std_logic;                     -- write enabler
      re    : in std_logic;                     -- read enabler
      addr  : in std_logic_vector(9 downto 0);  -- read/write address 
      din   : in std_logic_vector(7 downto 0);  -- input data
      dout  : out std_logic_vector(7 downto 0)  -- output data
    );
  end component;
  
end package;
