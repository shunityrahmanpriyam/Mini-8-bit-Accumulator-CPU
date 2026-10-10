library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity z_flag_tb is
end z_flag_tb;

architecture Behavioral of z_flag_tb is

    component z_flag
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D_IN  : in  STD_LOGIC;
               Q_OUT : out STD_LOGIC);
    end component;

    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal EN    : std_logic := '0';
    signal D_IN  : std_logic := '0';
    signal Q_OUT : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: z_flag PORT MAP (
          CLK   => CLK,
          RESET => RESET,
          EN    => EN,
          D_IN  => D_IN,
          Q_OUT => Q_OUT
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
        -- Step 1: Initial Reset (0 - 10 ns) -> Z = 0
        RESET <= '1'; EN <= '1'; D_IN <= '1';
        wait for CLK_PERIOD;

        -- Step 2: Set Zero Flag (ALU result was 0) (10 - 20 ns) -> Z = 1
        RESET <= '0'; EN <= '1'; D_IN <= '1';
        wait for CLK_PERIOD;

        -- Step 3: Hold Zero Flag (EN = 0) (20 - 30 ns) -> Z holds 1
        EN <= '0'; D_IN <= '0';
        wait for CLK_PERIOD;

        -- Step 4: Clear Zero Flag (ALU result non-zero) (30 - 40 ns) -> Z = 0
        EN <= '1'; D_IN <= '0';
        wait for CLK_PERIOD;

        -- Step 5: Reset Priority Test (40 - 50 ns) -> Z clears to 0
        RESET <= '1'; EN <= '1'; D_IN <= '1';
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;