module Vending (coin , firstinit ,clk ,coffee , rem );   
  
  input[2:0] coin;
  input firstinit;
  input wire clk;
  
  output reg coffee;
  output reg[2:0] rem;

  localparam [2:0] state0=0 ,state1=1,state2=2,state3=3,state4=4,state5=5,state6=6;
  reg [2:0] current;  
  
  always @(posedge clk ) 
    begin
  if (firstinit == 1) 
    current <= state0; 
  else
    begin
    if (current == state0)
      begin
      if(coin == 0)
    begin 
    current <= state0;
    coffee<=0;
    rem<=0;
    end
      else if(coin == 1)
    begin current <= state1;
    coffee<=0;
    rem<=0;
    end
      else if(coin == 2) 
    begin 
    current <= state5;
    coffee<=0;
    rem<=0;
    end
      else if(coin == 5)
    begin 
    current <= state3
    ;coffee<=0;
    rem<=0;
    end
        end  
  else if(current == state1)
    begin
      if(coin == 0)
    begin 
    current <= state1;
    coffee<=0;
    rem<=0;
    end
      if(coin == 1)
    begin current <= state5;
    coffee<=0;
    rem<=0;
    end
      if(coin == 2)
    begin 
    current <= state6;
    coffee<=0;
    rem<=0;
    end
      if(coin == 5)
    begin current <= state2;
    coffee<=0;
    rem<=2;
    end
        end  

  else if (current == state2)
    begin
    coffee<=0;
    rem<=1;
    current<=state3;
        end
  else if (current == state3)
    begin
    coffee<=0;
    rem<=2;
    current<=state4;
        end
  else if(current == state4)
    begin
    coffee<=0;
    rem<=1;
    current<=state5;
        end
  else if (current == state5)
    begin
    coffee<=1;
    rem<=0;
    current<=state0;
  end          
  else if (current == state6)
  begin
    coffee<=0;
    rem<=1;
    current<=state5;
        end
     end
  end
endmodule
