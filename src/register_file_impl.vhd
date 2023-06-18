
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.oscillator_pkg.all;
use work.register_file_pkg.all;

entity impl_br is
  port(
    -- entity
    we    : in std_logic;                     -- write enabler
    rd1   : in std_logic_vector(3 downto 0);  -- read address 1
    rd2   : in std_logic_vector(3 downto 0);  -- read address 2
    wd    : in std_logic_vector(3 downto 0);  -- write address
    din   : in std_logic_vector(7 downto 0);  -- input data
    dout1 : out std_logic_vector(7 downto 0); -- output data 1
    dout2 : out std_logic_vector(7 downto 0);  -- output data 2
    -- others
    clk   : out std_logic
  );
end entity;

architecture behavior of impl_br is

signal tmp_clk : std_logic;
signal tmp_rd1 : std_logic_vector(7 downto 0);
signal tmp_rd2 : std_logic_vector(7 downto 0);
signal tmp_wd  : std_logic_vector(7 downto 0);

begin
  
  osc: oscillator
  port map(
    div_factor  => '0',
    out_freq    => tmp_clk
  );
  
  tmp_rd1 <= "0000" & rd1;
  tmp_rd2 <= "0000" & rd2;
  tmp_wd  <= "0000" & wd;
  
  banco_registros : register_file
  port map(
    clk   => tmp_clk,
    we    => we,
    rd1   => tmp_rd1,
    rd2   => tmp_rd2,
    wd    => tmp_wd,
    din   => din,
    dout1 => dout1,
    dout2 => dout2
  );
  
  clk <= tmp_clk;
  
end architecture;
