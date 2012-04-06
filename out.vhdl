library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity simple_alu is
port(   Clk : in std_logic; --clock signal
        A,B : in signed(15 downto 0); --input operands
        Op : in unsigned(3 downto 0); --Operation to be performed
        zero,carry,overflow,negative,equal,nequal,gt,lt:out bit;
        R : out signed(15 downto 0)  --output of ALU
        );
end simple_alu;

architecture Behavioral of simple_alu is

--temporary signal declaration.
signal Reg1,Reg2,Reg3 : signed(15 downto 0) := (others => '0');
signal Reg5 : signed(16 downto 0) := (others => '0');
signal Reg4: unsigned (3 downto 0) := (others => '0');
signal RReg :std_logic_vector(16 downto 0);
signal zeros : signed (15 downto 0) := (others => '0');
begin

Reg1 <= A;
Reg2 <= B;
--R <= Reg3;
Reg4<=op;
process(Clk)
begin

    if(rising_edge(Clk)) then --Do the calculation at the positive edge of clock cycle.
        case Op is
            when "0000" => 
                Reg5 <= Reg1 + Reg2;  --addition
                R <=Reg5(15 downto 0);
                
                if (Reg5(16)='1')then
                  carry <='1';
                end if;
                if((Reg1(15)='0')and (Reg2(15)='0')and (Reg5(15)='1'))then
                  	overflow<='1';
      
                elsif((Reg1(15)='1')and (Reg2(15)='1')and (Reg5(15)='0'))then
                  overflow<='1';
                end if;
                
            when "0001" => 
                Reg5 <= Reg1 - Reg2; --subtraction
                
                if (Reg5(16)='1')then
                  carry <='1';
                end if;
                if((Reg1(15)='0')and (Reg2(15)='0')and (Reg5(15)='1'))then
                  	overflow<='1';
      
                elsif((Reg1(15)='1')and (Reg2(15)='1')and (Reg5(15)='0'))then
                  overflow<='1';
                end if;
                
            when "0010" => 
                Reg5 <= Reg1 or Reg2;  --OR gate 
            when "0011" => 
                Reg5 <= Reg1 and Reg2;  --AND gate
            when "0100" => 
                Reg5 <= Reg1 xor Reg2; --XOR gate     
            when "1000" =>
              Reg3<=Reg1-Reg2;
              if(Reg3(15)='0')then
                equal<='0';
                nequal<='0';
                gt<='1';
                lt<='0';
              end if;
            when "1001" =>
              Reg3<=Reg1-Reg2;
              if(Reg3=zeros)then
                equal<='1';
                nequal<='0';
                gt<='0';
                lt<='0';
              end if; 
            when "1010" =>
               Reg3<=Reg1-Reg2;
              if(Reg3/=zeros)then
                equal<='0';
                nequal<='1';
                gt<='0';
                lt<='0';
              end if; 
            when "1011" =>
              Reg3<=Reg1-Reg2;
              if(Reg3(15)='1')then
                equal<='0';
                nequal<='0';
                gt<='0';
                lt<='1';
              end if; 
              
            when others =>
                NULL;
        end case;       
    end if;
    
end process;    

end Behavioral;