library ieee;
use ieee.std_logic_1164.all;
library work;
entity mult  is
  port (x,y: in std_logic_vector(7 downto 0); OUTPUT: out std_logic_vector(15 downto 0));
end entity mult;
architecture Struct of mult is
  signal l: std_logic_vector(9 downto 0);
  signal m: std_logic_vector(4 downto 0);
  signal z,exception_value: std_logic_vector(15 downto 0);
  signal zero_flag_x,zero_flag_y, infi_flag_x,infi_flag_y, NaN_flag_x,NaN_flag_y: std_logic;
  signal infi_positive, infi_negative, NaN, zero: std_logic;
  signal exception_flag: std_logic;
  component Fourbit_multiplier  is
  port (a1,a2: in std_logic_vector(3 downto 0); a3: out std_logic_vector(9 downto 0));
end component;
component add2  is
  port (a: in std_logic_vector(4 downto 0);m : in std_logic ; s: out std_logic_vector(4 downto 0));
end component;
component add1  is
  port (a,b: in std_logic_vector(2 downto 0); s: out std_logic_vector(4 downto 0));
end component;
 component multiplexer2 is
		port (A, B, S: in std_logic; O: out std_logic);
	end component multiplexer2;
begin
  b13: Fourbit_multiplier port map(a1 => x(3 downto 0), a2 => y(3 downto 0), a3 => l);
  z(15) <= x(7) xor y(7);
  b14: add1 port map(a => x(6 downto 4), b => y(6 downto 4), s => m);
  z(0) <= '0';
	gen3: for i in 0 to 7 generate
	 b15: multiplexer2 port map (B => l(i+1), A => l(i), S => l(9), O => z(i+2) );	
	end generate gen3;
	b16: multiplexer2 port map (B => l(0), A => '0', S => l(9), O => z(1) );	
	b17: add2 port map(a => m, m => l(9), s => z(14 downto 10)	);
	infi_flag_x <= (x(6) and (x(5) and x(4))) and (not ((x(3) or x(2)) or (x(1) or x(0)))); 
	infi_flag_y <= (y(6) and (y(5) and y(4))) and (not ((y(3) or y(2)) or (y(1) or y(0))));
	NaN_flag_x <= (x(6) and (x(5) and x(4))) and ((x(3) or x(2)) or (x(1) or x(0)));
	NaN_flag_y <= (y(6) and (y(5) and y(4))) and ((y(3) or y(2)) or (y(1) or y(0)));
	zero_flag_x <= not ((((((x(6) or x(5)) or x(4)) or x(3)) or x(2)) or x(1)) or x(0));
	zero_flag_y <= not ((((((y(6) or y(5)) or y(4)) or y(3)) or y(2)) or y(1)) or y(0));
	NaN <= (NaN_flag_x or NaN_flag_y) or (((infi_flag_x and zero_flag_y)) or ((infi_flag_y and zero_flag_x)));
	infi_positive <= (not (NaN)) and ((x(7) xnor y(7)) and (infi_flag_x or infi_flag_y));
	infi_negative <= (not (NaN)) and ((x(7) xor y(7)) and (infi_flag_x or infi_flag_y));
   zero <= ((not((NaN or infi_positive) or infi_negative)) and (not((infi_flag_x or infi_flag_y) or (NaN_flag_x or NaN_flag_y)))) and (zero_flag_x or zero_flag_y);
	exception_flag <= (NaN or infi_positive) or (infi_negative or zero);
	exception_value(9 downto 1) <= "000000000";
	exception_value(0) <= NaN;
	gen4: for i in 10 to 14 generate
	exception_value(i)<= not(zero);
	end generate gen4;
	exception_value(15) <= infi_negative;
   gen5: for i in 0 to 15 generate
   OUTPUT(i) <= (exception_value(i) and exception_flag) or ((not(exception_flag)) and z(i));
   end generate gen5;	
end Struct;
