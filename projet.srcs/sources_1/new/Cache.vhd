library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Memory_cache is
    Port (
        clk  : in  STD_LOGIC;      
        rst  : in  STD_LOGIC;      
        din  : in  STD_LOGIC_VECTOR(7 downto 0); 
        dout : out STD_LOGIC_VECTOR(7 downto 0); 
        wr_en : in STD_LOGIC             
    );
end Memory_cache;

architecture Behavioral of Memory_cache is

    signal dff1_out, dff2_out, dff3_out : STD_LOGIC_VECTOR(7 downto 0);
    signal dff4_out, dff5_out, dff6_out : STD_LOGIC_VECTOR(7 downto 0);
    signal dff7_out, dff8_out, dff9_out : STD_LOGIC_VECTOR(7 downto 0);

    signal din_1 : std_logic_vector(7 downto 0);
    signal dout_f1: std_logic_vector(7 downto 0);
    signal wr1 : std_logic;
    signal rd1 : std_logic;
    signal full1 : std_logic;
    signal empty1 : std_logic;
    signal prog_full1 : std_logic;

    signal din_2 : std_logic_vector(7 downto 0);
    signal dout_f2: std_logic_vector(7 downto 0);
    signal wr2 : std_logic;
    signal rd2 : std_logic;
    signal full2 : std_logic;
    signal empty2 : std_logic;
    signal prog_full2 : std_logic;

    signal ten_cycles : std_logic;
    signal enable : std_logic;
    signal enable1: std_logic;
    signal done_s : std_logic;
    signal done_s1 : std_logic;
    signal enable_fd1 : std_logic := '0';
    signal enable_fd2 : std_logic := '0';
    signal enable_fd3 : std_logic := '0';

    type Liste_Stage is (STAGE1, STAGE2, STAGE3, STAGE4, STAGE5, STAGE6 );
    signal STAGE : Liste_Stage ;

    component compt_decompt is
        Port (
            clk : in  std_logic;
            enable : in  std_logic;      
            reset : in  std_logic;   
            ten_cycles : out std_logic
        );
    end component;

    component Clock_Counter is
        Generic (
            CYCLE_COUNT : integer := 2 
        );
        Port (
            clk          : in  std_logic;             
            reset        : in  std_logic;             
            enable       : in  std_logic;             
            done         : out std_logic                               
        );
    end component;

    component FF_MAMA is
        Port (
            clk   : in  STD_LOGIC;      
            reset : in  STD_LOGIC;
            enable : in  STD_LOGIC;      
            D     : in  STD_LOGIC_VECTOR(7 downto 0); 
            Q     : out STD_LOGIC_VECTOR(7 downto 0) 
        );
    end component;
    
    component fifo_generator_1 IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wr_en : IN STD_LOGIC;
            rd_en : IN STD_LOGIC;
            prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            full : OUT STD_LOGIC;
            empty : OUT STD_LOGIC;
            prog_full : OUT STD_LOGIC;
            wr_rst_busy : OUT STD_LOGIC;
            rd_rst_busy : OUT STD_LOGIC
        );
    end component;
    

begin

    DFF1: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd1,
            D => din,
            Q => dff1_out
        );
        
    DFF2: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd1,
            D => dff1_out,
            Q => dff2_out
        );
        
    DFF3: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd1,
            D => dff2_out,
            Q => dff3_out
        ); 
        
    FIFO1: fifo_generator_1
        port map(
            clk => clk,
            rst => rst,
            din => dff3_out,
            wr_en => wr1,
            rd_en => rd1,
            prog_full_thresh => "0001111101",
            dout => dout_f1,
            full => full1,
            empty => empty1,
            prog_full => prog_full1
        );   
    
    DFF4: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd2,
            D => dout_f1,
            Q => dff4_out
        );
        
    DFF5: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd2,
            D => dff4_out,
            Q => dff5_out
        );
        
    DFF6: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd2,
            D => dff5_out,
            Q => dff6_out
        ); 
        
    FIFO2: fifo_generator_1
        port map(
            clk => clk,
            rst => rst,
            din => dff6_out,
            wr_en => wr2,
            rd_en => rd2,
            prog_full_thresh => "0001111101",
            dout => dout_f2,
            full => full2,
            empty => empty2,
            prog_full => prog_full2
        ); 

    DFF7: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd3,
            D => dout_f2,
            Q => dff7_out
        );
        
    DFF8: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd3,
            D => dff7_out,
            Q => dff8_out
        );
        
    DFF9: FF_MAMA
        Port Map (
            clk => clk,
            reset => rst,
            enable => enable_fd3,
            D => dff8_out,
            Q => dff9_out
        ); 
        
    compt1: compt_decompt     
       Port map ( 
           clk => clk,
           enable => enable,   
           reset => rst,   
           ten_cycles => ten_cycles
       );
           
    compt2: Clock_Counter 
        generic map(
            CYCLE_COUNT => 3 
        )
        Port map (
            clk => clk,             
            reset => rst,             
            enable => enable1,             
            done => done_s                               
        );
         
    connection: process(clk,rst)
    begin
        if (rst = '1') then
            STAGE <= STAGE1;
        elsif (clk'event and clk = '1') then 
            case STAGE is
                when STAGE1 =>
                    enable <= '1';   
                    if(ten_cycles = '1') then
                        STAGE <= STAGE2;
                        enable <= '0';
                    else
                        STAGE <= STAGE1; 
                    end if;         
                when STAGE2 =>
                    rd1 <= prog_full1;
                    rd2 <= prog_full2;
                    if(wr_en = '1') then
                        enable_fd1 <= '1';
                        enable1 <= '1';
                        if(done_s = '0') then
                            STAGE <= STAGE2;
                        else
                            enable1 <= '1';
                            STAGE <= STAGE3;  
                        end if;         
                    else
                        STAGE <= STAGE2;
                    end if;
                when STAGE3 =>
                    enable_fd1 <= '1';
                    rd1 <= prog_full1;
                    rd2 <= prog_full2;
                    wr1 <= '1';
                    if(prog_full1 = '1') then
                        STAGE <= STAGE4;
                    else
                        STAGE <= STAGE3;    
                    end if;
                when STAGE4 =>
                    wr1 <= '1';   
                    enable_fd1 <= '1';                                             
                    rd1 <= prog_full1;
                    rd2 <= prog_full2;
                    enable_fd2 <= '1';
                    enable1 <= '1';
                    if(done_s = '0') then
                        STAGE <= STAGE4;
                    else
                        enable1 <= '0';
                        STAGE <= STAGE5;  
                    end if;     
                when STAGE5 =>
                    wr2 <= '1';
                    wr1 <= '1';
                    rd1 <= prog_full1;
                    rd2 <= prog_full2;
                    enable_fd1 <= '1';
                    enable_fd2 <= '1';
                    if(prog_full2 = '1') then
                        STAGE <= STAGE6;
                    else
                        STAGE <= STAGE4;
                    end if;
                when STAGE6 =>
                    wr2 <= '1';
                    wr1 <= '1';
                    rd1 <= prog_full1;
                    rd2 <= prog_full2;
                    enable_fd3 <= '1';
                    enable_fd2 <= '1';
                    enable_fd1 <= '1';
                    if (rst = '1') then
                        STAGE <= STAGE1;
                    else
                        STAGE <= STAGE6;
                    end if;       
                when others =>
                    STAGE <= STAGE1;
            end case;
        end if;  
    end process connection;

end Behavioral;
