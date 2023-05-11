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
-- CREATED		"Thu Jun 16 17:36:35 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY jicunqi IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		WE :  IN  STD_LOGIC;
		busW :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		RA :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		RB :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		RW :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		busA :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		busB :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END jicunqi;

ARCHITECTURE bdf_type OF jicunqi IS 

COMPONENT r0
	PORT(LOAD_R0 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 R0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT r1
	PORT(LOAD_R1 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 R1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT decd1to4
	PORT(data : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT r2
	PORT(LOAD_R2 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 R2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT r3
	PORT(LOAD_R3 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 R3 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux4to1
	PORT(data0x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	choicer0 :  STD_LOGIC;
SIGNAL	choicer1 :  STD_LOGIC;
SIGNAL	choicer2 :  STD_LOGIC;
SIGNAL	choicer3 :  STD_LOGIC;
SIGNAL	data_in :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	loadr0 :  STD_LOGIC;
SIGNAL	loadr1 :  STD_LOGIC;
SIGNAL	loadr2 :  STD_LOGIC;
SIGNAL	loadr3 :  STD_LOGIC;
SIGNAL	reg0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	reg1 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	reg2 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	reg3 :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 



b2v_inst : r0
PORT MAP(LOAD_R0 => loadr0,
		 clk => clk,
		 Data_in => data_in,
		 R0 => reg0);


b2v_inst1 : r1
PORT MAP(LOAD_R1 => loadr1,
		 clk => clk,
		 Data_in => data_in,
		 R1 => reg1);


b2v_inst10 : decd1to4
PORT MAP(data => RW,
		 eq0 => choicer0,
		 eq1 => choicer1,
		 eq2 => choicer2,
		 eq3 => choicer3);


b2v_inst2 : r2
PORT MAP(LOAD_R2 => loadr2,
		 clk => clk,
		 Data_in => data_in,
		 R2 => reg2);


b2v_inst3 : r3
PORT MAP(LOAD_R3 => loadr3,
		 clk => clk,
		 Data_in => data_in,
		 R3 => reg3);


b2v_inst4 : mux4to1
PORT MAP(data0x => reg0,
		 data1x => reg1,
		 data2x => reg2,
		 data3x => reg3,
		 sel => RA,
		 result => busA);


b2v_inst5 : mux4to1
PORT MAP(data0x => reg0,
		 data1x => reg1,
		 data2x => reg2,
		 data3x => reg3,
		 sel => RB,
		 result => busB);


loadr0 <= WE AND choicer0;


loadr1 <= WE AND choicer1;


loadr2 <= WE AND choicer2;


loadr3 <= WE AND choicer3;

data_in <= busW;

END bdf_type;