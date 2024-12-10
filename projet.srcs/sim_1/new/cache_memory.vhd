library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_mm_cache is
end tb_mm_cache;

architecture Behavioral of tb_mm_cache is

    
    signal clk    : STD_LOGIC := '0';
    signal rst    : STD_LOGIC := '0';
    signal din    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal dout   : STD_LOGIC_VECTOR(7 downto 0);
    signal wr_en  : STD_LOGIC := '0';

    
    component mm_cache is
        Port (
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            din   : in  STD_LOGIC_VECTOR(7 downto 0);
            dout  : out STD_LOGIC_VECTOR(7 downto 0);
            wr_en : in  STD_LOGIC
        );
    end component;

begin

    
    uut: mm_cache
        Port map (
            clk   => clk,
            rst   => rst,
            din   => din,
            dout  => dout,
            wr_en => wr_en
        );

    
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    stim_proc: process
    begin        
        
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        
        din <= "00000001";
        wr_en <= '1';
        wait for 20 ns;

        din <= "00000010";
        wr_en <= '1';
        wait for 20 ns;

        din <= "00000011";
        wr_en <= '1';
        wait for 20 ns;

        
        wr_en <= '0';
        wait for 20 ns;

        
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        
        din <= "11111111";
        wr_en <= '1';
        wait for 20 ns;

        din <= "10101010";
        wr_en <= '1';
        wait for 20 ns;

        
        wait;
    end process;

end Behavioral;
