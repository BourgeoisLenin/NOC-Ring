module ID_EXMEM (
    clk,reset,
    ID_rA_data, ID_rB_data,
    ID_rD,
    //ID_rA,ID_rB,
    ID_ppp,ID_WW,ID_op_code,
    ID_wrEn,ID_memEn,ID_memwrEn,
    ID_forward_rA, ID_forward_rB,
    ID_imm_addr,
    stall,
    EXMEM_rA_data, EXMEM_rB_data,
    EXMEM_rD,EXMEM_ppp,EXMEM_WW,EXMEM_op_code,
    EXMEM_wrEn,EXMEM_memEn,EXMEM_memwrEn,
    EXMEM_forward_rA, EXMEM_forward_rB,
    EXMEM_imm_addr
);
    input wire clk,reset;
    input wire [0:63] ID_rA_data, ID_rB_data;
    input wire [0:4] ID_rD /*,ID_rA,ID_rB*/;
    input wire [0:2] ID_ppp;
    input wire [0:1] ID_WW;
    input wire [0:5] ID_op_code;
    input wire ID_wrEn,ID_memEn,ID_memwrEn;
    input wire ID_forward_rA, ID_forward_rB;
    input wire [0:15] ID_imm_addr;
    input wire stall;

    output reg [0:63] EXMEM_rA_data, EXMEM_rB_data; 
    // m type inst rb data is actually rd data, need this feature for store and branch
    output reg [0:4] EXMEM_rD /*,EXMEM_rA,EXMEM_rB*/;
    output reg [0:2] EXMEM_ppp;
    output reg [0:1] EXMEM_WW;
    output reg [0:5] EXMEM_op_code;
    output reg EXMEM_wrEn,EXMEM_memEn,EXMEM_memwrEn;
    output reg EXMEM_forward_rA, EXMEM_forward_rB;
    output reg [0:15] EXMEM_imm_addr;

    always @(posedge clk) begin
        if(reset) begin
            EXMEM_rA_data <= 0;
            EXMEM_rB_data <= 0;
            EXMEM_rD <= 0;
            //EXMEM_rA <= 0;
            //EXMEM_rB <= 0;
            EXMEM_ppp <= 0;
            EXMEM_WW <= 0;
            EXMEM_op_code <= 0;
            EXMEM_wrEn <= 0;
            EXMEM_memEn <= 0;
            EXMEM_memwrEn <= 0;
            EXMEM_forward_rA <= 0;
            EXMEM_forward_rB <= 0;
            EXMEM_imm_addr <= 0;
        end
        else if(!stall) begin
            EXMEM_rA_data <= ID_rA_data;
            EXMEM_rB_data <= ID_rB_data;
            EXMEM_rD <= ID_rD;
            //EXMEM_rA <= ID_rA;
            //EXMEM_rB <= ID_rB;
            EXMEM_ppp <= ID_ppp;
            EXMEM_WW <= ID_WW;
            EXMEM_op_code <= ID_op_code;
            EXMEM_wrEn <= ID_wrEn;
            EXMEM_memEn <= ID_memEn;
            EXMEM_memwrEn <= ID_memwrEn;
            EXMEM_forward_rA <= ID_forward_rA;
            EXMEM_forward_rB <= ID_forward_rB;
            EXMEM_imm_addr <= ID_imm_addr;
        end
    end
endmodule