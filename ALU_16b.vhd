LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
ENTITY ALU_16b IS
    PORT (
        S  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0 );
        A  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
        B  : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		  F  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		  bne : OUT STD_LOGIC;
		  M  : IN  STD_LOGIC  );
END ALU_16b;

ARCHITECTURE behav OF ALU_16b IS
SIGNAL A17 : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAL B17 : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAL F17 : STD_LOGIC_VECTOR(16 DOWNTO 0);
BEGIN
  A17 <= '0' & A ;  B17 <= '0' & B ;  
  PROCESS(M,A17,B17)
   BEGIN
    CASE S  IS
			WHEN "0000" =>  IF M='0' THEN F17<=(A17 or B17);	bne <= '0';											END IF;--ok
			WHEN "0001" =>  IF M='0' THEN F17<=(A17 and B17);	bne <= '0';											END IF;--ok
			WHEN "0010" =>  IF M='0' THEN F17<=(A17 + B17);		bne <= '0';											END IF;--ok
			WHEN "0011" =>  IF M='0' THEN F17<=(A17 - B17);		bne <= '0';											END IF;--ok
			WHEN "0100" =>  IF M='0' THEN if A17 /= B17 then bne <= '1'; else bne <= '0';	end if;	F17<="00000000000010001";			END IF;--ok
			WHEN "0101" =>  IF M='0' THEN F17<= "11111111111111111";	bne <= '0';									END IF;--ok
			WHEN "0110" =>  IF M='0' THEN F17<=to_stdlogicvector(to_bitvector(A17) SLL to_integer(unsigned(B17)));	bne <= '0';									END IF;--ok
			WHEN "0111" =>  IF M='0' THEN F17<=to_stdlogicvector(to_bitvector(A17) SRL to_integer(unsigned(B17)));	bne <= '0';									END IF;--ok
			WHEN "1000" =>  IF M='0' THEN F17<=to_stdlogicvector(to_bitvector(A17) SRA to_integer(unsigned(B17)));	bne <= '0';										END IF;--ok
			WHEN "1001" =>  IF M='0' THEN bne <= '0'; if A17< B17 then F17<= "00000000000000001";	else 	F17<= "00000000000000000";	end if;							END IF;--ok
			WHEN "1010" =>  IF M='0' THEN F17<=std_logic_vector(shift_left(unsigned(B17),8));	bne <= '0';											END IF;--ok
			WHEN OTHERS => F17<= "00000000000000000";
    	END CASE;
  END PROCESS;
 F<= F17(15 DOWNTO 0) ;
END behav;
