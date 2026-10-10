library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1bit is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC; -- Synchronous Active-High Reset
           EN    : in  STD_LOGIC; -- Write Enable
           D     : in  STD_LOGIC;
           Q     : out STD_LOGIC);
end register_1bit;

architecture Structural of register_1bit is

    component d_flip_flop
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

begin

    -- Instantiate the D Flip-Flop
    DFF0: d_flip_flop port map (
        CLK   => CLK,
        RESET => RESET,
        EN    => EN,
        D     => D,
        Q     => Q
    );

end Structural;