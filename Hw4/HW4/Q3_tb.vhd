LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_bb IS
END tb_bb;
 
ARCHITECTURE behavior OF tb_bb IS 

    COMPONENT bcd_2_bin
    PORT(
         bcd_in_0 : IN  std_logic_vector(3 downto 0);
         bcd_in_10 : IN  std_logic_vector(3 downto 0);
         bcd_in_100 : IN  std_logic_vector(3 downto 0);
         bcd_in_1000 : IN  std_logic_vector(3 downto 0);
         bin_out : OUT  std_logic_vector(13 downto 0)
        );
    END COMPONENT;

   signal bcd_in_0 : std_logic_vector(3 downto 0) := (others => '0');
   signal bcd_in_10 : std_logic_vector(3 downto 0) := (others => '0');
   signal bcd_in_100 : std_logic_vector(3 downto 0) := (others => '0');
   signal bcd_in_1000 : std_logic_vector(3 downto 0) := (others => '0');
   signal bin_out : std_logic_vector(13 downto 0);
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: bcd_2_bin PORT MAP (
          bcd_in_0 => bcd_in_0,
          bcd_in_10 => bcd_in_10,
          bcd_in_100 => bcd_in_100,
          bcd_in_1000 => bcd_in_1000,
          bin_out => bin_out
        );

-- Stimulus process
   stim_proc: process
   begin        
      bcd_in_0 <= x"0"; bcd_in_10 <= x"1"; bcd_in_100 <= x"2"; bcd_in_1000 <= x"3";
        wait for 100 ns;
        bcd_in_0 <= x"9"; bcd_in_10 <= x"9"; bcd_in_100 <= x"9"; bcd_in_1000 <= x"9";
        wait for 100 ns;
        bcd_in_0 <= x"9"; bcd_in_10 <= x"2"; bcd_in_100 <= x"4"; bcd_in_1000 <= x"6";
        wait for 100 ns;
        bcd_in_0 <= x"0"; bcd_in_10 <= x"0"; bcd_in_100 <= x"0"; bcd_in_1000 <= x"0";
      wait;
   end process;

END;
