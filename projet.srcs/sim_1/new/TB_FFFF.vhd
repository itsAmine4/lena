----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2024 11:55:43
-- Design Name: 
-- Module Name: TB_FFFF - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity flip_flop_tb is
end flip_flop_tb;

architecture Behavioral of flip_flop_tb is

    
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal d   : STD_LOGIC := '0';
    signal q   : STD_LOGIC;
    component flip_flop
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            d   : in  STD_LOGIC;
            q   : out STD_LOGIC
        );
    end component;
begin 
    uut: flip_flop
        Port map (
            clk => clk,
            rst => rst,
            d   => d,
            q   => q
        );
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    stimulus_process: process
    begin  
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;
        d <= '0';
        wait for 20 ns;
        d <= '1';
        wait for 20 ns;
        d <= '0';
        wait for 20 ns;
        wait for 40 ns;
        wait;
    end process stimulus_process;
end Behavioral;



end Behavioral;
