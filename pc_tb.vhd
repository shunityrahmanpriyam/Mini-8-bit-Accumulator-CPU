library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_tb is
end pc_tb;

architecture Behavioral of pc_tb is

    component pc
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               INC   : in  STD_LOGIC;
               LOAD  : in  STD_LOGIC;
               D_IN  : in  STD_LOGIC_VECTOR (3 downto 0);
               Q_OUT : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal INC   : std_logic := '0';
    signal LOAD  : std_logic := '0';
    signal D_IN  : std_logic_vector(3 downto 0) := "0000";
    signal Q_OUT : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: pc PORT MAP (
          CLK   => CLK,
          RESET => RESET,
          INC   => INC,
          LOAD  => LOAD,
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
        -- Step 1: Initial Reset (0 - 10 ns) -> PC = 0000
        RESET <= '1'; INC <= '0'; LOAD <= '0'; D_IN <= "0000";
        wait for CLK_PERIOD;

        -- Step 2: Increment PC (10 - 20 ns) -> PC = 0001
        RESET <= '0'; INC <= '1'; LOAD <= '0';
        wait for CLK_PERIOD;

        -- Step 3: Increment PC again (20 - 30 ns) -> PC = 0010
        INC <= '1'; LOAD <= '0';
        wait for CLK_PERIOD;

        -- Step 4: Jump Operation JZ (30 - 40 ns) -> Load Target Addr 0110 (6)
        INC <= '0'; LOAD <= '1'; D_IN <= "0110";
        wait for CLK_PERIOD;

        -- Step 5: Continue Increment from Jump Target (40 - 50 ns) -> PC = 0111 (7)
        INC <= '1'; LOAD <= '0';
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;