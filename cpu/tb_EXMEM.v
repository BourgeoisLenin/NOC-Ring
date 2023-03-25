/*module EXMEM (
    clk,reset,
    EXMEM_rA_data, EXMEM_rB_data,
    EXMEM_rD, EXMEM_ppp,EXMEM_WW,
    EXMEM_op_code,EXMEM_wrEn,EXMEM_memEn,EXMEM_memwrEn,
    EXMEM_forward_rA, EXMEM_forward_rB,EXMEM_imm_addr,
    WB_data,

    EXMEM_ALU_out,EXMEM_mem_data_in,EXMEM_stall,EXMEM_rD_data_select

);

    input wire clk, reset;
    input wire [0:63] EXMEM_rA_data, EXMEM_rB_data,WB_data; 
    // m type inst rb data is actually rd data, use for store
    input wire [0:4] EXMEM_rD;
    input wire [0:2] EXMEM_ppp;
    input wire [0:1] EXMEM_WW;
    input wire [0:5] EXMEM_op_code;
    input wire EXMEM_wrEn,EXMEM_memEn, EXMEM_memwrEn;
    input wire EXMEM_forward_rA, EXMEM_forward_rB;
    input wire [0:15] EXMEM_imm_addr;

    output wire [0:63] EXMEM_ALU_out; // to EXMEM_WB
    output wire [0:63] EXMEM_mem_data_in; // to dmem
    output reg EXMEM_stall; // to IF_ID, ID_EXMEM as stall, to EXMEM_WB as nop
    output reg rD_data_select; // to EXMEM_WB 1 for mem, 0 for alu
endmodule*/
`timescale 1ns/10ps

module tb_EXMEM;
parameter     And                  = 6'b 000001,
              Or                   = 6'b 000010,
              XOR                  = 6'b 000011,
              Not                  = 6'b 000100,
              Move                 = 6'b 000101,
              Add                  = 6'b 000110,
              Subtract             = 6'b 000111,
              Mult_even_unsign     = 6'b 001000,
              Mult_odd_unsign      = 6'b 001001,
              Shift_left_logic     = 6'b 001010,
              Shift_right_logic    = 6'b 001011,
              Shift_right_Arith    = 6'b 001100,
              Rotate_half          = 6'b 001101,
              Division_int_unsign  = 6'b 001110,
              Modulo_int_unsign    = 6'b 001111,
              Square_even_unsign   = 6'b 010000,
              Square_odd_unsign    = 6'b 010001,
              Square_root_int      = 6'b 010010;

    parameter size_8 = 2'b 00,
              size_16 = 2'b 01,
              size_32 = 2'b 10,
              size_64 = 2'b 11;





    reg clk, reset;
    reg [0:63] EXMEM_rA_data, EXMEM_rB_data,WB_data; 
    // m type inst rb data is actually rd data, use for store
    reg [0:4] EXMEM_rD;
    reg [0:2] WB_ppp;
    reg [0:1] EXMEM_WW;
    reg [0:5] EXMEM_op_code;
    reg EXMEM_wrEn,EXMEM_memEn, EXMEM_memwrEn;
    reg EXMEM_forward_rA, EXMEM_forward_rB;
    reg [0:15] EXMEM_imm_addr;

    wire  [0:63] EXMEM_ALU_out; // to EXMEM_WB
    wire  [0:63] EXMEM_mem_data_in; // to dmem
    wire EXMEM_stall; // to IF_ID, ID_EXMEM as stall, to EXMEM_WB as nop
    wire EXMEM_rD_data_select; // to EXMEM_WB 1 for mem, 0 for alu
    wire [0:63] dataOut;
    reg [0:63] final_rB_data;



    

    EXMEM dut(
    clk,reset,
    EXMEM_rA_data, EXMEM_rB_data,
    EXMEM_rD,EXMEM_WW,
    EXMEM_op_code,EXMEM_wrEn,EXMEM_memEn,EXMEM_memwrEn,
    EXMEM_forward_rA, EXMEM_forward_rB,EXMEM_imm_addr,
    WB_data, WB_ppp,

    EXMEM_ALU_out,EXMEM_mem_data_in,EXMEM_stall,EXMEM_rD_data_select

);

    dmem dmem(clk, EXMEM_memEn, EXMEM_memwrEn, EXMEM_imm_addr[0:7], EXMEM_mem_data_in, dataOut);
          //dmem (clk, memEn, memWrEn, memAddr, dataIn, dataOut);


    always @(*) begin
        final_rB_data = dut.EXMEM_forwarded_rB_data;
    end

    initial begin
        clk=0;
        reset=0;
        #1 reset=1;// time 1
        #3 reset = 0;     //time4, test ld inst stall for 2 cycle
        // write to dmem
        EXMEM_wrEn = 1;  EXMEM_memEn = 1;  EXMEM_memwrEn = 1;
        EXMEM_rA_data = 64'd 20;
        EXMEM_rB_data = 64'd 25;
        WB_data = 64'd 30;
        EXMEM_rD = 5'd 5;
        WB_ppp = 3'b 000 ;
        EXMEM_WW = size_64;
        EXMEM_op_code = Add;
        EXMEM_forward_rA = 0;
        EXMEM_forward_rB = 0;
        EXMEM_imm_addr = 16'd 187;
        #4
        EXMEM_wrEn = 1;  EXMEM_memEn = 1;  EXMEM_memwrEn = 1;
        EXMEM_rA_data = 64'd 20;
        EXMEM_rB_data = 64'd 25;
        WB_data = 64'd 30;
        EXMEM_rD = 5'd 5;
        WB_ppp = 3'b 000 ;
        EXMEM_WW = size_64;
        EXMEM_op_code = Add;
        EXMEM_forward_rA = 0;
        EXMEM_forward_rB = 0;
        EXMEM_imm_addr = 16'd 187;
        #4
        EXMEM_wrEn = 1;  EXMEM_memEn = 1;  EXMEM_memwrEn = 0;
        EXMEM_rA_data = 64'd 20;
        EXMEM_rB_data = 64'd 25;
        WB_data = 64'd 30;
        EXMEM_rD = 5'd 5;
        WB_ppp = 3'b 000 ;
        EXMEM_WW = size_64;
        EXMEM_op_code = Add;
        EXMEM_forward_rA = 0;
        EXMEM_forward_rB = 0;
        EXMEM_imm_addr = 16'd 187;
        #4
        /*EXMEM_wrEn = 1;  EXMEM_memEn = 0;  EXMEM_memwrEn = 0;
        EXMEM_rA_data = 64'd 20;
        EXMEM_rB_data = 64'd 25;
        WB_data = 64'd 30;
        EXMEM_rD = 5'd 5;
        WB_ppp = 3'b 000 ;
        EXMEM_WW = size_64;
        EXMEM_op_code = Add;
        EXMEM_forward_rA = 0;
        EXMEM_forward_rB = 0;
        EXMEM_imm_addr = 16'd 187;*/
        #4
        #4
        EXMEM_wrEn = 1;  EXMEM_memEn = 0;  EXMEM_memwrEn = 0;
        EXMEM_rA_data = 64'd 20;
        EXMEM_rB_data = 64'd 25;
        WB_data = 64'd 30;
        EXMEM_rD = 5'd 5;
        WB_ppp = 3'b 000 ;
        EXMEM_WW = size_64;
        EXMEM_op_code = Add;
        EXMEM_forward_rA = 0;
        EXMEM_forward_rB = 0;
        EXMEM_imm_addr = 16'd 187;
        #4
        EXMEM_wrEn = 1;  EXMEM_memEn = 0;  EXMEM_memwrEn = 0;
        EXMEM_rA_data = 64'd 20;
        EXMEM_rB_data = 64'd 25;
        WB_data = 64'd 30;
        EXMEM_rD = 5'd 5;
        WB_ppp = 3'b 000 ;
        EXMEM_WW = size_64;
        EXMEM_op_code = Add;
        EXMEM_forward_rA = 1;
        EXMEM_forward_rB = 0;
        EXMEM_imm_addr = 16'd 187;
        #4 $stop;
        end

    always  begin
       #2 clk = ~clk;
    end
endmodule