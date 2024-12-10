----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2024 10:51:26
-- Design Name: 
-- Module Name: FF_generic - Behavioral
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
USE ieee.numeric_std.ALL;



entity flip_flop is
    Port ( 
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        d   : in  STD_LOGIC;
        q   : out STD_LOGIC
    );
end flip_flop;

architecture Behavioral of flip_flop is

component fifo_generator_0 IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END component fifo_generator_0;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            q <= '0';  
        elsif rising_edge(clk) then
            q <= d;  
        end if;
    end process;
end Behavioral;
