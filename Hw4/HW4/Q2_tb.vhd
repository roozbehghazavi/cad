LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_ones IS
END tb_ones;
 
ARCHITECTURE behavior OF tb_ones IS 

    COMPONENT num_ones_for
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         ones : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;

   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal ones : std_logic_vector(4 downto 0);
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: num_ones_for PORT MAP (
          A => A,
          ones => ones
        );
 
    -- Stimulus process
   stim_proc: process
   begin        
        A <= X"FFFF"; wait for 100 ns;
        A <= X"F56F";   wait for 100 ns;
        A <= X"3FFF";   wait for 100 ns;
        A <= X"0001";   wait for 100 ns;
        A <= X"F10F";   wait for 100 ns;
        A <= X"7822";   wait for 100 ns;
        A <= X"7ABC";   wait for 100 ns;
        wait;
   end process;

END;
