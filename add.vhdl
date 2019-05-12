library ieee;
use ieee.std_logic_1164.all;
entity fulladder is
port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end entity fulladder;
architecture Equations of fulladder is
begin

S <= (A xor B) xor Cin;

Cout <= (A and B) or ((A or B) and Cin);
end Equations;

library ieee;
use ieee.std_logic_1164.all;
library work;
entity add0  is
  port (a,b: in std_logic_vector(9 downto 0); s: out std_logic_vector(9 downto 0));
end entity add0;
architecture Struct of add0 is
  signal C: std_logic_vector(10 downto 0);
  component fulladder is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
  end component fulladder;
  
begin
  C(0) <= '0';
  genadd: 
  for i in 0 to 9 generate
  b10: fulladder port map (A => a(i), B => b(i), Cin => C(i), S => s(i), Cout => C(i+1));
  end generate genadd;
end Struct;
library ieee;
use ieee.std_logic_1164.all;
library work;
entity add1  is
  port (a,b: in std_logic_vector(2 downto 0); s: out std_logic_vector(4 downto 0));
end entity add1;
architecture Struct of add1 is
  signal C: std_logic_vector(3 downto 0);
  component fulladder is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
  end component fulladder;
  
begin
  C(0) <= '1';
  genadd: 
  for i in 0 to 2 generate
  b11: fulladder port map (A => a(i), B => b(i), Cin => C(i), S => s(i), Cout => C(i+1));
  end generate genadd;
  s(3) <= not C(3);
  s(4) <= C(3);
end Struct;
library ieee;
use ieee.std_logic_1164.all;
library work;
entity add2  is
  port (a: in std_logic_vector(4 downto 0);m : in std_logic ; s: out std_logic_vector(4 downto 0));
end entity add2;
architecture Struct of add2 is
  signal C: std_logic_vector(10 downto 0);
  component fulladder is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
  end component fulladder;
  
begin
  C(0) <= m;
  genadd: 
  for i in 0 to 4 generate
  b12: fulladder port map (A => a(i), B => '0', Cin => C(i), S => s(i), Cout => C(i+1));
  end generate genadd;
end Struct;

