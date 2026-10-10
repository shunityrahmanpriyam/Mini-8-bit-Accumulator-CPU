library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC; -- Synchronous Active-High Reset
           EN    : in  STD_LOGIC; -- Write Enable
           D     : in  STD_LOGIC_VECTOR (7 downto 0);
           Q     : out STD_LOGIC_VECTOR (7 downto 0));
end register_8bit;

architecture Structural of register_8bit is

    component register_1bit
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

begin

    -- Instantiate 8 instances of 1-bit register using generate loop
    GEN_REG: for i in 0 to 7 generate
        REG_I: register_1bit port map (
            CLK   => CLK,
            RESET => RESET,
            EN    => EN,
            D     => D(i),
            Q     => Q(i)
        );
    end generate GEN_REG;

end Structural;