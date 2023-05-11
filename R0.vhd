LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity R0 is
port (
		LOAD_R0 : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		R0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end R0;

ARCHITECTURE accu OF R0 IS

BEGIN

  PROCESS(clk,LOAD_R0,data_in)
   BEGIN
	IF clk'event AND clk = '1' THEN 
		IF LOAD_R0 = '1' THEN
		R0 <= Data_in;
		END IF;
	END IF;
	
  END PROCESS;

END accu;