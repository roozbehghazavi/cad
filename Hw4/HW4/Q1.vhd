entity n_in_1_out_xor_gate is
    generic(
       bits                 : integer
    );
    port (
        i: in std_logic;
        clk : in std_logic;
        n_in                : in  std_logic(bits-1 downto 0);
        xor_gate_out        : out std_logic
    ); 
end n_in_1_out_xor_gate;

architecture n_in_1_out_xor_gate of n_in_1_out_xor_gate is
begin
    process(clk) is  
    variable tmp : std_logic_vector(n-1 downto 0);
    variable ctr : integer := 0;
   
    begin
        if rising_edge(clk) then
            ctr := ctr + 1; 

      if(ctr = n) then
            output <= tmp;
            end if;
        end if;
    end process;
end n_in_1_out_xor_gate;