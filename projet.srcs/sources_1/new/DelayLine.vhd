----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2024 14:34:13
-- Design Name: 
-- Module Name: DelayLine - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

entity DelayLine is
    generic (
        N : integer := 4  
    );
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        D_in  : in  std_logic;
        D_out : out std_logic
    );
end entity DelayLine;

architecture Behavioral of DelayLine is
    signal delay : std_logic_vector(N-1 downto 0);
begin
    process (clk, reset)
    begin
        if reset = '1' then
            delay <= (others => '0');
        elsif rising_edge(clk) then
            delay <= delay(N-2 downto 0) & D_in;
        end if;
    end process;
    D_out <= delay(N-1);
end architecture Behavioral;
