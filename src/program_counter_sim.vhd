
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.pkg_counter.all;

entity sim_counter is
end entity;

architecture behavior of sim_counter is

signal clk    : std_logic := '0';
signal reset  : std_logic := '0';
signal sel    : std_logic := '0';
signal wpc 	  : std_logic := '0';
signal pc_in  : std_logic_vector(7 downto 0) := "00000000";
signal pc_out : std_logic_vector(7 downto 0) := "00000000";

begin
  
  pc : counter
  port map(
    clk     => clk,
    reset   => reset,
    sel     => sel,
		wpc 		=> wpc,
    pc_in   => pc_in,
    pc_out  => pc_out
  );
  
  clock : process
  begin
    clk <= '1';
    wait for 20 ns;
    clk <= '0';
    wait for 20 ns;
  end process;
  
  program_counter : process
  begin
    
    reset <= '1';
    sel   <= '0';
		wpc 	<= '1';
    pc_in <= "00101000"; -- 40
    
    wait for 50 ns; -- 0
    
    reset <= '0';
    wait for 50 ns;
    wait for 50 ns;
    wait for 50 ns;
    
    sel <= '1';
    wait for 50 ns; -- 16
    wait for 50 ns; -- 16
    
    sel <= '0';
    wait for 50 ns;
    wait for 50 ns;
  
  end process;
  
end architecture;
