
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port(
    code  : in std_logic_vector(4 downto 0);
    op1   : in std_logic_vector(7 downto 0);
    op2   : in std_logic_vector(7 downto 0);
    flag  : out std_logic_vector(9 downto 0);
    res   : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavior of alu is
  
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
  constant op_cmp : std_logic_vector(4 downto 0) := "01100"; -- 12
  -- flags
  constant RES_ERROR  : std_logic_vector(9 downto 0) := "0000000001"; -- flags(0)
  constant RES_ZERO   : std_logic_vector(9 downto 0) := "0000000010"; -- flags(1)
  constant RES_EVEN   : std_logic_vector(9 downto 0) := "0000000100"; -- flags(2)
  constant RES_POS    : std_logic_vector(9 downto 0) := "0000001000"; -- flags(3)
  constant OP_ERROR   : std_logic_vector(9 downto 0) := "0000010000"; -- flags(4)
  constant OVERFLOW   : std_logic_vector(9 downto 0) := "0000100000"; -- flags(5)
  constant ZERO_DIV   : std_logic_vector(9 downto 0) := "0001000000"; -- flags(6)
  constant GREATER    : std_logic_vector(9 downto 0) := "0010000000"; -- flags(7)
  constant LESS       : std_logic_vector(9 downto 0) := "0100000000"; -- flags(8)
  constant EQUAL      : std_logic_vector(9 downto 0) := "1000000000"; -- flags(9)
  
  -- internals
  signal res_i  : std_logic_vector(7 downto 0);
  signal flag_i : std_logic_vector(9 downto 0);
  signal more_than : std_logic;
  signal less_than : std_logic;
  signal equal_to  : std_logic;
  
begin
  
  -- CREATE RESULT
  
  process (op1, op2, code) 
    
    variable op1_i : signed(7 downto 0);
    variable op2_i : signed(7 downto 0);
    
  begin
  
    op1_i := signed(op1);
    op2_i := signed(op2);
    
    case code is
      
      when op_addition => 
        res_i <= std_logic_vector(op1_i + op2_i);
      when op_substraction => 
        res_i <= std_logic_vector(op1_i - op2_i);
      when op_product => 
        res_i <= std_logic_vector(unsigned(op1(3 downto 0)) * unsigned(op2(3 downto 0)));
      
      when op_not => 
        res_i <= not op1;
      when op_and => 
        res_i <= op1 and op2;
      when op_or => 
        res_i <= op1 or op2;
      when op_xor => 
        res_i <= op1 xor op2;
      when op_nand => 
        res_i <= not (op1 and op2);
      when op_nor => 
        res_i <= not (op1 or op2);
      when op_xnor => 
        res_i <= not (op1 xor op2);
      
      when op_cmp =>
        res_i <= (others => '0');
        if ( op1_i > op2_i ) then
          more_than <= '1';
          equal_to <= '0';
          less_than <= '0';
        elsif ( op1_i = op2_i ) then
          more_than <= '0';
          equal_to <= '1';
          less_than <= '0';
        else
          more_than <= '0';
          equal_to <= '0';
          less_than <= '1';
        end if;
      
      when others => 
      
    end case;
    
  end process;
  
  -- CREATE FLAGS
  
  process (op1, op2, res_i, code, more_than, equal_to, less_than)
    
    variable op1_i : signed(7 downto 0);
    variable op2_i : signed(7 downto 0);
    
  begin
    
    flag_i <= (others => '0');
    
    op1_i := signed(op1);
    op2_i := signed(op2);
    
    if ( code = op_addition ) then
      if ( op1_i > 0 and op2_i > 0 and signed(res_i) < 0 ) then
        flag_i <= RES_ERROR or OVERFLOW;
      elsif ( op1_i < 0 and op2_i < 0 and signed(res_i) > 0 ) then 
        flag_i <= RES_ERROR or OVERFLOW;
      else
        if ( res_i = "00000000" ) then
          flag_i <= flag_i or RES_ZERO;
        end if;
        if ( res_i(0) = '0' ) then
          flag_i <= flag_i or RES_EVEN;
        end if;
        if ( signed(res_i) > 0 ) then
          flag_i <= flag_i or RES_POS;
        end if;
      end if;
    end if;
    
    if ( code = op_substraction ) then
      if ( op1_i > 0 and op2_i < 0 and signed(res_i) < 0 ) then 
        flag_i <= RES_ERROR or OVERFLOW;
      elsif ( op1_i < 0 and op2_i > 0 and signed(res_i) > 0 ) then 
        flag_i <= RES_ERROR or OVERFLOW;
      else
        if ( res_i = "00000000" ) then
          flag_i <= flag_i or RES_ZERO;
        end if;
        if ( res_i(0) = '0' ) then
          flag_i <= flag_i or RES_EVEN;
        end if;
        if ( signed(res_i) > 0 ) then
          flag_i <= flag_i or RES_POS;
        end if;
      end if;
    end if;
    
    if ( code = op_product ) then
      if ( op1_i > 15 or op2_i > 15 ) then
        flag_i <= RES_ERROR or OP_ERROR;
      else
        if ( res_i = "00000000" ) then
          flag_i <= flag_i or RES_ZERO;
        end if;
        if ( res_i(0) = '0' ) then
          flag_i <= flag_i or RES_EVEN;
        end if;
        if ( signed(res_i) > 0 ) then
          flag_i <= flag_i or RES_POS;
        end if;
      end if;
    end if;
    
    if ( code = op_cmp ) then
      if ( more_than = '1' ) then
        flag_i <= GREATER;
      elsif ( equal_to = '1' ) then
        flag_i <= EQUAL;
      else 
        flag_i <= LESS;
      end if;
    end if;
    
  end process;
  
  res <= res_i when flag_i(0) = '0' else "00000000";
  flag <= flag_i;
  
end architecture;
