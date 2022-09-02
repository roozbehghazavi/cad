module alarmclock (
 input reset,  
 input clk,  
 input [1:0] H_in1,  
 input [3:0] H_in0,  
 input [3:0] M_in1,  
 input [3:0] M_in0, 
 input LD_time,   
 input   LD_alarm,   
 input   set_alarm,  
 input   alarm_on,  
 output reg Alarm, 
 output [1:0]  H_out1, 

/* The most significant digit of the hour. Valid values are 0 to 2. */
 output [3:0]  H_out0, 
/* The least significant digit of the hour. Valid values are 0 to 9. */
 output [3:0]  M_out1, 

 output [3:0]  M_out0, /* The least significant digit of the minute. Valid values are 0 to 9. */
 output [3:0]  S_out1, /* The most significant digit of the minute. Valid values are 0 to 5. */
 output [3:0]  S_out0  /* The least significant digit of the minute. Valid values are 0 to 9. */
 );

 reg clk_1s; 
 reg [3:0] tmp_1s;  
 reg [5:0] tmp_hour, tmp_minute, tmp_second; 
 reg [1:0] c_hour1,a_hour1; 
/* The most significant hour digit of the temp clock and alarm. */ 
 reg [3:0] c_hour0,a_hour0;
/* The least significant hour digit of the temp clock and alarm. */ 
 reg [3:0] c_min1,a_min1;
/* The most significant minute digit of the temp clock and alarm.*/ 
 reg [3:0] c_min0,a_min0;
/* The least significant minute digit of the temp clock and alarm.*/ 
 reg [3:0] c_sec1,a_sec1;
/* The most significant second digit of the temp clock and alarm.*/ 
 reg [3:0] c_sec0,a_sec0;
/* The least significant minute digit of the temp clock and alarm.*/ 
 

 function [3:0] mod_10;
 input [5:0] number;
 begin
 mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
 end
 endfunction
 

 always @(posedge clk_1s or posedge reset )
 begin
 if(reset) begin 
 a_hour1 <= 2'b00;
 a_hour0 <= 4'b0000;
 a_min1 <= 4'b0000;
 a_min0 <= 4'b0000;
 a_sec1 <= 4'b0000;
 a_sec0 <= 4'b0000;
 tmp_hour <= H_in1*10 + H_in0;
 tmp_minute <= M_in1*10 + M_in0;
 tmp_second <= 0;
 end 
 else begin
 if(LD_alarm) begin // LD_alarm =1 => set alarm clock to H_in, M_in
 a_hour1 <= H_in1;
 a_hour0 <= H_in0;
 a_min1 <= M_in1;
 a_min0 <= M_in0;
 a_sec1 <= 4'b0000;
 a_sec0 <= 4'b0000;
 end 
 if(LD_time) begin // LD_time =1 => set time to H_in, M_in
 tmp_hour <= H_in1*10 + H_in0;
 tmp_minute <= M_in1*10 + M_in0;
 tmp_second <= 0;
 end 
 else begin  // LD_time =0 , clock operates normally
 tmp_second <= tmp_second + 1;
 if(tmp_second >=59) begin // second > 59 then minute increases
 tmp_minute <= tmp_minute + 1;
 tmp_second <= 0;
 if(tmp_minute >=59) begin // minute > 59 then hour increases
 tmp_minute <= 0;
 tmp_hour <= tmp_hour + 1;
 if(tmp_hour >= 24) begin // hour > 24 then set hour to 0
 tmp_hour <= 0;
 end 
 end 
 end
 end 
 end 
 end 
 
 always @(posedge clk or posedge reset)
 begin
 if(reset) 
 begin
 tmp_1s <= 0;
 clk_1s <= 0;
 end
 else begin
 tmp_1s <= tmp_1s + 1;
 if(tmp_1s <= 5) 
 clk_1s <= 0;
 else if (tmp_1s >= 10) begin
 clk_1s <= 1;
 tmp_1s <= 1;
 end
 else
 clk_1s <= 1;
 end
 end
 

 always @(*) begin

 if(tmp_hour>=20) begin
 c_hour1 = 2;
 end
 else begin
 if(tmp_hour >=10) 
 c_hour1  = 1;
 else
 c_hour1 = 0;
 end
 c_hour0 = tmp_hour - c_hour1*10; 
 c_min1 = mod_10(tmp_minute); 
 c_min0 = tmp_minute - c_min1*10;
 c_sec1 = mod_10(tmp_second);
 c_sec0 = tmp_second - c_sec1*10; 
 end

 assign H_out1 = c_hour1; // the most significant hour digit of the clock
 assign H_out0 = c_hour0; // the least significant hour digit of the clock
 assign M_out1 = c_min1; // the most significant minute digit of the clock
 assign M_out0 = c_min0; // the least significant minute digit of the clock
 assign S_out1 = c_sec1; // the most significant second digit of the clock
 assign S_out0 = c_sec0; // the least significant second digit of the clock 


 always @(posedge clk_1s or posedge reset) begin
 if(reset) 
 Alarm <=0; 
 else begin
 if({a_hour1,a_hour0,a_min1,a_min0,a_sec1,a_sec0}=={c_hour1,c_hour0,c_min1,c_min0,c_sec1,c_sec0})
 begin // if alarm time equals clock time, it will pulse high the Alarm signal 
 if(alarm_on) Alarm <= 1; 
 end
 if(set_alarm) Alarm <=0; // when STOP_al = 1, push low the Alarm signal
 end
 end
 
endmodule
