library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit_tb is
end register_8bit_tb;

architecture Behavioral of register_8bit_tb is

    component register_8bit
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC_VECTOR (7 downto 0);
               Q     : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal EN    : std_logic := '0';
    signal D     : std_logic_vector(7 downto 0) := "00000000";
    signal Q     : std_logic_vector(7 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: register_8bit PORT MAP (
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
        -- Step 1: Synchronous Reset (0 - 10 ns)
        RESET <= '1'; EN <= '1'; D <= "11111111";
        wait for CLK_PERIOD;

        -- Step 2: Write Data 0x05 / 5 (10 - 20 ns)
        RESET <= '0'; EN <= '1'; D <= "00000101";
        wait for CLK_PERIOD;

        -- Step 3: Hold State - Change input while EN = 0 (20 - 30 ns)
        EN <= '0'; D <= "11110000";
        wait for CLK_PERIOD;

        -- Step 4: Write Data 0xFF / 255 (30 - 40 ns)
        EN <= '1'; D <= "11111111";
        wait for CLK_PERIOD;

        -- Step 5: Test Reset Priority (40 - 50 ns)
        RESET <= '1'; EN <= '1'; D <= "10101010";
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;