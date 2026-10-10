library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity z_flag is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC; -- Synchronous Active-High Reset
           EN    : in  STD_LOGIC; -- Write Enable
           D_IN  : in  STD_LOGIC; -- Zero Flag input from ALU
           Q_OUT : out STD_LOGIC); -- Zero Flag output to Control Unit / PC
end z_flag;

architecture Structural of z_flag is

    component register_1bit
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC;
               Q     : out STD_LOGIC);
    end component;

begin

    REG_Z: register_1bit port map (
        CLK   => CLK,
        RESET => RESET,
        EN    => EN,
        D     => D_IN,
        Q     => Q_OUT
    );

end Structural;