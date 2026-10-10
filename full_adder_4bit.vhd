library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_4bit is
    Port ( A    : in  STD_LOGIC_VECTOR (3 downto 0);
           B    : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin  : in  STD_LOGIC;
           Sum  : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end full_adder_4bit;

architecture Structural of full_adder_4bit is

    component xor_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    component and_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC);
    end component;

    signal c : STD_LOGIC_VECTOR(4 downto 0);
    signal x1, a1, a2 : STD_LOGIC_VECTOR(3 downto 0);

begin
    c(0) <= Cin;

    GEN_FA: for i in 0 to 3 generate
        U_xor1: xor_gate port map (A => A(i), B => B(i), Y => x1(i));
        U_xor2: xor_gate port map (A => x1(i), B => c(i), Y => Sum(i));
        
        U_and1: and_gate port map (A => x1(i), B => c(i), Y => a1(i));
        U_and2: and_gate port map (A => A(i), B => B(i), Y => a2(i));
        U_or1:  or_gate  port map (A => a1(i), B => a2(i), Y => c(i+1));
    end generate GEN_FA;

    Cout <= c(4);

end Structural;