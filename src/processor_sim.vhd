
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.program_counter_pkg.all;
use work.instruction_memory_pkg.all;
use work.register_file_pkg.all;
use work.alu_pkg.all;
use work.data_memory_pkg.all;

entity processor_sim is
end entity;

architecture behavior of processor_sim is

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
  
  constant op_gt : std_logic_vector(4 downto 0) := "01100"; -- 12
  constant op_eq : std_logic_vector(4 downto 0) := "01101"; -- 13
  constant op_lt : std_logic_vector(4 downto 0) := "01110"; -- 14
  
  constant op_jump      : std_logic_vector(4 downto 0) := "10001"; -- 17
  constant op_jump_eq   : std_logic_vector(4 downto 0) := "10010"; -- 18
  constant op_jump_neq  : std_logic_vector(4 downto 0) := "10011"; -- 19
  
  constant op_load  : std_logic_vector := "11000"; -- 24
  constant op_store : std_logic_vector := "11001"; -- 25
  
  constant nop : std_logic_vector(4 downto 0) := "11111"; -- 31
  
  -- SIGNALS ------------------------------------------------------------
  
  signal wpc    : std_logic := '1';
  signal sel    : std_logic := '0';
  signal reset  : std_logic := '0';
  signal pc_in  : std_logic_vector(9 downto 0) := "0000000000";
  signal pc_out : std_logic_vector(9 downto 0);
  
  signal instruction  : std_logic_vector(31 downto 0);
  
  -- signal we     : std_logic;
  -- signal wd     : std_logic_vector(7 downto 0);
  -- signal din    : std_logic_vector(7 downto 0);
  -- signal rd1    : std_logic_vector(7 downto 0);
  -- signal rd2    : std_logic_vector(7 downto 0);
  -- signal dout1  : std_logic_vector(7 downto 0);
  -- signal dout2  : std_logic_vector(7 downto 0);
  
  -- signal opcode : std_logic_vector(4 downto 0);
  -- signal op1    : std_logic_vector(7 downto 0);
  -- signal op2    : std_logic_vector(7 downto 0);
  -- signal res    : std_logic_vector(7 downto 0);
  -- signal flag   : std_logic_vector(9 downto 0);
  
  -- signal md_we  : std_logic;
  -- signal re     : std_logic;
  -- signal addr   : std_logic_vector(9 downto 0);
  -- signal md_din : std_logic_vector(7 downto 0);
  -- signal dout   : std_logic_vector(7 downto 0);
  
  -- TYPES ------------------------------------------------------------
  
  type INSTRUCTION_TYPE is (R_TYPE, JI_TYPE, JC_TYPE, LW_TYPE, SW_TYPE, NIL);
  signal current : INSTRUCTION_TYPE := NIL;
  
  -- FIELDS ------------------------------------------------------------
  
  signal opc  : std_logic_vector(4 downto 0);
  signal rs   : std_logic_vector(7 downto 0);
  signal rt   : std_logic_vector(7 downto 0);
  signal rd   : std_logic_vector(7 downto 0);
  signal ctl  : std_logic_vector(2 downto 0);
  signal dir  : std_logic_vector(9 downto 0);
  
  -- DEBUG
  
  signal clk : std_logic := '0';
  
  
begin
  
  -- COMPONENTS ------------------------------------------------------------
  
  PC : program_counter
  port map(
		wpc 		=> wpc,
    sel     => sel,
    reset   => reset,
    pc_in   => pc_in,
    clk     => clk,
    pc_out  => pc_out
  );
  
  MP : instruction_memory
  port map(
    address     => pc_out,
    instruction => instruction
  );
  
  -- BR : register_file
  -- port map(
    -- we    => we,
    -- wd    => wd,
    -- din   => din,
    -- rd1   => rd1,
    -- rd2   => rd2,
    -- clk   => clk,
    -- dout1 => dout1,
    -- dout2 => dout2
  -- );
  
  -- ALU1 : alu
  -- port map(
    -- code  => opcode,
    -- op1   => op1,
    -- op2   => op2,
    -- res   => res,
    -- flag  => flag
  -- );
  
  -- MD : data_memory
  -- port map(
    -- we    => md_we,
    -- re    => re,
    -- addr  => addr,
    -- din   => md_din,
    -- clk   => clk,
    -- dout  => dout
  -- );
  
  -- FIELDS ------------------------------------------------------------
  
  opc <= instruction(31 downto 27);
  
  -- TRANSITIONS ------------------------------------------------------------
  
  process (opc)
  begin
    case opc is
      
      when op_addition | op_substraction | op_product |
      op_not | op_and | op_or | op_xor | op_nor | op_nand | op_xnor => 
        current <= R_TYPE;
        rs  <= instruction(26 downto 19);
        rt  <= instruction(18 downto 11);
        rd  <= instruction(10 downto 3);
        ctl <= instruction(2 downto 0);
        dir <= "0000000000";
      
      when nop => 
        current <= NIL;
        wpc <= '0';
      
      when others =>
      
    end case;
  end process;
  
  -- ACTIONS ------------------------------------------------------------
  
  process (current)
  begin
    case current is
      
      when R_TYPE =>
        -- CP - - - - -
        wpc   <= '1';
        sel   <= '0';
        reset <= '0';
        -- BR - - - - -
        -- we  <= '1';
        -- wd  <= rd;
        -- din <= res;
        -- rd1 <= rs;
        -- rd2 <= rt;
        -- -- ALU - - - - -
        -- opcode  <= opc;
        -- op1     <= dout1;
        -- op2     <= dout2;
        -- -- MD - - - - -
        -- md_we <= '0';
        -- re    <= '0';
      
      when others =>
      
    end case;
  end process;
  
  -- CLOCK --------------------------------------------------------------
  
  process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
  end process;
  
end architecture;
