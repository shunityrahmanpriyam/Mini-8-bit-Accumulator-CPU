library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rom_tb is
end rom_tb;

architecture Behavioral of rom_tb is

    component rom
        Port ( ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
               DATA : out STD_LOGIC_VECTOR (11 downto 0));
    end component;

    signal ADDR : std_logic_vector(3 downto 0) := "0000";
    signal DATA : std_logic_vector(11 downto 0);

begin

    uut: rom PORT MAP (
          ADDR => ADDR,
          DATA => DATA
        );

    stim_proc: process
    begin
        -- Read Address 0 (LDI 5)
        ADDR <= "0000"; wait for 10 ns;

        -- Read Address 1 (ADD 3)
        ADDR <= "0001"; wait for 10 ns;

        -- Read Address 2 (AND 15)
        ADDR <= "0010"; wait for 10 ns;

        -- Read Address 3 (NOT)
        ADDR <= "0011"; wait for 10 ns;

        -- Read Address 4 (JZ 6)
        ADDR <= "0100"; wait for 10 ns;

        -- Read Address 10 (LDI 10)
        ADDR <= "1010"; wait for 10 ns;

        wait;
    end process;

end Behavioral;