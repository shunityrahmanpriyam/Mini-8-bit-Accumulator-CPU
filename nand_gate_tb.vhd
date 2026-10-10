library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate_tb is
-- Testbench entities do not have ports
end nand_gate_tb;

architecture Behavioral of nand_gate_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component nand_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;
    
    -- Inputs
    signal A : std_logic := '0';
    signal B : std_logic := '0';

    -- Outputs
    signal Y : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: nand_gate PORT MAP (
          A => A,
          B => B,
          Y => Y
        );

    -- Stimulus process
    stim_proc: process
    begin		
        -- Test Case 1: 0 NAND 0 = 1
        A <= '0'; B <= '0';
        wait for 10 ns;
        
        -- Test Case 2: 0 NAND 1 = 1
        A <= '0'; B <= '1';
        wait for 10 ns;

        -- Test Case 3: 1 NAND 0 = 1
        A <= '1'; B <= '0';
        wait for 10 ns;

        -- Test Case 4: 1 NAND 1 = 0
        A <= '1'; B <= '1';
        wait for 10 ns;

        -- End Simulation
        wait;
    end process;

end Behavioral;