LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY decoder IS
    PORT (
			INS : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			S  : OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		   PC_INCR  : OUT  STD_LOGIC;
		   PC_WR  : OUT  STD_LOGIC;
		   RAM_read  : OUT  STD_LOGIC;
		   RAM_write  : OUT  STD_LOGIC;
		   WE  : OUT  STD_LOGIC;
		   RA  : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		   RB	: OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		   RW	: OUT	 STD_LOGIC_VECTOR(1 DOWNTO 0);
		   M	: OUT  STD_LOGIC;
		   sel1: OUT  STD_LOGIC;
		   sel2: OUT  STD_LOGIC;
		   sel3: OUT  STD_LOGIC;
		   GATE: OUT  STD_LOGIC;
			EXOP 	: OUT  STD_LOGIC;
			EXPC : OUT STD_LOGIC
);
END decoder;

ARCHITECTURE behav OF decoder IS
signal OP : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
OP <= INS(15)&INS(14)&INS(13)&INS(12);
	PROCESS(OP)
	 BEGIN
	  CASE OP IS
			WHEN "0000" => S <="0000";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(7)&INS(6);M<='0';sel1<='1';sel2<='0';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';
			WHEN "0001" => S <="0000";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='1';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--$rt = $rs | imm 
			WHEN "0010" => S <="0001";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='1';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--$rt = $rs & imm 
			WHEN "0011" => S <="0010";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='1';sel3<='0';GATE<='0';EXOP<='1';EXPC<='1';--$rt = $rs + imm 
			WHEN "0100" => S <="0010";PC_INCR<='1';PC_WR<='0';RAM_read<='1';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='1';sel3<='1';GATE<='0';EXOP<='1';EXPC<='1';--$rt = MEM[$rs + imm]
			WHEN "0101" => S <="0010";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='1';WE<='0';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='1';sel3<='1';GATE<='0';EXOP<='1';EXPC<='1';--MEM[$rs+imm] = $rt
			WHEN "0110" => S <="0100";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='0';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(7)&INS(6);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='0';EXOP<='1';EXPC<='1';--bne 
			WHEN "0111" => S <="0101";PC_INCR<='1';PC_WR<='1';RAM_read<='0';RAM_write<='0';WE<='0';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--jump
			WHEN "1000" => S <="1111";PC_INCR<='0';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='0';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='1';EXOP<='0';EXPC<='1';--halt
			WHEN "1001" => S <="0110";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(7)&INS(6);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--$rd = $rs << $rt
			WHEN "1010" => S <="0111";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(7)&INS(6);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--$rd = $rs >> $rt
			WHEN "1011" => S <="1000";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(7)&INS(6);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--$rd = $rs >> $rt 算术右移
			WHEN "1100" => S <="1001";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(7)&INS(6);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--$rd = ($rs < $rt) ? 1 :0
			WHEN "1101" => S <="1010";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='1';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='1';sel3<='0';GATE<='0';EXOP<='0';EXPC<='1';--$rt = imm << 8
			WHEN OTHERS => S <="1111";PC_INCR<='1';PC_WR<='0';RAM_read<='0';RAM_write<='0';WE<='0';RA<=INS(11)&INS(10);RB<=INS(9)&INS(8);RW<=INS(9)&INS(8);M<='0';sel1<='0';sel2<='0';sel3<='0';GATE<='1';EXOP<='0';EXPC<='1';
END CASE;
END PROCESS;
END behav;
	  
