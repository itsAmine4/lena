----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2024 15:37:02
-- Design Name: 
-- Module Name: filtre - Behavioral
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

entity filtre is
    Port (
        clk     : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        enable : in std_logic;
        data: in std_logic_vector(7 downto 0);
        sortie: out std_logic_vector(7 downto 0)
          
    );
end filtre;

architecture Behavioral of filtre is
component FF_MAMA is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           Q : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           RESET : in STD_LOGIC);
end component;
component fifo_generator_0 IS
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
END component;   
component add_pixels is
    generic (
        bus_width : integer := 8  
    );
    Port ( 
        clk  : in  STD_LOGIC;                           
        A    : in  STD_LOGIC_VECTOR(bus_width-1 downto 0); 
        B    : in  STD_LOGIC_VECTOR(bus_width-1 downto 0); 
        Sum  : out STD_LOGIC_VECTOR(bus_width downto 0)    
    );
end component;
--FiFo1--
signal clk1:std_logic ;
signal rst1:std_logic ;
signal  wr_en1:std_logic ;
signal rd_en1:std_logic ;
signal din1:std_logic_VECTOR(7 DOWNTO 0) ;
signal prog_full_thresh1 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
signal  dout1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal  full1 :  STD_LOGIC;
signal  almost_full : STD_LOGIC;
signal empty1 :  STD_LOGIC;
signal  prog_full1 : STD_LOGIC;
signal  wr_rst_busy1 :  STD_LOGIC;
signal rd_rst_busy1 : STD_LOGIC;

---FiFo2--
signal rst2:std_logic ;
signal  wr_en2:std_logic ;
signal rd_en2:std_logic ;
signal din2:std_logic_VECTOR(7 DOWNTO 0) ;
signal prog_full_thresh2 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
signal  dout2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal  full2 :  STD_LOGIC;
signal  almost_full2 : STD_LOGIC;
signal empty2 :  STD_LOGIC;
signal  prog_full2 : STD_LOGIC;
signal  wr_rst_busy2 :  STD_LOGIC;
signal rd_rst_busy2 : STD_LOGIC;
--- sorties des flipflop---
------------- 1 étage------------------
signal D8:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q8:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q7:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q6:std_logic_VECTOR(7 DOWNTO 0) ;
------------- 2 étage------------------
signal Q5:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q4:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q3:std_logic_VECTOR(7 DOWNTO 0) ;
------------- 3 étage------------------
signal Q2:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q1:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q0:std_logic_VECTOR(7 DOWNTO 0) ;
------------ si besioin 
--signal Q12:std_logic_VECTOR(7 DOWNTO 0) ;
--signal Q11:std_logic_VECTOR(7 DOWNTO 0) ;
--signal Q10:std_logic_VECTOR(7 DOWNTO 0) ;
--signal Q9:std_logic_VECTOR(7 DOWNTO 0) ;
-----------enable--------------------
 signal enable1: std_logic;
  signal enable2: std_logic;
 signal reset1:std_logic ;
 signal reset2:std_logic ;
--Pixels---------------
signal P8:std_logic_VECTOR(7 DOWNTO 0) ;
signal P7:std_logic_VECTOR(7 DOWNTO 0) ;
signal P6:std_logic_VECTOR(7 DOWNTO 0) ;
------------- 2 ?tage------------------
signal P5:std_logic_VECTOR(7 DOWNTO 0) ;
signal P4:std_logic_VECTOR(7 DOWNTO 0) ;
signal P3:std_logic_VECTOR(7 DOWNTO 0) ;
------------- 3 ?tage------------------
signal P2:std_logic_VECTOR(7 DOWNTO 0) ;
signal P1:std_logic_VECTOR(7 DOWNTO 0) ;
signal P0:std_logic_VECTOR(7 DOWNTO 0) ;
-------Sorties de add -------------------
signal P87:std_logic_VECTOR(8 DOWNTO 0) ;
signal P65:std_logic_VECTOR(8 DOWNTO 0) ;
signal P43:std_logic_VECTOR(8 DOWNTO 0) ;
signal P21:std_logic_VECTOR(8 DOWNTO 0) ;
-----------------
signal P8765:std_logic_VECTOR(9 DOWNTO 0) ;
signal P4321:std_logic_VECTOR(9 DOWNTO 0) ;
----------------
signal P0T:std_logic_VECTOR(10 DOWNTO 0) ;
signal P0TT:std_logic_VECTOR(7 DOWNTO 0) ;

begin
rst1 <= reset;
rst2 <= reset;
-------
prog_full_thresh1 <="0001111011";
prog_full_thresh2 <="0001111011"; 
---------------
clk1<= clk;
--------------
reset1<=reset;
reset2<=reset;
---------------
enable1<= enable;
enable2<= enable;
--------------------
D8 <= Data ;
-----------------
ff1: FF_MAMA port map( clk1,reset1,enable1,D8,Q8);
ff2: FF_MAMA port map( clk1,reset1,enable1,Q8,Q7);
ff3: FF_MAMA port map( clk1,reset1,enable1,Q7,Q6);




    
   
end Behavioral;


