library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
    Port ( ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
           DATA : out STD_LOGIC_VECTOR (11 downto 0));
end rom;

architecture Behavioral of rom is

    type rom_array is array (0 to 15) of STD_LOGIC_VECTOR(11 downto 0);
    
    -- Instruction Set 0 Mapping:
    -- 0000: LDI (Load Immediate)
    -- 0001: ADD (Add)
    -- 0010: AND (Bitwise AND)
    -- 0011: JZ  (Jump if Zero)
    -- 0100: NOT (Bitwise NOT)
    
    constant ROM_DATA : rom_array := (
        0  => "0000" & "00000101", -- LDI 5   (ACC = 5)
        1  => "0001" & "00000011", -- ADD 3   (ACC = 5 + 3 = 8)
        2  => "0010" & "00001111", -- AND 15  (ACC = 8 AND 15 = 8)
        3  => "0100" & "00000000", -- NOT     (ACC = NOT 8)
        4  => "0011" & "00000110", -- JZ 6    (Jump to Addr 6 if Z=1)
        5  => "0000" & "00000001", -- LDI 1   (Executed if JZ fails)
        6  => "0000" & "00000000", -- LDI 0   (ACC = 0, sets Z=1)
        7  => "0011" & "00001010", -- JZ 10   (Jump to Addr 10)
        8  => "0000" & "00000000", -- NOP / Clear
        9  => "0000" & "00000000", -- NOP
        10 => "0000" & "00001010", -- LDI 10  (Target of JZ)
        11 => "0000" & "00000000", -- NOP
        12 => "0000" & "00000000", -- NOP
        13 => "0000" & "00000000", -- NOP
        14 => "0000" & "00000000", -- NOP
        15 => "0000" & "00000000"  -- NOP
    );

begin

    DATA <= ROM_DATA(to_integer(unsigned(ADDR)));

end Behavioral;