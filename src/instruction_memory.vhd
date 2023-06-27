
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is
  port(
    address     : in std_logic_vector(9 downto 0);
    instruction : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behavior of instruction_memory is
  
  -- CONSTANTS ------------------------------------------------------------
  
  constant op_addition      : std_logic_vector(4 downto 0) := "00001"; -- 1
  constant op_substraction  : std_logic_vector(4 downto 0) := "00010"; -- 2
  constant op_product       : std_logic_vector(4 downto 0) := "00011"; -- 3
  constant op_division      : std_logic_vector(4 downto 0) := "00100"; -- 4
  
  constant op_not   : std_logic_vector(4 downto 0) := "00101"; -- 5
  constant op_and   : std_logic_vector(4 downto 0) := "00110"; -- 6
  constant op_or    : std_logic_vector(4 downto 0) := "00111"; -- 7
  constant op_xor   : std_logic_vector(4 downto 0) := "01000"; -- 8
  constant op_nor   : std_logic_vector(4 downto 0) := "01001"; -- 9
  constant op_nand  : std_logic_vector(4 downto 0) := "01010"; -- 10
  constant op_xnor  : std_logic_vector(4 downto 0) := "01011"; -- 11
  
  constant op_jump      : std_logic_vector(4 downto 0) := "10001"; -- 17
  constant op_jump_eq   : std_logic_vector(4 downto 0) := "10010"; -- 18
  constant op_jump_neq  : std_logic_vector(4 downto 0) := "10011"; -- 19
  
  constant op_load  : std_logic_vector := "11000"; -- 24
  constant op_store : std_logic_vector := "11001"; -- 25
  
  constant nop : std_logic_vector(4 downto 0) := "11111"; -- 31
  
  -- MEMORY ------------------------------------------------------------
  
  type m1024x32 is array(0 to 2**10 - 1) of std_logic_vector(31 downto 0);
  
  signal memory : m1024x32 := (
    
    op_addition & "00001001" & "00000001" & "00001010" & "000", -- 0, BR[10] = BR[9] + BR[1]
    -- op_jump     & "00000000" & "00000000" & '0' & "0000000011", -- 1, goto MP[3]
    op_jump_eq  & "00000101" & "00000111" & '0' & "0000000011", -- if BR[7] == BR[7] goto MP[3]
    op_addition & "00001010" & "00000001" & "00001011" & "000", -- 2, BR[11] = BR[10] + BR[1]
    op_addition & "00001001" & "00001001" & "00001011" & "000", -- 3, BR[11] = BR[9] + BR[9]
    
    
    nop & "000000000000000000000000000",
    
    others => "00000000000000000000000000000000"
    
  );
  
begin
  
  instruction <= memory(to_integer(unsigned(address)));
  
end architecture;
