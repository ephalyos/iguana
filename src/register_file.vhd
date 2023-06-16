
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity br is
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

architecture behavior of br is
  
  -- memory definition
  type m256x8 is array(0 to 2**8 - 1) of std_logic_vector(7 downto 0);
  
  -- register file
  signal memory : m256x8 := (
    
    -- data
    "00000000", -- BR[0] = 0
    "00010000", -- BR[1] = 16
    "00100000", -- BR[2] = 32
    "01000000", -- BR[3] = 64
    
    -- rest of memory
    others => "00000000"
    
  );
  
begin
  
  -- asynchronous read
  dout1 <= memory(to_integer(unsigned(rd1)));
  dout2 <= memory(to_integer(unsigned(rd2)));
  
  -- synchronous write
  writing : process (clk)
  begin
    -- for simulation use the clock = '0' condition 
    if (falling_edge(clk)) then
      if (we = '1') then
        memory(to_integer(unsigned(wd))) <= din;
      end if;
    end if;
  end process;
  
end architecture;
