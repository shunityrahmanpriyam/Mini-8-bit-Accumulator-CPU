library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( OPCODE  : in  STD_LOGIC_VECTOR (3 downto 0);
           ZERO    : in  STD_LOGIC;
           PC_INC  : out STD_LOGIC;
           PC_LOAD : out STD_LOGIC;
           ACC_EN  : out STD_LOGIC;
           ALU_SEL : out STD_LOGIC_VECTOR (3 downto 0));
end control_unit;

architecture Behavioral of control_unit is

    signal is_jz, is_jz_taken : STD_LOGIC;

begin

    -- ALU Operation Select matches Opcode
    ALU_SEL <= OPCODE;

    -- Decode JZ Opcode ("0011")
    is_jz <= '1' when OPCODE = "0011" else '0';

    -- JZ Taken when Opcode is JZ AND Zero Flag is 1
    is_jz_taken <= is_jz and ZERO;

    -- Control Signals Logic
    PC_LOAD <= is_jz_taken;
    PC_INC  <= not is_jz_taken; -- Increment PC unless JZ is taken

    -- Accumulator Enable for LDI(0000), ADD(0001), AND(0010), NOT(0100)
    ACC_EN <= '1' when (OPCODE = "0000" or OPCODE = "0001" or OPCODE = "0010" or OPCODE = "0100") else '0';

end Behavioral;