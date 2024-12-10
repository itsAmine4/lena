library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity global is
Port (  clk : in std_logic ;
        reset: in std_logic;
        enable: in std_logic;
        nb_valb: out std_logic;
        Data : in std_logic_vector(7 downto 0);
        Sortie  : out std_logic_vector(7 downto 0)
);
end global;

architecture Behavioral of global is
---- flipflop-----------
component FF_MAMA
 Port ( clk : in std_logic ;
        reset: in std_logic;
        enable: in std_logic;
        D : in std_logic_vector(7 downto 0);
        Q : out std_logic_vector(7 downto 0)
      
 );
end component;
-----------fifo----------------------
component fifo_generator_0 
port(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    almost_full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC);
end component ;



--- datavariable
component Datavariable 
Port (    clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           dataV : in STD_LOGIC;
           s : out STD_LOGIC);
end component ;
--- add6pixels------
component add_pixels 
generic (bus_width:integer:=8);
    Port ( clk :in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (bus_width-1 downto 0);
           B : in STD_LOGIC_VECTOR (bus_width-1 downto 0);
           Sum : out STD_LOGIC_VECTOR (bus_width downto 0));
end component ;
--signales--

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
------------- 1 ?tage------------------
signal D8:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q8:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q7:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q6:std_logic_VECTOR(7 DOWNTO 0) ;
------------- 2 ?tage------------------
signal Q5:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q4:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q3:std_logic_VECTOR(7 DOWNTO 0) ;
------------- 3 ?tage------------------
signal Q2:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q1:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q0:std_logic_VECTOR(7 DOWNTO 0) ;
------------ si besioin 
signal Q12:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q11:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q10:std_logic_VECTOR(7 DOWNTO 0) ;
signal Q9:std_logic_VECTOR(7 DOWNTO 0) ;
------- datavariable1 -----
signal dataV1:std_logic;
------sortie de data 
signal s1 :std_logic;
signal s2 :std_logic;
signal s3:std_logic;
-----------------
signal s4 :std_logic;
signal s5 :std_logic;
signal s6 :std_logic;
signal s7:std_logic;
-------------------
signal s8:std_logic;
signal s9 :std_logic;
signal s10 :std_logic;
signal s11 :std_logic;
----signal pour add 
signal s12 :std_logic;
signal s13 :std_logic;
signal s14 :std_logic;
signal nb_valb1: std_logic;
signal Result_avb :std_logic;
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
-----------------------------------------
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

-- data Variable 1
dataV1<='1';
data1:Datavariable port map(clk1,enable2,reset2,dataV1,s1);
data2:Datavariable port map(clk1,enable2,reset2,s1,s2);
data3:Datavariable port map(clk1,enable2,reset2,s2,s3);
---fifo1
rd_en1 <= prog_full1 ;
wr_en1<= s3 ;
FiFo1:fifo_generator_0 port map (clk1,rst1,Q6, wr_en1, rd_en1, prog_full_thresh1, dout1,full1, almost_full, empty1, prog_full1,wr_rst_busy1,rd_rst_busy1);
------- 2 ?me etages ------------------
ff4: FF_MAMA port map( clk1,reset1,enable1,dout1,Q5);
ff5: FF_MAMA port map( clk1,reset1,enable1,Q5,Q4);
ff6: FF_MAMA port map( clk1,reset1,enable1,Q4,Q3);
--data variable 2-------
data4:Datavariable port map(clk1,enable2,reset2,prog_full1,s4);
data5:Datavariable port map(clk1,enable2,reset2,s4,s5);
data6:Datavariable port map(clk1,enable2,reset2,s5,s6);
data7:Datavariable port map(clk1,enable2,reset2,s6,s7);
------ fifo2 ---------
rd_en2<= prog_full2 ;
wr_en2 <= s7 ;
FiFo2:fifo_generator_0 port map (clk1,rst2,Q3,wr_en2, rd_en2, prog_full_thresh2, dout2,full2, almost_full2, empty2, prog_full2,wr_rst_busy2,rd_rst_busy2);
----------3 eme etage --------------
ff7: FF_MAMA port map( clk1,reset1,enable1,dout2,Q2);
ff8: FF_MAMA port map( clk1,reset1,enable1,Q2,Q1);
ff9: FF_MAMA port map( clk1,reset1,enable1,Q1,Q0 );
--Sortie <= Q0 ;
--data variable 3-------
data8:Datavariable port map(clk1,enable2,reset2,prog_full2,s8);
data9:Datavariable port map(clk1,enable2,reset2,s8,s9);
data10:Datavariable port map(clk1,enable2,reset2,s9,s10);
data11:Datavariable port map(clk1,enable2,reset2,s10,s11);
----------------------------------
nb_valb1 <= s11 and enable;
nb_valb <= nb_valb1;
--additionnaire 
P8 <= Q8;
P7 <= Q7;
P6 <= Q6;
P5 <= Q5;
P4 <= Q4;
P3 <= Q3;
P2 <= Q2;
P1 <= Q1;
P0 <= Q0;
-----1er etage ----------
--ff10: flipflop port map( clk1,reset1,enable1,P5,Q9 );
add1: add_pixels generic map (bus_width => 8) port map(clk1,P8,P7,P87);
add2: add_pixels generic map (bus_width => 8) port map(clk1,P6,P0,P65);
add3: add_pixels generic map (bus_width => 8)port map(clk1,P4,P3,P43);
add4: add_pixels generic map (bus_width => 8) port map(clk1,P2,P1,P21);
------2eme etage 
--ff11: flipflop port map( clk1,reset1,enable1,Q9,Q10 );
add5: add_pixels generic map (bus_width => 9) port map(clk1,P87,P65,P8765);
add6: add_pixels generic map (bus_width => 9) port map(clk1,P43,P21,P4321);
-------3eme etage----------
--ff12: flipflop port map( clk1,reset1,enable1,Q10,Q11 );
add7:add_pixels generic map (bus_width => 10) port map(clk1,P8765,P4321,P0T);
--------------------
--ff13: flipflop port map( clk1,reset1,enable1,Q11,Q11 );
P0TT <= P0T(10 downto 3);
-----------------basculr pour compter ----
data12:Datavariable port map(clk1,enable2,reset2,nb_valb1,s12);
data13:Datavariable port map(clk1,enable2,reset2,s12,s13);
data14:Datavariable port map(clk1,enable2,reset2,s13,s14);
-----------------
Sortie <= P0TT  ;
Result_avb <= s14 ;
--nb_valb <= Result_avb;
end Behavioral;


