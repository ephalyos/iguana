
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
  port(
    clk     : in std_logic;
    wpc     : in std_logic;
    reset   : in std_logic;
    sel     : in std_logic;
    pc_in   : in std_logic_vector(9 downto 0);
    pc_out  : out std_logic_vector(9 downto 0)
  );
end entity;

architecture behavior of program_counter is

signal pc_curr : std_logic_vector(9 downto 0) := "0000000000";

begin
  
  process (clk)
  begin
    if (reset = '1') then
      pc_out <= (others => '0');
    elsif ( falling_edge(clk) and wpc = '1' ) then
      if ( sel = '1' ) then
        pc_out <= pc_in;
      else
        pc_out  <= pc_curr;
        pc_curr <= std_logic_vector(unsigned(pc_curr) + 1);
      end if;
    end if;
  end process;
  
end architecture;
