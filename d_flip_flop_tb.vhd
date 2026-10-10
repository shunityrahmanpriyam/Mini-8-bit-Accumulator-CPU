library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop_tb is
end d_flip_flop_tb;

architecture Behavioral of d_flip_flop_tb is

    component d_flip_flop
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1'; -- Initialized with Active Reset to purge 'U'
    signal EN    : std_logic := '1';
    signal D     : std_logic := '0';
    signal Q     : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: d_flip_flop PORT MAP (
          CLK => CLK,
          RESET => RESET,
          EN => EN,
          D => D,
          Q => Q
        );

    -- Clock Generation
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Step 1: Force Reset on 1st Clock Edge (0 - 10 ns)
        RESET <= '1'; EN <= '1'; D <= '0';
        wait for CLK_PERIOD;

        -- Step 2: Write '1' on 2nd Clock Edge (10 - 20 ns)
        RESET <= '0'; EN <= '1'; D <= '1';
        wait for CLK_PERIOD;

        -- Step 3: Enable '0' -> Hold State (20 - 30 ns)
        EN <= '0'; D <= '0';
        wait for CLK_PERIOD;

        -- Step 4: Write '0' on 4th Clock Edge (30 - 40 ns)
        EN <= '1'; D <= '0';
        wait for CLK_PERIOD;

        -- Step 5: Reset Priority Test (40 - 50 ns)
        RESET <= '1'; EN <= '1'; D <= '1';
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;