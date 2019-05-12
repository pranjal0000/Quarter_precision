
library ieee;
use ieee.std_logic_1164.all;
library work;

entity DUT is
   port(input_vector: in std_logic_vector(15 downto 0);
       	output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DutWrap of DUT is
component mult  is
  port (x,y: in std_logic_vector(7 downto 0); OUTPUT: out std_logic_vector(15 downto 0));
end component mult; 

begin

func: mult port map(x => input_vector(7 downto 0) , y => input_vector(15 downto 8) , OUTPUT => output_vector);	
end DutWrap;

