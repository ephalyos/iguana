
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is 
  port(
    clk   : in std_logic;
    we    : in std_logic;                     -- write enabler
    re    : in std_logic;                     -- read enabler
    addr  : in std_logic_vector(9 downto 0);  -- read/write address 
    din   : in std_logic_vector(7 downto 0);  -- input data
    dout  : out std_logic_vector(7 downto 0)  -- output data
  );
end entity;

architecture behavior of data_memory is 

  -- memory definition
  type m1024x8 is array(0 to 2**10 - 1) of std_logic_vector(7 downto 0);
  
  -- data memory
  signal memory : m1024x8 := (
    
    -- data
    "00000000", -- MD[0] = 0
    "00010011", -- MD[1] = 19
    "00100011", -- MD[2] = 35
    "01000011", -- MD[3] = 67
    
    -- rest of memory
    others => "00000000"
    
  );
  
begin
  
  -- for simulation - clk'event and clk = '0' 
  -- for implementation - falling_edge(clk)
  
  reading : process (clk)
  begin
    if (clk'event and clk = '1') then
      if (re = '1') then
        dout <= memory(to_integer(unsigned(addr)));
      end if;
    end if;
  end process;
  
  writing : process (clk)
  begin
    if (clk'event and clk = '0') then
      if (we = '1') then
        memory(to_integer(unsigned(addr))) <= din;
      end if;
    end if;
  end process;
  
end architecture;
