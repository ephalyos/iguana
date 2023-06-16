
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pkg_br.all;

entity sim_br is
end entity;

architecture behavior of sim_br is

signal clk : std_logic;
signal we  : std_logic;
signal rd1 : std_logic_vector(7 downto 0);
signal rd2 : std_logic_vector(7 downto 0);
signal wd  : std_logic_vector(7 downto 0);
signal din : std_logic_vector(7 downto 0);
signal dout1 : std_logic_vector(7 downto 0);
signal dout2 : std_logic_vector(7 downto 0);

begin
  
  banco_registros : br
  port map(
    clk   => clk,
    we    => we,
    rd1   => rd1,
    rd2   => rd2,
    wd    => wd,
    din   => din,
    dout1 => dout1,
    dout2 => dout2
  );
  
  clock : process
  begin
    clk <= '1';
    wait for 20 ns;
    clk <= '0';
    wait for 20 ns;
  end process;
  
  register_file : process
  begin
    
    we  <= '1'; -- escribir habilitado
    
    rd1 <= "00000001"; -- BR[1]
    rd2 <= "00000010"; -- BR[2]
    
    wd  <= "00000001"; -- BR[1]
    din <= "00001110"; -- 14
    wait for 50 ns;
    
    wd  <= "00000010"; -- BR[2]
    din <= "00011100"; -- 28
    wait for 50 ns;
    
    rd1 <= "00000011"; -- BR[3]
    rd2 <= "00000100"; -- BR[4]
    
    wd  <= "00000011"; -- BR[3]
    din <= "00110000"; -- 48
    wait for 50 ns;
    
    wd  <= "00000100"; -- BR[4]
    din <= "00110010"; -- 50
    wait for 50 ns;
    
  end process;
  
end architecture;
