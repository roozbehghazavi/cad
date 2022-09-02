library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity num_ones_for is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           ones : out  STD_LOGIC_VECTOR (4 downto 0));
end num_ones_for;

architecture Behavioral of num_ones_for is

begin

process(A)
variable count : unsigned(4 downto 0) := "00000";
begin
    count := "00000";   --initialize count variable.
    for i in 0 to 15 loop   --for all the bits.
        count := count + ("0000" & A(i));   --Add the bit to the count.
    end loop;
    ones <= std_logic_vector(count);    --assign the count to output.
end process;

end Behavioral;
