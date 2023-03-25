module cmp 
(
    clk,reset,inst_in,d_in,pc_out,d_out,addr_out,memWrEn,memEn
);
    input wire clk, reset;
    input wire [0:31] inst_in;
    input wire [0:63] d_in;
    output wire [0:31] pc_out;
    output wire [0:63] d_out;
    output wire [0:31] addr_out;
    output wire memWrEn, memEn;


    // IF_ID
    wire IFID_flush;
    wire [0:31] IF_pc_out;
    assign pc_out = IF_pc_out;

    // ID
    wire ID_br_ctrl;
    wire [0:31] ID_imm_addr;
    wire [0:31] ID_inst;
    wire [0:31] ID_pc;
    wire IF_ID_stall;
    wire [0:63] ID_rA_data,ID_rB_data;
    wire [0:4] ID_rD;
    wire [0:4] ID_rA, ID_rB;
    wire [0:1] ID_WW;
    wire [0:2] ID_ppp;
    wire ID_wrEn,ID_memEn,ID_memwrEn, ID_forward_rA,ID_forward_rB;
    wire [0:5] ID_op_code;

    //ID EXMEM
    wire ID_EXMEM_stall;
    //EXMEM
    wire [0:4] EXMEM_rD;
    wire EXMEM_wrEn;
    wire [0:63] EXMEM_rA_data, EXMEM_rB_data;
    wire [0:2] EXMEM_ppp;
    wire [0:1] EXMEM_WW;
    wire [0:5] EXMEM_op_code;
    wire EXMEM_memEn,EXMEM_memwrEn,EXMEM_forward_rA,EXMEM_forward_rB;
    wire [0:15] EXMEM_imm_addr;
    wire [0:63] EXMEM_ALU_out,EXMEM_mem_data_in;
    wire EXMEM_stall; //used to stall IFID and ID EXMEM on memory load
    wire EXMEM_rD_data_select;

    // EXMEM_WB
    wire [0:63] EXMEM_mem_data_out;

    // WB
    wire [0:4] WB_rD;
    wire WB_wrEn,WB_rD_data_select;
    wire [0:2] WB_ppp;
    wire [0:63] WB_data;
    wire [0:63] WB_ALU_out,WB_mem_data_out;
    

    
    assign d_out = EXMEM_mem_data_in;
    assign addr_out = EXMEM_imm_addr;
    assign memEn = EXMEM_memEn;
    assign memWrEn = EXMEM_memwrEn;
    assign IF_ID_stall = EXMEM_stall;
    assign ID_EXMEM_stall = EXMEM_stall;

    IF IF_stage(
        clk,reset,inst_in,ID_imm_addr,ID_br_ctrl,IF_pc_out
    );

    IF_ID IF_ID_reg(
        clk,reset,ID_br_ctrl,inst_in,IF_pc_out,ID_inst,ID_pc,IF_ID_stall
    );

    ID ID_stage(
        clk,reset,
        ID_inst, // from imem
        EXMEM_rD,EXMEM_wrEn,
        WB_rD,WB_wrEn,WB_ppp,WB_data,
        ID_rA_data,ID_rB_data,
        ID_rD,
        ID_rA,ID_rB,
        ID_WW,
        ID_ppp,
        ID_wrEn,ID_memEn,ID_memwrEn,
        ID_br_ctrl,
        ID_forward_rA,ID_forward_rB,
        ID_imm_addr,ID_op_code
    );

    ID_EXMEM ID_EXMEM_reg(
        clk,reset,
        ID_rA_data, ID_rB_data,
        ID_rD,
        //ID_rA,ID_rB,
        ID_ppp,ID_WW,ID_op_code,
        ID_wrEn,ID_memEn,ID_memwrEn,
        ID_forward_rA, ID_forward_rB,
        ID_imm_addr,
        ID_EXMEM_stall,
        EXMEM_rA_data, EXMEM_rB_data,
        EXMEM_rD,EXMEM_ppp,EXMEM_WW,EXMEM_op_code,
        EXMEM_wrEn,EXMEM_memEn,EXMEM_memwrEn,
        EXMEM_forward_rA, EXMEM_forward_rB,
        EXMEM_imm_addr
    );

    EXMEM EXMEM_stage (
        clk,reset,
        EXMEM_rA_data, EXMEM_rB_data,
        EXMEM_rD,EXMEM_WW,
        EXMEM_op_code,EXMEM_wrEn,EXMEM_memEn,EXMEM_memwrEn,
        EXMEM_forward_rA, EXMEM_forward_rB,EXMEM_imm_addr,
        WB_data, WB_ppp,
        EXMEM_ALU_out,EXMEM_mem_data_in,EXMEM_stall,EXMEM_rD_data_select
    );

    EXMEM_WB EXMEM_WB_stage(
        clk,reset,EXMEM_stall, //stall signal is used as flush
        EXMEM_rD,EXMEM_wrEn,EXMEM_ppp,
        EXMEM_ALU_out,EXMEM_mem_data_out,EXMEM_rD_data_select,
        WB_wrEn,WB_rD_data_select,WB_rD,WB_ALU_out,WB_mem_data_out,WB_ppp
    );

    WB WB_stage(
        WB_wrEn,WB_rD_data_select, WB_rD,WB_ALU_out,WB_mem_data_out,
        WB_data
    );

endmodule
