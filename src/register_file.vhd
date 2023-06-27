
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
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
end entity;

architecture behavior of register_file is
  
  type m256x8 is array(0 to 2**8 - 1) of std_logic_vector(7 downto 0);
  
  signal memory : m256x8 := (
    
    "00000000", -- BR[0] = 0
    "00000001", -- BR[1] = 1
    "00000010", -- BR[2] = 2
    "00000011", -- BR[3] = 3
    "00000100", -- BR[4] = 4
    "00000101", -- BR[5] = 5
    "00000110", -- BR[6] = 6
    "00000111", -- BR[7] = 7
    "00001000", -- BR[8] = 8
    "00001001", -- BR[9] = 9
    
    others => "00000000"
    
  );
  
begin
  
  dout1 <= memory(to_integer(unsigned(rd1)));
  dout2 <= memory(to_integer(unsigned(rd2)));
  
  process (clk, wd, din)
  begin
    if ( falling_edge(clk) and we = '1' ) then
      memory(to_integer(unsigned(wd))) <= din;
    end if;
  end process;
  
end architecture;
