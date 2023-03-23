`timescale 1ns/1ns



module tb_RF ;
  reg clk,reset,wrEn;
  reg [0:4] rA,rB,rD;
  reg [0:2] ppp;
  reg[0:63] d_in;
  wire[0:63] d_out1,d_out2;

  initial begin
    clk = 0 ;
    reset = 0;
    wrEn = 0;
    #1 reset = 1;
    #7 reset = 0;//time 8
    ppp = 3'b 000;
    rA  = 5'b 00110;
    rB  = 5'b 00101;
    #4 //time 12
    wrEn = 1;
    rD = 5'b 00011;
    d_in = 1777777777;
    #4 // time16
    wrEn =1;
    rD = 5'b 00001;
    ppp = 3'b 011;
    d_in = 1777777777;
    #4 //time20
    wrEn =1;
    rD = 5'b 00010;
    ppp = 3'b 100;
    d_in = 1777777777;
    #4 // time 24
    wrEn = 1;
    rA = 5'b00100;
    rD = 5'b00100;
    ppp = 3'b 000;
    d_in = 1555555587;

    #20 $stop;
  end


 RF U1 (.*);


  always  begin
    #2 clk = ~clk;
  end

endmodule
