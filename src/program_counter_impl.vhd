
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.oscillator_pkg.all;
use work.program_counter_pkg.all;

entity impl_counter is
  port(
    div_factor : in std_logic;
    sel        : in std_logic;
    reset      : in std_logic;
		wpc				 : in std_logic;
    pc_in      : in std_logic_vector(7 downto 0);
    pc_out     : inout std_logic_vector(7 downto 0);
    clk        : out std_logic
  );
end entity;

architecture behavior of impl_counter is

signal tmp_clk : std_logic;

begin
  
  osc : oscillator
  port map(
    div_factor  => div_factor,
    out_freq    => tmp_clk
  );
  
  pc : program_counter
  port map(
    clk     => tmp_clk,
    reset   => reset,
    sel     => sel,
		wpc			=> wpc,
    pc_in   => pc_in,
    pc_out  => pc_out
  );
  
  clk <= tmp_clk;
  
end architecture;
