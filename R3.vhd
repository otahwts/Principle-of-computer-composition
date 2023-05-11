LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity R3 is
port (
		LOAD_R3 : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		R3 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end R3;

ARCHITECTURE accu OF R3 IS

BEGIN

  PROCESS(clk,LOAD_R3,data_in)
   BEGIN
	IF clk'event AND clk = '1' THEN 
		IF LOAD_R3 = '1' THEN
		R3 <= Data_in;
		END IF;
	END IF;
	
  END PROCESS;

END accu;