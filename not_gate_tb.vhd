library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate_tb is
-- Testbench entities do not have ports
end not_gate_tb;

architecture Behavioral of not_gate_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component not_gate
        Port ( A : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;
    
    -- Inputs
    signal A : std_logic := '0';

    -- Outputs
    signal Y : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: not_gate PORT MAP (
          A => A,
          Y => Y
        );

    -- Stimulus process
    stim_proc: process
    begin		
        -- Test Case 1: Input = 0
        A <= '0';
        wait for 10 ns;
        
        -- Test Case 2: Input = 1
        A <= '1';
        wait for 10 ns;

        -- End Simulation
        wait;
    end process;

end Behavioral;