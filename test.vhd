library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
entity ALU is
port
(
    data1,data2:in std_logic_vector(15 downto 0);
    operation :in bit_vector(3 downto 0);
    result:out std_logic_vector(15 downto 0);
    zero,carry,overflow,negative,equal,nequal,gt,lt:out bit
);
end ALU;

architecture ARCH of ALU is
signal var:std_logic_vector(15 downto 0);
signal bvar:bit_vector(15 downto 0);
signal zeros : std_logic_vector(15 downto 0);
signal ones : std_logic_vector(15 downto 0);
signal car : std_logic_vector(16 downto 0);
signal test:std_logic_vector(15 downto 0);
--signal sain:signed(15 downto 0);


begin
  zero<='0';
  
  
  negative<='0';
  zeros <= (15 downto 0 => '0');
  ones <= (15 downto 0 => '1');
  
process (data1,data2,operation)
  begin
    if(operation="0000")then
      var<=data1+data2;
      result<=var;
      car<=var;
      
      if (car(16)='1')then
        carry<='1';
      end if;
      
      if((data1(15)='0')and (data2(15)='0')and (var(15)='1'))then
        overflow<='1';
      
      elsif((data1(15)='1')and (data2(15)='1')and (var(15)='0'))then
        overflow<='1';
      end if;
    
  elsif(operation="0001")then
      var<=data1-data2;
      result<=var;  
      car<=var;
      
      if (car(16)='1')then
        carry<='1';
      end if;
      
      if((data1(15)='0')and (data2(15)='0')and (var(15)='1'))then
        overflow<='1';
      
      elsif((data1(15)='1')and (data2(15)='1')and (var(15)='0'))then
        overflow<='1';
      end if;
       
  elsif(operation="1000")then
      var<=data1-data2;
      if(var(15)='0')then
        equal<='0';
        nequal<='0';
        gt<='1';
        lt<='0';
      end if;
   
  elsif(operation="1001")then
      var<=data1-data2;
      if(var=zeros)then
        equal<='1';
        nequal<='0';
        gt<='0';
        lt<='0';
      end if;   
    
  elsif(operation="1010")then
      var<=data1-data2;
      if(var/=zeros)then
        equal<='0';
        nequal<='1';
        gt<='0';
        lt<='0';
      end if;  
  
  elsif(operation="1011")then
      var<=data1-data2;
      if(var(15)='1')then
        equal<='0';
        nequal<='0';
        gt<='0';
        lt<='1';
      end if;  
    
  elsif(operation="0010")then
      var<=data1 or data2;
      result<=var;
    
  elsif(operation="0011")then
      var<=data1 and data2;
      result<=var;
    
  elsif(operation="0100")then
      var<=data1 xor data2;
      result<=var;
    
  elsif(operation="0101")then
      bvar<=to_bitvector(data1) sll 1;
      var<=to_stdlogicvector(bvar);
      result<=var;
    
  elsif(operation="0110")then
      bvar<=to_bitvector(data1) srl 1;
      var<=to_stdlogicvector(bvar);
      result<=var;
    
  elsif(operation="0111")then
      bvar<=to_bitvector(data1) sra 1;
      var<=to_stdlogicvector(bvar);
      result<=var;
    end if;
         
  end process;
  
  
  process
    
    begin
      test<="0000000000000000";
      wait for 10ns;
     -- data1<=test;
  end process;
end ARCH ;