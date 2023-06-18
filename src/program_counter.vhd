
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
  port(
    clk     : in std_logic;
    reset   : in std_logic;
    sel     : in std_logic;
    wpc     : in std_logic;
    pc_in   : in std_logic_vector(7 downto 0);
    pc_out  : inout std_logic_vector(7 downto 0)
  );
end entity;

architecture behavior of program_counter is

signal pc_next : std_logic_vector(7 downto 0);

begin
  
  pc : process(clk, reset)
  begin
    if (reset = '1') then
      pc_out <= (others => '0');
    -- Simulation - clk'event and clk = '0'
    -- Implementation - falling_edge(clk)
    elsif (clk'event and clk = '0') then
      if (wpc = '1') then 
        if (sel = '1') then
          pc_out <= pc_in;
        else
          pc_out <= pc_next;
        end if;
      end if;
    end if;
  end process;
  
  pc_next <= std_logic_vector(unsigned(pc_out) + 1);
  
end architecture;
