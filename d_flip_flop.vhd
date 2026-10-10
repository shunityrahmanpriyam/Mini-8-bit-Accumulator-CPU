library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC; -- Synchronous Active-High Reset
           EN    : in  STD_LOGIC;
           D     : in  STD_LOGIC;
           Q     : out STD_LOGIC);
end d_flip_flop;

architecture Structural of d_flip_flop is

    component d_latch
        Port ( D    : in  STD_LOGIC;
               EN   : in  STD_LOGIC;
               Q    : out STD_LOGIC;
               Qbar : out STD_LOGIC);
    end component;

    component not_gate
        Port ( A : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component and_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component or_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    signal reset_not   : STD_LOGIC;
    signal en_not      : STD_LOGIC;
    signal d_new_path  : STD_LOGIC;
    signal d_old_path  : STD_LOGIC;
    signal d_mux       : STD_LOGIC;
    signal d_filtered  : STD_LOGIC;
    signal clk_not     : STD_LOGIC;
    signal master_q    : STD_LOGIC := '0';
    signal master_qb   : STD_LOGIC := '1';
    signal slave_q     : STD_LOGIC := '0';
    signal slave_qb    : STD_LOGIC := '1';

begin

    -- Synchronous Reset & Enable Logic
    U_en_not:    not_gate port map (A => EN, Y => en_not);
    U_d_new:     and_gate port map (A => D, B => EN, Y => d_new_path);
    U_d_old:     and_gate port map (A => slave_q, B => en_not, Y => d_old_path);
    U_d_mux:     or_gate  port map (A => d_new_path, B => d_old_path, Y => d_mux);

    U_rst_not:   not_gate port map (A => RESET, Y => reset_not);
    U_d_filter:  and_gate port map (A => d_mux, B => reset_not, Y => d_filtered);

    -- Clock Inverter
    U_clk_not:   not_gate port map (A => CLK, Y => clk_not);

    -- Master Latch (Active on Clock Low)
    Master: d_latch port map (D => d_filtered, EN => clk_not, Q => master_q, Qbar => master_qb);

    -- Slave Latch (Active on Clock High)
    Slave:  d_latch port map (D => master_q, EN => CLK, Q => slave_q, Qbar => slave_qb);

    Q <= slave_q;

end Structural;