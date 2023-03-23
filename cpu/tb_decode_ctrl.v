`timescale 1ns/1ns
module tb_decode_ctrl ;
    reg[0:31] inst;
    wire[0:4] ID_rD,ID_rA,ID_rB;
    wire[0:1] ID_WW;
    wire[0:2] ID_ppp;
    wire ID_wrEn,ID_memEn,ID_memwrEn,ID_decode_ctrl_bez,ID_decode_ctrl_bnez;

    decode_ctrl U1(.*);
    initial begin
        inst[0:5]  = 6'b 101010;
        inst[6:10] = 5'b 00110;
        inst[11:15] = 5'b 01000;
        inst[16:20] = 5'b 10000;
        inst[21:23] = 3'b 010;
        inst[24:25] = 2'b 10;
        inst[26:31] = 6'b 000110;
        #10
        inst[0:5]  = 6'b 101010;
        inst[6:10] = 5'b 00110;
        inst[11:15] = 5'b 01000;
        inst[16:20] = 5'b 10000;
        inst[21:23] = 3'b 010;
        inst[24:25] = 2'b 10;
        inst[26:31] = 6'b 001101;
        #10
        inst[0:5]  = 6'b 100000;
        inst[6:10] = 5'd 3;
        inst[11:15] = 5'b 01000;
        inst[16:31] = 16'd 127;
        #10
        inst[0:5]  = 6'b 100000;
        inst[6:10] = 5'd 4;
        inst[11:15] = 5'b 00000;
        inst[16:31] = 16'd 127; 
        #10
        inst[0:5]  = 6'b 100001;
        inst[6:10] = 5'd 5;
        inst[11:15] = 5'b 00001;
        inst[16:31] = 16'd 127; 
        #10
        inst[0:5]  = 6'b 100001;
        inst[6:10] = 5'd 6;
        inst[11:15] = 5'b 00000;
        inst[16:31] = 16'd 127;
        #10
        inst[0:5]  = 6'b 100010;
        inst[6:10] = 5'd 7;
        inst[11:15] = 5'b 00000;
        inst[16:31] = 16'd 127;
        #10
        inst[0:5]  = 6'b 100011;
        inst[6:10] = 5'd 8;
        inst[11:15] = 5'b 00000;
        inst[16:31] = 16'd 127;
        #10
        inst[0:5]  = 6'b 111100;
        inst[6:10] = 5'd 9;
        inst[11:15] = 5'b 00000;
        inst[16:31] = 16'd 127;
        #10 $stop;  
    end
endmodule