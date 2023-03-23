module ID (
    clk,reset,
    ID_inst,ID_pc,
    EX_MEM_rD,EX_MEM_wrEn,
    WB_rD,WB_wrEn,WB_ppp,WB_rD_data,
    ID_rA_data,ID_rB_data,
    ID_rD,ID_rA,ID_rB,
    ID_WW,
    ID_ppp,
    ID_wrEn,ID_memEn,ID_memwrEn,
    ID_br_ctrl,
    ID_forward_rA, ID_forawrd_rB,
    ID_br_pc
);
    input wire clk,reset;
    input wire [0:31] ID_inst, ID_pc;
    input wire [0:4] WB_rD;
    input wire WB_wrEn;
    input wire [0:2] WB_ppp;
    input wire [0:63] WB_rD_data;
    input wire [0:4] EX_MEM_rD;
    input wire EX_MEM_wrEn;

    output wire [0:63] ID_rA_data, ID_rB_data;
    output wire [0:4] ID_rD,ID_rA,ID_rB;
    output wire [0:1] ID_WW;
    output wire [0:2] ID_ppp;
    output wire ID_wrEn,ID_memEn,ID_memwrEn;
    output wire ID_br_ctrl;
    output wire ID_forward_rA, ID_forawrd_rB;
    output wire [0:15] ID_br_pc;

    wire ID_decode_ctrl_bez,ID_decode_ctrl_bnez;
    wire ID_R_type;
    wire [0:4] rf_in2;

    assign rf_in2 = ID_R_type? ID_rB: ID_rD;

    decode_ctrl decode_ctrl(ID_inst,
    ID_wrEn,ID_rD,ID_rA,ID_rB,ID_WW, ID_ppp,
    ID_memEn,ID_memwrEn,ID_decode_ctrl_bez,ID_decode_ctrl_bnez,ID_R_type,ID_br_pc);

    //connect M_type_rD_data to ID_rB_data - done
    br_ctrl br_ctrl(ID_decode_ctrl_bez,ID_decode_ctrl_bnez, ID_rB_data,ID_br_ctrl);

    RF reg_file(clk,reset,WB_wrEn,ID_rA,rf_in2,WB_rD,WB_ppp,WB_rD_data,ID_rA_data,ID_rB_data);

    forwarding_unit forward_ctrl(ID_rA, ID_rB, EX_MEM_rD, EX_MEM_wrEn, ID_forward_rA, ID_forawrd_rB);

    //branch and hdu

    


endmodule