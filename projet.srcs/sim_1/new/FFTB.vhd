library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FFTB is
end FFTB;

architecture Behavioral of FFTB is


    component fifo_generator_0 is
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wr_en : IN STD_LOGIC;
            rd_en : IN STD_LOGIC;
            dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            full : OUT STD_LOGIC;
            empty : OUT STD_LOGIC;
            prog_full : OUT STD_LOGIC;
            wr_rst_busy : OUT STD_LOGIC;
            rd_rst_busy : OUT STD_LOGIC
        );
    end component;

    signal clk         : STD_LOGIC := '0';
    signal rst         : STD_LOGIC := '0';
    signal din         : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    signal wr_en       : STD_LOGIC := '0';
    signal rd_en       : STD_LOGIC := '0';
    signal dout        : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal full        : STD_LOGIC;
    signal empty       : STD_LOGIC;
    signal prog_full   : STD_LOGIC;
    signal wr_rst_busy : STD_LOGIC;
    signal rd_rst_busy : STD_LOGIC;

begin
    
    uut: fifo_generator_0
        PORT MAP (
            clk          => clk,
            rst          => rst,
            din          => din,
            wr_en        => wr_en,
            rd_en        => rd_en,
            dout         => dout,
            full         => full,
            empty        => empty,
            prog_full    => prog_full,
            wr_rst_busy  => wr_rst_busy,
            rd_rst_busy  => rd_rst_busy
        );

   
    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    
    stimulus_process : process
    begin
       
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        
        din <= "00000001";  
        wr_en <= '1';
        wait for 20 ns;

        din <= "00000010";  
        wait for 20 ns;

        din <= "00000011";  
        wait for 20 ns;

        wr_en <= '0';  
        wait for 20 ns;

        
        rd_en <= '1';
        wait for 20 ns;

        rd_en <= '0';  
        wait for 20 ns;

        
        wait;
    end process;

end Behavioral;
