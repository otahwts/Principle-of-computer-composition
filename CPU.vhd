-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Full Version"
-- CREATED		"Fri Jun 17 20:27:14 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY CPU IS 
	PORT
	(
		switch :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC;
		RQF1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		RQF2 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		RQS1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		RQS2 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		RQT1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		RQT2 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END CPU;

ARCHITECTURE bdf_type OF CPU IS 

COMPONENT alu_16b
	PORT(M : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 S : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 bne : OUT STD_LOGIC;
		 F : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT seg7_16b
	PORT(Blank : IN STD_LOGIC;
		 Test : IN STD_LOGIC;
		 Data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 RQ1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 RQ2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT muxop2to1
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT extend
	PORT(EXOP : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 extend : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT decoder
	PORT(INS : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 PC_INCR : OUT STD_LOGIC;
		 PC_WR : OUT STD_LOGIC;
		 RAM_read : OUT STD_LOGIC;
		 RAM_write : OUT STD_LOGIC;
		 WE : OUT STD_LOGIC;
		 M : OUT STD_LOGIC;
		 sel1 : OUT STD_LOGIC;
		 sel2 : OUT STD_LOGIC;
		 sel3 : OUT STD_LOGIC;
		 GATE : OUT STD_LOGIC;
		 EXOP : OUT STD_LOGIC;
		 EXPC : OUT STD_LOGIC;
		 RA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 RB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 RW : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mun2to1
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT jicunqi
	PORT(clk : IN STD_LOGIC;
		 WE : IN STD_LOGIC;
		 busW : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 RA : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 RB : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 RW : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 busA : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 busB : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pc
	PORT(clk : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 LOAD_PC : IN STD_LOGIC;
		 INCR_PC : IN STD_LOGIC;
		 bne : IN STD_LOGIC;
		 Addr_Val_in : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 offset : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 PC_out : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT room
	PORT(clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT raam
	PORT(wren : IN STD_LOGIC;
		 rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT decoder0000
	PORT(OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	bne :  STD_LOGIC;
SIGNAL	Data :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	dizi :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	expc :  STD_LOGIC;
SIGNAL	extd :  STD_LOGIC;
SIGNAL	FS :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	halt :  STD_LOGIC;
SIGNAL	M :  STD_LOGIC;
SIGNAL	OP :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	pc_in :  STD_LOGIC;
SIGNAL	pc_write :  STD_LOGIC;
SIGNAL	ra :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	ram_read :  STD_LOGIC;
SIGNAL	ram_write :  STD_LOGIC;
SIGNAL	rb :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	rw :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	sel1 :  STD_LOGIC;
SIGNAL	sel2 :  STD_LOGIC;
SIGNAL	sel3 :  STD_LOGIC;
SIGNAL	we :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 



b2v_inst : alu_16b
PORT MAP(M => M,
		 A => SYNTHESIZED_WIRE_21,
		 B => SYNTHESIZED_WIRE_22,
		 S => SYNTHESIZED_WIRE_2,
		 bne => bne,
		 F => FS);


b2v_inst1 : seg7_16b
PORT MAP(Blank => SYNTHESIZED_WIRE_23,
		 Test => switch,
		 Data => FS,
		 RQ1 => RQF1,
		 RQ2 => RQF2);


b2v_inst10 : muxop2to1
PORT MAP(sel => sel1,
		 data0x => SYNTHESIZED_WIRE_4,
		 data1x => SYNTHESIZED_WIRE_5,
		 result => SYNTHESIZED_WIRE_2);


b2v_inst11 : extend
PORT MAP(EXOP => extd,
		 Data_in => OP(7 DOWNTO 0),
		 extend => SYNTHESIZED_WIRE_20);


b2v_inst13 : decoder
PORT MAP(INS => OP,
		 PC_INCR => pc_in,
		 PC_WR => pc_write,
		 RAM_read => ram_read,
		 RAM_write => ram_write,
		 WE => we,
		 M => M,
		 sel1 => sel1,
		 sel2 => sel2,
		 sel3 => sel3,
		 GATE => halt,
		 EXOP => extd,
		 EXPC => expc,
		 RA => ra,
		 RB => rb,
		 RW => rw,
		 S => SYNTHESIZED_WIRE_4);


SYNTHESIZED_WIRE_25 <= NOT(SYNTHESIZED_WIRE_24);



SYNTHESIZED_WIRE_23 <= NOT(switch);



b2v_inst16 : mun2to1
PORT MAP(sel => sel3,
		 data0x => FS,
		 data1x => SYNTHESIZED_WIRE_7,
		 result => Data);


b2v_inst17 : extend
PORT MAP(EXOP => expc,
		 Data_in => OP(7 DOWNTO 0),
		 extend => SYNTHESIZED_WIRE_13);


SYNTHESIZED_WIRE_24 <= SYNTHESIZED_WIRE_8 AND clock;


b2v_inst2 : seg7_16b
PORT MAP(Blank => SYNTHESIZED_WIRE_23,
		 Test => switch,
		 Data => SYNTHESIZED_WIRE_21,
		 RQ1 => RQS1,
		 RQ2 => RQS2);


b2v_inst20 : jicunqi
PORT MAP(clk => SYNTHESIZED_WIRE_25,
		 WE => we,
		 busW => Data,
		 RA => ra,
		 RB => rb,
		 RW => rw,
		 busA => SYNTHESIZED_WIRE_21,
		 busB => SYNTHESIZED_WIRE_26);


b2v_inst21 : pc
PORT MAP(clk => SYNTHESIZED_WIRE_24,
		 Reset => reset,
		 LOAD_PC => pc_write,
		 INCR_PC => pc_in,
		 bne => bne,
		 Addr_Val_in => OP(11 DOWNTO 0),
		 offset => SYNTHESIZED_WIRE_13,
		 PC_out => dizi);


b2v_inst3 : seg7_16b
PORT MAP(Blank => SYNTHESIZED_WIRE_23,
		 Test => switch,
		 Data => SYNTHESIZED_WIRE_22,
		 RQ1 => RQT1,
		 RQ2 => RQT2);


b2v_inst4 : room
PORT MAP(clock => SYNTHESIZED_WIRE_25,
		 address => dizi,
		 q => OP);


b2v_inst5 : raam
PORT MAP(wren => ram_write,
		 rden => ram_read,
		 clock => SYNTHESIZED_WIRE_25,
		 address => FS(7 DOWNTO 0),
		 data => SYNTHESIZED_WIRE_26,
		 q => SYNTHESIZED_WIRE_7);


b2v_inst6 : decoder0000
PORT MAP(OP => OP(2 DOWNTO 0),
		 S => SYNTHESIZED_WIRE_5);


b2v_inst8 : mun2to1
PORT MAP(sel => sel2,
		 data0x => SYNTHESIZED_WIRE_26,
		 data1x => SYNTHESIZED_WIRE_20,
		 result => SYNTHESIZED_WIRE_22);


SYNTHESIZED_WIRE_8 <= NOT(halt);



END bdf_type;