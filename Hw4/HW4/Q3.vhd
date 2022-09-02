library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--this module is for converting a 4 digit BCD number into binary number.   
--the range of the input in decimal is 0 to 9999.
entity bcd_2_bin is
    Port ( bcd_in_0 : in  STD_LOGIC_VECTOR (3 downto 0);
           bcd_in_10 : in  STD_LOGIC_VECTOR (3 downto 0);
           bcd_in_100 : in  STD_LOGIC_VECTOR (3 downto 0);
           bcd_in_1000 : in  STD_LOGIC_VECTOR (3 downto 0);
           bin_out : out  STD_LOGIC_VECTOR (13 downto 0) := (others => '0'));
end bcd_2_bin;

architecture Behavioral of bcd_2_bin is

begin

bin_out <= (bcd_in_0 * "01")  --multiply by 1
                + (bcd_in_10 * "1010") --multiply by 10
                + (bcd_in_100 * "1100100") --multiply by 100
                + (bcd_in_1000 * "1111101000"); --multiply by 1000

end Behavioral;
