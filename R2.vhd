LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity R2 is
port (
		LOAD_R2 : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		Data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		R2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end R2;

ARCHITECTURE accu OF R2 IS

BEGIN

  PROCESS(clk,LOAD_R2,data_in)
   BEGIN
	IF clk'event AND clk = '1' THEN 
		IF LOAD_R2 = '1' THEN
		R2 <= Data_in;
		END IF;
	END IF;
	
  END PROCESS;

END accu;