LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY extend IS
    PORT (
			Data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			EXOP : IN STD_LOGIC;
			extend : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			
);
END extend;

ARCHITECTURE behav OF extend IS

BEGIN
		PROCESS(Data_in,EXOP)
			BEGIN
				if EXOP ='0' then 
					extend <="00000000"&Data_in;
				else
					if Data_in(7) = '1' then 
						extend <="11111111"&Data_in;
					else
						extend <="00000000"&Data_in;
					end if;
				end if;
			END PROCESS;

END behav;