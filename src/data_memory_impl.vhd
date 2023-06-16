
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pkg_osc.all;
use work.pkg_md.all;

entity impl_md is
  port(
    -- entity
    we    : in std_logic;                     -- write enabler
    re    : in std_logic;                     -- read enabler
    addr  : in std_logic_vector(7 downto 0);  -- read/write address
    din   : in std_logic_vector(7 downto 0);  -- input data
    dout  : out std_logic_vector(7 downto 0); -- output data
    -- others
    clk   : out std_logic
  );
end entity;

architecture behavior of impl_md is

signal tmp_clk : std_logic;
signal tmp_addr : std_logic_vector(9 downto 0);

begin
  
  oscillator : osc
  port map(
    div_factor  => '0',
    out_freq    => tmp_clk
  );
  
  tmp_addr <= "00" & addr;
  
  memoria_datos : md
  port map(
    clk   => tmp_clk,
    we    => we,
    re    => re,
    addr  => tmp_addr,
    din   => din,
    dout  => dout
  );
  
  clk <= tmp_clk;
  
end architecture;
