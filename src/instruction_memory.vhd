
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
  
  -- carga / almacenamiento
  constant op_load  : std_logic_vector := "00000"; -- 0
  constant op_store : std_logic_vector := "10000"; -- 16
  
  -- arithmetic
  constant op_addition      : std_logic_vector(4 downto 0) := "00001"; -- 1
  constant op_substraction  : std_logic_vector(4 downto 0) := "00010"; -- 2
  constant op_product       : std_logic_vector(4 downto 0) := "00011"; -- 3
  constant op_division      : std_logic_vector(4 downto 0) := "00100"; -- 4
  
  -- boolean
  constant op_not   : std_logic_vector(4 downto 0) := "00101"; -- 5
  constant op_and   : std_logic_vector(4 downto 0) := "00110"; -- 6
  constant op_or    : std_logic_vector(4 downto 0) := "00111"; -- 7
  constant op_xor   : std_logic_vector(4 downto 0) := "01000"; -- 8
  constant op_nor   : std_logic_vector(4 downto 0) := "01001"; -- 9
  constant op_nand  : std_logic_vector(4 downto 0) := "01010"; -- 10
  constant op_xnor  : std_logic_vector(4 downto 0) := "01011"; -- 11
  
  -- comparison
  constant op_gt : std_logic_vector(4 downto 0) := "01100"; -- 12
  constant op_eq : std_logic_vector(4 downto 0) := "01101"; -- 13
  constant op_lt : std_logic_vector(4 downto 0) := "01110"; -- 14
  constant op_lt : std_logic_vector(4 downto 0) := "01110"; -- 14
  constant op_lt : std_logic_vector(4 downto 0) := "01110"; -- 14
  constant op_lt : std_logic_vector(4 downto 0) := "01110"; -- 14
  
  -- jump
  constant op_jump      : std_logic_vector(4 downto 0) := "10001"; -- 17
  constant op_jump_eq   : std_logic_vector(4 downto 0) := "10010"; -- 18
  constant op_jump_neq  : std_logic_vector(4 downto 0) := "10011"; -- 19
  
  -- nop
  constant nop : std_logic_vector(4 downto 0) := "11111"; -- 31
  
  -- registers
  constant zero : std_logic_vector(7 downto 0) := "00000000";
  constant r1   : std_logic_vector(7 downto 0) := "00000001";
  constant r2   : std_logic_vector(7 downto 0) := "00000010";
  constant r3   : std_logic_vector(7 downto 0) := "00000011";
  constant r4   : std_logic_vector(7 downto 0) := "00000100";
  constant r5   : std_logic_vector(7 downto 0) := "00000101";
  constant r6   : std_logic_vector(7 downto 0) := "00000110";
  constant r7   : std_logic_vector(7 downto 0) := "00000111";
  constant r8   : std_logic_vector(7 downto 0) := "00001000";
  constant r9   : std_logic_vector(7 downto 0) := "00001001";
  constant r10  : std_logic_vector(7 downto 0) := "00001010";
  constant r11  : std_logic_vector(7 downto 0) := "00001011";
  constant r12  : std_logic_vector(7 downto 0) := "00001100";
  constant r13  : std_logic_vector(7 downto 0) := "00001101";
  constant r14  : std_logic_vector(7 downto 0) := "00001110";
  constant r15  : std_logic_vector(7 downto 0) := "00001111";
  
  -- memoria de datos
  constant m1   : std_logic_vector(9 downto 0) := "0000000001";
  constant m2   : std_logic_vector(9 downto 0) := "0000000010";
  constant m3   : std_logic_vector(9 downto 0) := "0000000011";
  constant m4   : std_logic_vector(9 downto 0) := "0000000100";
  constant m5   : std_logic_vector(9 downto 0) := "0000000101";
  constant m6   : std_logic_vector(9 downto 0) := "0000000110";
  constant m7   : std_logic_vector(9 downto 0) := "0000000111";
  constant m8   : std_logic_vector(9 downto 0) := "0000001000";
  constant m9   : std_logic_vector(9 downto 0) := "0000001001";
  constant m10  : std_logic_vector(9 downto 0) := "0000001010";
  
  -- control options
  constant cr   : std_logic_vector(2 downto 0) := "000";
  
  -- memory definition
  type m1024x32 is array(0 to 2**10 - 1) of std_logic_vector(31 downto 0);
  
  -- instruction memory
  signal memory : m1024x32 := (
    
    -- instrucciones tipo R
    op_addition & r1 & r2   & r3 & cr,        -- BR[3] = BR[1] + BR[2]
    op_not      & r4 & zero & r4 & cr,        -- BR[4] = not BR[4]
    
    -- instrucciones tipo J
    op_jump     & zero  & zero  & '0' & "0000000010", -- salta a dirección MP[2]
    op_jump_eq  & r5    & r6    & '0' & "0000000101", -- salta a dirección MP[5] si BR[5] == BR[6]
    
    -- instrucciones tipo transferencia datos
    op_load   &  r7   & zero  & '0' & m2,   -- carga a BR[7] = MD[2]
    op_store  & zero  & r8    & '0' & m1,   -- guarda en MD[1] = BR[8]
    
		-- rest of memory
    others => "00000000000000000000000000000000"
    
  );
  
begin
  
  instruction <= memory(to_integer(unsigned(address)));
  
end architecture;
