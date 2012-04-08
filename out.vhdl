library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity simple_alu is
port(   clock : in std_logic; --clock signal
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
signal Clk: std_logic; 

begin

Reg1 <= A;
Reg2 <= B;
Clk <=clock;
Reg4<=op;
process(Clk,A,B,Op)
begin

    if(Clk='1') then --Do the calculation at the positive edge of clock cycle.
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
                R <=Reg5(15 downto 0);
                if (Reg5(16)='1')then
                  carry <='1';
                end if;
                Reg3 <= Reg2-Reg1;
                Reg3 <= not(Reg3)+1;
                if(Reg3/=Reg5(15 downto 0))then
                  overflow <='1';
                end if;
                
            when "0010" => 
                R <= Reg1 or Reg2;  --OR gate 
            when "0011" => 
                R <= Reg1 and Reg2;  --AND gate
            when "0100" => 
                R <= Reg1 xor Reg2; --XOR gate     
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
              when "0101" =>
                R <= Reg1 sll 1;
              when "0110" =>
                R <= Reg1 srl 1;
                
            when others =>
                NULL;
        end case;       
    end if;
    
end process;    
process
    
    begin
      
      wait for 10ns;
      Reg1<="0000000000000010";
      Reg2<="0000000000000100";
      Clk <='1';
      
  end process;

end Behavioral;