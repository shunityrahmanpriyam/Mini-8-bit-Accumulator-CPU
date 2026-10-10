library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch is
    Port ( D    : in  STD_LOGIC;
           EN   : in  STD_LOGIC;
           Q    : out STD_LOGIC;
           Qbar : out STD_LOGIC);
end d_latch;

architecture Structural of d_latch is

    component nand_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component not_gate
        Port ( A : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    signal d_not  : STD_LOGIC;
    signal nand1  : STD_LOGIC;
    signal nand2  : STD_LOGIC;
    signal q_int  : STD_LOGIC := '0'; -- Explicit initialization for simulator
    signal qb_int : STD_LOGIC := '1'; -- Explicit initialization for simulator

begin

    U1: not_gate  port map (A => D, Y => d_not);
    U2: nand_gate port map (A => D, B => EN, Y => nand1);
    U3: nand_gate port map (A => d_not, B => EN, Y => nand2);

    -- Cross-coupled feedback
    U4: nand_gate port map (A => nand1, B => qb_int, Y => q_int);
    U5: nand_gate port map (A => nand2, B => q_int, Y => qb_int);

    Q    <= q_int;
    Qbar <= qb_int;

end Structural;