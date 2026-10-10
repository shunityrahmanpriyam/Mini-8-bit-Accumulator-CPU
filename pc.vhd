library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC; -- Synchronous Active-High Reset
           INC   : in  STD_LOGIC; -- Increment PC (PC + 1)
           LOAD  : in  STD_LOGIC; -- Jump Load Enable
           D_IN  : in  STD_LOGIC_VECTOR (3 downto 0); -- Jump Target Address
           Q_OUT : out STD_LOGIC_VECTOR (3 downto 0));
end pc;

architecture Structural of pc is

    component register_8bit
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D     : in  STD_LOGIC_VECTOR (7 downto 0);
               Q     : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component full_adder_4bit
        Port ( A    : in  STD_LOGIC_VECTOR (3 downto 0);
               B    : in  STD_LOGIC_VECTOR (3 downto 0);
               Cin  : in  STD_LOGIC;
               Sum  : out STD_LOGIC_VECTOR (3 downto 0);
               Cout : out STD_LOGIC);
    end component;

    signal pc_current : STD_LOGIC_VECTOR (3 downto 0);
    signal pc_next    : STD_LOGIC_VECTOR (3 downto 0);
    signal pc_inc     : STD_LOGIC_VECTOR (3 downto 0);
    signal d_reg_in   : STD_LOGIC_VECTOR (7 downto 0);
    signal q_reg_out  : STD_LOGIC_VECTOR (7 downto 0);
    signal carry_dummy: STD_LOGIC;
    signal reg_en     : STD_LOGIC;

begin

    -- 4-bit Incrementer Logic: PC + 1
    Adder_Inst: full_adder_4bit port map (
        A    => pc_current,
        B    => "0000",
        Cin  => '1', -- Adds 1 to pc_current
        Sum  => pc_inc,
        Cout => carry_dummy
    );

    -- MUX logic: Select Next PC State (LOAD priority over INC)
    pc_next <= D_IN when LOAD = '1' else
               pc_inc when INC = '1' else
               pc_current;

    -- Enable register when INC = '1' or LOAD = '1'
    reg_en <= INC or LOAD;

    -- Standard 8-bit Register padded for 4-bit PC
    d_reg_in <= "0000" & pc_next;

    REG_Inst: register_8bit port map (
        CLK   => CLK,
        RESET => RESET,
        EN    => reg_en,
        D     => d_reg_in,
        Q     => q_reg_out
    );

    pc_current <= q_reg_out(3 downto 0);
    Q_OUT      <= pc_current;

end Structural;