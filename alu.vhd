library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port ( A        : in  STD_LOGIC_VECTOR (7 downto 0); -- Accumulator Input
           B        : in  STD_LOGIC_VECTOR (7 downto 0); -- Operand / ROM Input
           ALU_Sel  : in  STD_LOGIC_VECTOR (3 downto 0); -- Opcode
           ALU_Out  : out STD_LOGIC_VECTOR (7 downto 0); -- ALU Result
           ZERO     : out STD_LOGIC);                    -- Zero Flag Output
end alu;

architecture Structural of alu is

    component full_adder_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               Cin  : in  STD_LOGIC;
               Sum  : out STD_LOGIC_VECTOR (7 downto 0);
               Cout : out STD_LOGIC);
    end component;

    component and_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    component not_gate
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    signal add_result : STD_LOGIC_VECTOR (7 downto 0);
    signal and_result : STD_LOGIC_VECTOR (7 downto 0);
    signal not_result : STD_LOGIC_VECTOR (7 downto 0);
    signal res_internal: STD_LOGIC_VECTOR (7 downto 0);
    signal carry_dummy: STD_LOGIC;

    -- NOR tree signals for Zero Detection
    signal or1, or2, or3, or4, or5, or6, or_final : STD_LOGIC;

begin

    -- 8-bit Adder Instantiation
    FA8: full_adder_8bit port map (
        A    => A,
        B    => B,
        Cin  => '0',
        Sum  => add_result,
        Cout => carry_dummy
    );

    -- Bitwise AND Instantiation
    GEN_AND: for i in 0 to 7 generate
        U_AND: and_gate port map (A => A(i), B => B(i), Y => and_result(i));
    end generate GEN_AND;

    -- Bitwise NOT Instantiation (Fixed: Only input A used)
    GEN_NOT: for i in 0 to 7 generate
        U_NOT: not_gate port map (A => A(i), Y => not_result(i));
    end generate GEN_NOT;

    -- MUX Selection logic based on Opcode (ALU_Sel)
    res_internal <= B          when ALU_Sel = "0000" else -- LDI Pass-through
                    add_result when ALU_Sel = "0001" else -- ADD
                    and_result when ALU_Sel = "0010" else -- AND
                    not_result when ALU_Sel = "0100" else -- NOT
                    "00000000";

    ALU_Out <= res_internal;

    -- Structural Zero Flag Generator: NOR(res_internal[0..7])
    U_or1: or_gate port map (A => res_internal(0), B => res_internal(1), Y => or1);
    U_or2: or_gate port map (A => res_internal(2), B => res_internal(3), Y => or2);
    U_or3: or_gate port map (A => res_internal(4), B => res_internal(5), Y => or3);
    U_or4: or_gate port map (A => res_internal(6), B => res_internal(7), Y => or4);
    
    U_or5: or_gate port map (A => or1, B => or2, Y => or5);
    U_or6: or_gate port map (A => or3, B => or4, Y => or6);
    U_orf: or_gate port map (A => or5, B => or6, Y => or_final);

    -- ZERO = NOT (OR_FINAL) (Fixed: Only input A used)
    U_zero_not: not_gate port map (A => or_final, Y => ZERO);

end Structural;