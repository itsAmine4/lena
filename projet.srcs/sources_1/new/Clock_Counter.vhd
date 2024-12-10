----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2024 09:56:21
-- Design Name: 
-- Module Name: Clock_Counter - Behavioral
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

entity Clock_Counter is
    Generic ( CYCLE_COUNT : integer := 100 );
    Port ( clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable: in  STD_LOGIC;
           done  : out STD_LOGIC
         );
end Clock_Counter;

architecture Behavioral of Clock_Counter is

    signal counter : integer range 0 to CYCLE_COUNT-1 := 0;
    signal done_signal : STD_LOGIC := '0';
    
begin

    process(clk, reset)
    begin
        if (reset = '1') then
            counter <= 0;
            done_signal <= '0';
        elsif (clk'event and clk = '1') then
            if (enable = '1') then
                if (counter = CYCLE_COUNT - 1) then
                    counter <= 0;
                    done_signal <= '1';
                else
                    counter <= counter + 1;
                    done_signal <= '0';
                end if;
            end if;
        end if;
    end process;
    
    done <= done_signal;

end Behavioral;
