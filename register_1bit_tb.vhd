library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1bit_tb is
end register_1bit_tb;

architecture Behavioral of register_1bit_tb is

    component register_1bit
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal EN    : std_logic := '0';
    signal D     : std_logic := '0';
    signal Q     : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: register_1bit PORT MAP (
          CLK => CLK,
          RESET => RESET,
          EN => EN,
          D => D,
          Q => Q
        );

    -- Clock process
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Step 1: Initial Reset (0 - 10 ns)
        RESET <= '1'; EN <= '1'; D <= '0';
        wait for CLK_PERIOD;

        -- Step 2: Write '1' (10 - 20 ns)
        RESET <= '0'; EN <= '1'; D <= '1';
        wait for CLK_PERIOD;

        -- Step 3: Hold State - EN = 0 (20 - 30 ns)
        EN <= '0'; D <= '0';
        wait for CLK_PERIOD;

        -- Step 4: Write '0' (30 - 40 ns)
        EN <= '1'; D <= '0';
        wait for CLK_PERIOD;

        -- Step 5: Reset Priority Test (40 - 50 ns)
        RESET <= '1'; EN <= '1'; D <= '1';
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;