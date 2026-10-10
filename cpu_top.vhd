library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    Port ( CLK        : in  STD_LOGIC;
           RESET      : in  STD_LOGIC;
           ACC_OUT    : out STD_LOGIC_VECTOR (7 downto 0);
           PC_OUT     : out STD_LOGIC_VECTOR (3 downto 0);
           ZERO_OUT   : out STD_LOGIC);
end cpu_top;

architecture Structural of cpu_top is

    -- Component Declarations
    component pc
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               INC   : in  STD_LOGIC;
               LOAD  : in  STD_LOGIC;
               D_IN  : in  STD_LOGIC_VECTOR (3 downto 0);
               Q_OUT : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component rom
        Port ( ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
               DATA : out STD_LOGIC_VECTOR (11 downto 0));
    end component;

    component control_unit
        Port ( OPCODE  : in  STD_LOGIC_VECTOR (3 downto 0);
               ZERO    : in  STD_LOGIC;
               PC_INC  : out STD_LOGIC;
               PC_LOAD : out STD_LOGIC;
               ACC_EN  : out STD_LOGIC;
               ALU_SEL : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component alu
        Port ( A        : in  STD_LOGIC_VECTOR (7 downto 0);
               B        : in  STD_LOGIC_VECTOR (7 downto 0);
               ALU_Sel  : in  STD_LOGIC_VECTOR (3 downto 0);
               ALU_Out  : out STD_LOGIC_VECTOR (7 downto 0);
               ZERO     : out STD_LOGIC);
    end component;

    component acc
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D_IN  : in  STD_LOGIC_VECTOR (7 downto 0);
               Q_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component z_flag
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               EN    : in  STD_LOGIC;
               D_IN  : in  STD_LOGIC;
               Q_OUT : out STD_LOGIC);
    end component;

    -- Internal Interconnect Signals
    signal pc_current  : STD_LOGIC_VECTOR (3 downto 0);
    signal rom_instruction : STD_LOGIC_VECTOR (11 downto 0);
    signal opcode      : STD_LOGIC_VECTOR (3 downto 0);
    signal operand     : STD_LOGIC_VECTOR (7 downto 0);
    
    signal pc_inc_sig  : STD_LOGIC;
    signal pc_load_sig : STD_LOGIC;
    signal acc_en_sig  : STD_LOGIC;
    signal alu_sel_sig : STD_LOGIC_VECTOR (3 downto 0);
    
    signal alu_result  : STD_LOGIC_VECTOR (7 downto 0);
    signal alu_zero    : STD_LOGIC;
    signal acc_data    : STD_LOGIC_VECTOR (7 downto 0);
    signal zero_flag_q : STD_LOGIC;

begin

    -- Split Instruction Word
    opcode  <= rom_instruction(11 downto 8);
    operand <= rom_instruction(7 downto 0);

    -- Instantiation 1: Program Counter
    U_PC: pc port map (
        CLK   => CLK,
        RESET => RESET,
        INC   => pc_inc_sig,
        LOAD  => pc_load_sig,
        D_IN  => operand(3 downto 0),
        Q_OUT => pc_current
    );

    -- Instantiation 2: Program ROM (Instruction Memory)
    U_ROM: rom port map (
        ADDR => pc_current,
        DATA => rom_instruction
    );

    -- Instantiation 3: Control Unit
    U_CU: control_unit port map (
        OPCODE  => opcode,
        ZERO    => zero_flag_q,
        PC_INC  => pc_inc_sig,
        PC_LOAD => pc_load_sig,
        ACC_EN  => acc_en_sig,
        ALU_SEL => alu_sel_sig
    );

    -- Instantiation 4: Accumulator Register
    U_ACC: acc port map (
        CLK   => CLK,
        RESET => RESET,
        EN    => acc_en_sig,
        D_IN  => alu_result,
        Q_OUT => acc_data
    );

    -- Instantiation 5: Arithmetic Logic Unit
    U_ALU: alu port map (
        A        => acc_data,
        B        => operand,
        ALU_Sel  => alu_sel_sig,
        ALU_Out  => alu_result,
        ZERO     => alu_zero
    );

    -- Instantiation 6: Zero Flag Register
    U_ZF: z_flag port map (
        CLK   => CLK,
        RESET => RESET,
        EN    => acc_en_sig,
        D_IN  => alu_zero,
        Q_OUT => zero_flag_q
    );

    -- Top-level Output Assignments
    ACC_OUT  <= acc_data;
    PC_OUT   <= pc_current;
    ZERO_OUT <= zero_flag_q;

end Structural;