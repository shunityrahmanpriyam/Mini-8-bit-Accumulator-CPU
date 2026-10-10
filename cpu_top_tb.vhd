library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top_tb is
end cpu_top_tb;

architecture Behavioral of cpu_top_tb is

    component cpu_top
        Port ( CLK        : in  STD_LOGIC;
               RESET      : in  STD_LOGIC;
               ACC_OUT    : out STD_LOGIC_VECTOR (7 downto 0);
               PC_OUT     : out STD_LOGIC_VECTOR (3 downto 0);
               ZERO_OUT   : out STD_LOGIC);
    end component;

    signal CLK      : std_logic := '0';
    signal RESET    : std_logic := '1';
    signal ACC_OUT  : std_logic_vector(7 downto 0);
    signal PC_OUT   : std_logic_vector(3 downto 0);
    signal ZERO_OUT : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: cpu_top PORT MAP (
          CLK      => CLK,
          RESET    => RESET,
          ACC_OUT  => ACC_OUT,
          PC_OUT   => PC_OUT,
          ZERO_OUT => ZERO_OUT
        );

    -- Clock Generation
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus Process: Executes Program pre-loaded in ROM
    stim_proc: process
    begin
        -- Step 1: System Reset (0 - 10 ns)
        RESET <= '1';
        wait for CLK_PERIOD;

        -- Step 2: Release Reset and execute instructions sequentially
        RESET <= '0';
        wait for 100 ns;

        wait;
    end process;

end Behavioral;