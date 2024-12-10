

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity add_pixels is
    generic (
        bus_width : integer := 8  
    );
    Port ( 
        clk  : in  STD_LOGIC;                           
        A    : in  STD_LOGIC_VECTOR(bus_width-1 downto 0); 
        B    : in  STD_LOGIC_VECTOR(bus_width-1 downto 0); 
        Sum  : out STD_LOGIC_VECTOR(bus_width downto 0)    
    );
end add_pixels;

architecture Behavioral of add_pixels is
    signal temp_sum : STD_LOGIC_VECTOR(bus_width downto 0); 
    begin
    process(clk)
    begin
        if rising_edge(clk) then
            temp_sum <= ('0'&A) + ('0'&B); 
        end if;
    end process;
    
    Sum <= temp_sum;

end Behavioral;
