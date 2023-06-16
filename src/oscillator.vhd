
-- *******************************************************
-- *******************************************************

-- Instance of MACHXO2 Internal Oscillator

-- libraries

library ieee;
use ieee.std_logic_1164.all;

library lattice;
use lattice.all;

-- entity

entity oscillator is
  port(
    osc_freq : out std_logic
  );
end entity;

-- architecture

architecture behavior of Oscillator is

component OSCH is
  generic(
    NOM_FREQ : string := "2.08"
  );
  port(
    STDBY : in  std_logic;
    OSC   : out std_logic
  );
end component;

attribute NOM_FREQ : string;
attribute NOM_FREQ of osc_instance : label is "2.08";

begin
  
  osc_instance : OSCH
  generic map( NOM_FREQ => "2.08")
  port map(
    STDBY => '0',
    OSC   => osc_freq
  );
  
end architecture;


-- *******************************************************
-- *******************************************************

-- Frequency Divider

-- libraries

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library lattice;
use lattice.all;

-- entity

entity freqdiv is
  port(
    in_freq     : in std_logic;
    div_factor  : in std_logic;
    out_freq    : inout std_logic
  );
end entity;

-- architecture

architecture behavior of freqdiv is

signal divider : std_logic_vector(20 downto 0);

begin
  
  process(in_freq)
  begin
    if (rising_edge(in_freq)) then
      
      if (div_factor = '1') then
        -- 2^20 which is almost 1 p / 1 s
        if (divider(19) = '0') then
          divider <= divider + 1;
        else
          divider <= (others => '0');
          out_freq <= not(out_freq);
        end if;
      else
        -- 2^21 which is almost 1 p / 2 s
        if (divider(20) = '0') then
          divider <= divider + 1;
        else
          divider <= (others => '0');
          out_freq <= not(out_freq);
        end if;
      end if;
      
    end if;
  end process;
  
end architecture;

-- *******************************************************
-- *******************************************************

-- Oscillator for Implementation

-- libraries

library ieee;
use ieee.std_logic_1164.all;

library lattice;
use lattice.all;

use work.pkg_osc.all;

-- entity

entity osc is
  port(
    div_factor  : in std_logic;
    out_freq    : inout std_logic
  );
end entity;

-- architecture

architecture behavior of osc is

signal tmp_clk : std_logic;

begin
  
  osc_instance : oscillator
  port map(
    osc_freq => tmp_clk
  );
  
  div_instance : freqdiv
  port map(
    in_freq     => tmp_clk,
    div_factor  => div_factor,
    out_freq    => out_freq
  );
  
end architecture;
