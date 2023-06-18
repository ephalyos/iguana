
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.data_memory_pkg.all;

entity sim_md is
end entity;

architecture behavior of sim_md is

signal clk  : std_logic;
signal we   : std_logic;
signal re   : std_logic;
signal addr : std_logic_vector(9 downto 0);
signal din  : std_logic_vector(7 downto 0);
signal dout : std_logic_vector(7 downto 0);

begin
  
  memoria_datos : data_memory
  port map(
    clk   => clk,
    we    => we,
    re    => re,
    addr  => addr,
    din   => din,
    dout  => dout
  );
  
  clock : process
  begin
    clk <= '1';
    wait for 20 ns;
    clk <= '0';
    wait for 20 ns;
  end process;
  
  memory_data : process
  begin
    
    -- addr 512-256-128-64-32  16-8-4-2-1
    
    -- din  128-64-32-16  8-4-2-1
    
    we <= '1';
    re <= '1';
    
    addr  <= "0000100001"; -- MD[33]
    din   <= "00001111"; -- 15
    wait for 50 ns;
    
    addr  <= "0010001000"; -- MD[136]
    din   <= "01001000"; -- 72
    wait for 50 ns;
    
    we <= '0';
    
    addr  <= "0000100001"; -- MD[33]
    din   <= "01001000"; -- 68
    wait for 50 ns;
    
    re <= '0';
    addr  <= "0010001000"; -- MD[136]
    wait for 50 ns;
    
  end process;
  
end architecture;
