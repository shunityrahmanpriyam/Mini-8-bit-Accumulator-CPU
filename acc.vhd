library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC; -- Synchronous Active-High Reset
           EN    : in  STD_LOGIC; -- Write Enable (Accumulator Load)
           D_IN  : in  STD_LOGIC_VECTOR (7 downto 0); -- Data Input (from ALU / ROM)
           Q_OUT : out STD_LOGIC_VECTOR (7 downto 0)); -- Data Output to ALU/Bus
end acc;

architecture Structural of acc is

    component register_8bit
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC_VECTOR (7 downto 0);
               Q     : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin

    -- Structural instantiation of the 8-bit Register
    REG_ACC: register_8bit port map (
        CLK   => CLK,
        RESET => RESET,
        EN    => EN,
        D     => D_IN,
        Q     => Q_OUT
    );

end Structural;