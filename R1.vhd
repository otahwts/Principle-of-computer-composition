LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity R1 is
port (
		LOAD_R1 : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		R1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end R1;

ARCHITECTURE accu OF R1 IS

BEGIN

  PROCESS(clk,LOAD_R1,data_in)
   BEGIN
	IF clk'event AND clk = '1' THEN 
		IF LOAD_R1 = '1' THEN
		R1 <= Data_in;
		END IF;
	END IF;
	
  END PROCESS;

END accu;