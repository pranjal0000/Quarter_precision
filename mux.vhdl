library ieee;
use ieee.std_logic_1164.all;
entity multiplexer2 is
   port (A, B, S: in std_logic; O: out std_logic);
end entity multiplexer2;

architecture Equations of multiplexer2 is
begin
    O <= (not(S) and A) or (S and B);
end Equations;

library ieee;
use ieee.std_logic_1164.all;
library work;

entity multunit is
	port (X: in std_logic_vector(3 downto 0);
	Y: out std_logic_vector(3 downto 0); M: in std_logic);
end entity multunit;
architecture Easy of multunit is
signal S : std_logic;  
 component multiplexer2 is
		port (A, B, S: in std_logic; O: out std_logic);
	end component multiplexer2;
begin
S <= not(M);
b7: multiplexer2 port map (A => X(3), B => '0', S => S, O => Y(3) );	
b8: multiplexer2 port map (A => X(2), B => '0', S => S, O => Y(2) );	
b9: multiplexer2 port map (A => X(1), B => '0', S => S, O => Y(1) );	
b10: multiplexer2 port map (A => X(0), B => '0', S => S, O => Y(0) );	

end Easy;
library ieee;
use ieee.std_logic_1164.all;
library work;
entity Fourbit_multiplier  is
  port (a1,a2: in std_logic_vector(3 downto 0); a3: out std_logic_vector(9 downto 0));
end entity Fourbit_multiplier;
architecture Struct of Fourbit_multiplier is
  signal A,B,C,D,E,F,G,H,I,J,K: std_logic_vector(9 downto 0);
  signal L,M,N,O: std_logic_vector(3 downto 0);
  component add0  is
  port (a,b: in std_logic_vector(9 downto 0); s: out std_logic_vector(9 downto 0));
end component;
component multunit is
	port (X: in std_logic_vector(3 downto 0);
	Y: out std_logic_vector(3 downto 0); M: in std_logic);
end component;

begin
	b11: multunit port map(X => a1, Y => L, M => a2(0));
	b12: multunit port map(X => a1, Y => M, M => a2(1));
	b13: multunit port map(X => a1, Y => N, M => a2(2));
	b14: multunit port map(X => a1, Y => O, M => a2(3));
	A(9 downto 4) <= "000000";
	A(3 downto 0) <= L;
	B(9 downto 5) <= "00000";
	B(4 downto 1) <= M;
	B(0) <= '0';
	C(9 downto 6) <= "0000";
	C(5 downto 2) <= N;
	C(1 downto 0) <= "00";
	D(9 downto 7) <= "000";
	D(6 downto 3) <= O;
	D(2 downto 0) <= "000";
   H(3 downto 0) <= "0000";
	H(7 downto 4) <= a1;
	H(9 downto 8) <= "00";
	I(3 downto 0) <= "0000";
	I(7 downto 4) <= a2;
	I(9 downto 8) <= "00";
	b1: add0 port map(a => A, b => B, s => E);
	b2: add0 port map(a => C, b => D, s => F);
	b3: add0 port map(a => E, b => F, s => G);
	b4: add0 port map(a => H, b => I, s => J);
	b5: add0 port map(a => G, b => J, s => K);
	b6: add0 port map(a => K, b => "0100000000", s => a3);

end Struct;
