----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2024 09:43:13
-- Design Name: 
-- Module Name: compt_decompt - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity compt_decompt is
    Port ( clk         : in  STD_LOGIC;
           enable      : in  STD_LOGIC;
           reset       : in  STD_LOGIC;
           ten_cycles  : out STD_LOGIC
         );
end compt_decompt;

architecture Behavioral of compt_decompt is

    signal counter : integer range 0 to 9 := 0;
    signal ten    : STD_LOGIC := '0';
    
begin

    process(clk, reset)
    begin
        if (reset = '1') then
            counter <= 0;
            ten <= '0';
        elsif (clk'event and clk = '1') then
            if (enable = '1') then
                if (counter = 9) then
                    counter <= 0;
                    ten <= '1';
                else
                    counter <= counter + 1;
                    ten <= '0';
                end if;
            end if;
        end if;
    end process;
    
    ten_cycles <= ten;

end Behavioral;
