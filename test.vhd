library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
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
begin
  
process (data1,data2)
  begin
    if(operation="0000")then
      var<=data1+data2;
      result<=var;
    end if;
    if((operation="0001") or (operation="1000") or (operation="1001") or (operation="1010") or (operation="1011"))then
      var<=data1-data2;  
      if(var(15)='1')then
        negative<='1'; 
        lt<='1';
      else
        gt<='1';       
      end if; 
      if(var=0)then
        zero<='1';
        equal<='1'; 
      else
        nequal<='1';       
      end if; 
    end if;
    if(operation="0010")then
      var<=data1 or data2;
      result<=var;
    end if;
    if(operation="0011")then
      var<=data1 and data2;
      result<=var;
    end if;
    if(operation="0100")then
      var<=data1 xor data2;
      result<=var;
    end if;
    if(operation="0101")then
      bvar<=to_bitvector(data1) sll 1;
      var<=to_stdlogicvector(bvar);
      result<=var;
    end if;
    if(operation="0110")then
      bvar<=to_bitvector(data1) srl 1;
      var<=to_stdlogicvector(bvar);
      result<=var;
    end if;
    if(operation="0111")then
      bvar<=to_bitvector(data1) sra 1;
      var<=to_stdlogicvector(bvar);
      result<=var;
    end if;
         
  end process;
end ARCH ;