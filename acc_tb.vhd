library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_tb is
end acc_tb;

architecture Behavioral of acc_tb is

    component acc
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D_IN  : in  STD_LOGIC_VECTOR (7 downto 0);
               Q_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal EN    : std_logic := '0';
    signal D_IN  : std_logic_vector(7 downto 0) := "00000000";
    signal Q_OUT : std_logic_vector(7 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: acc PORT MAP (
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
        -- Step 1: Synchronous Reset (0 - 10 ns) -> ACC = 00000000
        RESET <= '1'; EN <= '1'; D_IN <= "11111111";
        wait for CLK_PERIOD;

        -- Step 2: Load Immediate Data 5 (LDI 5) (10 - 20 ns) -> ACC = 00000101
        RESET <= '0'; EN <= '1'; D_IN <= "00000101";
        wait for CLK_PERIOD;

        -- Step 3: Hold State - Input changes but EN = 0 (20 - 30 ns) -> ACC holds 00000101
        EN <= '0'; D_IN <= "00001000";
        wait for CLK_PERIOD;

        -- Step 4: Store ALU Result 8 (ADD Result) (30 - 40 ns) -> ACC = 00001000
        EN <= '1'; D_IN <= "00001000";
        wait for CLK_PERIOD;

        -- Step 5: Reset Priority Test (40 - 50 ns) -> ACC clears to 00000000
        RESET <= '1'; EN <= '1'; D_IN <= "11111111";
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;