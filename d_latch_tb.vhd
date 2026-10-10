library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch_tb is
end d_latch_tb;

architecture Behavioral of d_latch_tb is

    component d_latch
        Port ( D    : in  STD_LOGIC;
               EN   : in  STD_LOGIC;
               Q    : out STD_LOGIC;
               Qbar : out STD_LOGIC);
    end component;

    signal D    : std_logic := '0';
    signal EN   : std_logic := '0';
    signal Q    : std_logic;
    signal Qbar : std_logic;

begin

    uut: d_latch PORT MAP (
          D => D,
          EN => EN,
          Q => Q,
          Qbar => Qbar
        );

    stim_proc: process
    begin
        -- Step 1: Initialize Latch (Set initial known state with EN = 1)
        EN <= '1'; D <= '0';
        wait for 10 ns;

        -- Step 2: EN = 0, D = 1 (Latch holds '0')
        EN <= '0'; D <= '1';
        wait for 10 ns;

        -- Step 3: EN = 1, D = 1 (Latch updates to '1')
        EN <= '1'; D <= '1';
        wait for 10 ns;

        -- Step 4: EN = 1, D = 0 (Latch updates to '0')
        EN <= '1'; D <= '0';
        wait for 10 ns;

        -- Step 5: EN = 0, D = 1 (Latch holds previous '0')
        EN <= '0'; D <= '1';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;