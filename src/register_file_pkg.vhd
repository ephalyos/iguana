
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package register_file_pkg is
  
  component register_file is 
    port(
      clk   : in std_logic;
      we    : in std_logic;                     -- write enabler
      rd1   : in std_logic_vector(7 downto 0);  -- read address 1
      rd2   : in std_logic_vector(7 downto 0);  -- read address 2
      wd    : in std_logic_vector(7 downto 0);  -- write address
      din   : in std_logic_vector(7 downto 0);  -- input data
      dout1 : out std_logic_vector(7 downto 0); -- output data 1
      dout2 : out std_logic_vector(7 downto 0)  -- output data 2
    );
  end component;
  
end package;
