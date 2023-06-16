
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
  port(
    clk     : in std_logic;
    reset   : in std_logic;
    sel     : in std_logic;
    wpc     : in std_logic;
    pc_in   : in std_logic_vector(7 downto 0);
    pc_out  : inout std_logic_vector(7 downto 0)
  );
end entity;

architecture behavior of counter is

signal pc_next : std_logic_vector(7 downto 0);

begin
  
  pc : process(clk, reset)
  begin
    if (reset = '1') then
      pc_out <= (others => '0');
    -- WARNING: remove the <or clk = '0'> condition if implemented
    elsif (falling_edge(clk)) then
      if (wpc = '1') then 
        if (sel = '1') then
          pc_out <= pc_in;
        else 
          pc_out <= pc_next;
        end if;
      end if;
    end if;
  end process;
  
  pc_next <= pc_out + 1;
  
end architecture;
