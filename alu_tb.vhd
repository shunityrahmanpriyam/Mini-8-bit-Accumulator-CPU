library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is

    component alu
        Port ( A        : in  STD_LOGIC_VECTOR (7 downto 0);
               B        : in  STD_LOGIC_VECTOR (7 downto 0);
               ALU_Sel  : in  STD_LOGIC_VECTOR (3 downto 0);
               ALU_Out  : out STD_LOGIC_VECTOR (7 downto 0);
               ZERO     : out STD_LOGIC);
    end component;

    signal A       : std_logic_vector(7 downto 0) := "00000000";
    signal B       : std_logic_vector(7 downto 0) := "00000000";
    signal ALU_Sel : std_logic_vector(3 downto 0) := "0000";
    signal ALU_Out : std_logic_vector(7 downto 0);
    signal ZERO    : std_logic;

begin

    uut: alu PORT MAP (
          A       => A,
          B       => B,
          ALU_Sel => ALU_Sel,
          ALU_Out => ALU_Out,
          ZERO    => ZERO
        );

    stim_proc: process
    begin
        -- Step 1: LDI operation (Opcode: 0000) -> Pass-through B (5)
        A <= "00000000"; B <= "00000101"; ALU_Sel <= "0000";
        wait for 10 ns;

        -- Step 2: ADD operation (Opcode: 0001) -> A(5) + B(3) = 8
        A <= "00000101"; B <= "00000011"; ALU_Sel <= "0001";
        wait for 10 ns;

        -- Step 3: AND operation (Opcode: 0010) -> A(8) AND B(15) = 8
        A <= "00001000"; B <= "00001111"; ALU_Sel <= "0010";
        wait for 10 ns;

        -- Step 4: NOT operation (Opcode: 0100) -> NOT A(00000000) = 11111111
        A <= "00000000"; B <= "00000000"; ALU_Sel <= "0100";
        wait for 10 ns;

        -- Step 5: Zero Flag Test -> LDI 0 (Opcode: 0000, B = 0) -> Out = 0, ZERO = 1
        A <= "00000000"; B <= "00000000"; ALU_Sel <= "0000";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;