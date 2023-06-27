
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

  type m1024x8 is array(0 to 2**10 - 1) of std_logic_vector(7 downto 0);
  
  signal memory : m1024x8 := (
    
    "00000000", -- MD[0] = 0
    
    others => "00000000"
    
  );
  
  signal re_i : std_logic_vector(7 downto 0);
  
begin
  
  re_i <= (others => re);
  
  dout <= memory(to_integer(unsigned(addr))) and re_i;
  
  -- reading : process (clk, re, addr)
  -- begin
    -- if ( re = '1' ) then
      -- dout <= memory(to_integer(unsigned(addr)));
    -- end if;
  -- end process;
  
  writing : process (clk, we, addr, din)
  begin
    if ( falling_edge(clk) and we = '1' ) then
      memory(to_integer(unsigned(addr))) <= din;
    end if;
  end process;
  
end architecture;
