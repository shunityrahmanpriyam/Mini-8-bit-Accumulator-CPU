library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit_tb is
end control_unit_tb;

architecture Behavioral of control_unit_tb is

    component control_unit
        Port ( OPCODE  : in  STD_LOGIC_VECTOR (3 downto 0);
               ZERO    : in  STD_LOGIC;
               PC_INC  : out STD_LOGIC;
               PC_LOAD : out STD_LOGIC;
               ACC_EN  : out STD_LOGIC;
               ALU_SEL : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal OPCODE  : std_logic_vector(3 downto 0) := "0000";
    signal ZERO    : std_logic := '0';
    signal PC_INC  : std_logic;
    signal PC_LOAD : std_logic;
    signal ACC_EN  : std_logic;
    signal ALU_SEL : std_logic_vector(3 downto 0);

begin

    uut: control_unit PORT MAP (
          OPCODE  => OPCODE,
          ZERO    => ZERO,
          PC_INC  => PC_INC,
          PC_LOAD => PC_LOAD,
          ACC_EN  => ACC_EN,
          ALU_SEL => ALU_SEL
        );

    stim_proc: process
    begin
        -- Step 1: LDI (0000)
        OPCODE <= "0000"; ZERO <= '0'; wait for 10 ns;

        -- Step 2: ADD (0001)
        OPCODE <= "0001"; ZERO <= '0'; wait for 10 ns;

        -- Step 3: JZ (0011) with ZERO = 0 (Branch Not Taken)
        OPCODE <= "0011"; ZERO <= '0'; wait for 10 ns;

        -- Step 4: JZ (0011) with ZERO = 1 (Branch Taken)
        OPCODE <= "0011"; ZERO <= '1'; wait for 10 ns;

        -- Step 5: NOT (0100)
        OPCODE <= "0100"; ZERO <= '0'; wait for 10 ns;

        wait;
    end process;

end Behavioral;