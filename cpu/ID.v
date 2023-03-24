module ID (
    clk,reset,
    ID_inst,
    EX_MEM_rD,EX_MEM_wrEn,
    WB_rD,WB_wrEn,WB_ppp,WB_rD_data,
    ID_rA_data,ID_rB_data,
    ID_rD,ID_rA,ID_rB,
    ID_WW,
    ID_ppp,
    ID_wrEn,ID_memEn,ID_memwrEn,
    ID_br_ctrl,
    ID_forward_rA,ID_forward_rB,
    ID_imm_addr,ID_op_code
);
    input wire clk,reset;
    input wire [0:31] ID_inst;
    input wire [0:4] WB_rD;
    input wire WB_wrEn;
    input wire [0:2] WB_ppp;
    input wire [0:63] WB_rD_data;
    input wire [0:4] EX_MEM_rD;
    input wire EX_MEM_wrEn;

    output wire [0:63] ID_rA_data, ID_rB_data;
    output wire [0:4] ID_rD,ID_rA,ID_rB; //may not need ra rb to be output
    output wire [0:1] ID_WW;
    output wire [0:2] ID_ppp;
    output wire ID_wrEn,ID_memEn,ID_memwrEn;
    output wire ID_br_ctrl; // this is IF_flush and pc select in IF
    output wire ID_forward_rA, ID_forward_rB;
    output wire [0:15] ID_imm_addr; // this goes to IF
    output wire [0:5] ID_op_code;

    wire ID_decode_ctrl_bez,ID_decode_ctrl_bnez;
    wire rD_as_source;
    wire [0:4] rB_or_rD;

    assign rB_or_rD = rD_as_source? ID_rD: ID_rB;

    decode_ctrl decode_ctrl(ID_inst,
    ID_wrEn,ID_rD,ID_rA,ID_rB,ID_WW, ID_ppp,
    ID_memEn,ID_memwrEn,ID_decode_ctrl_bez,ID_decode_ctrl_bnez,rD_as_source,ID_imm_addr,ID_op_code);

    //connect M_type_rD_data to ID_rB_data - done
    br_ctrl br_ctrl(ID_decode_ctrl_bez,ID_decode_ctrl_bnez, ID_rB_data,ID_br_ctrl);

    RF reg_file(clk,reset,WB_wrEn,ID_rA,rB_or_rD,WB_rD,WB_ppp,WB_rD_data,ID_rA_data,ID_rB_data);

    forwarding_unit forward_ctrl(ID_rA, rB_or_rD, EX_MEM_rD, EX_MEM_wrEn, ID_forward_rA, ID_forward_rB);

    //branch and hdu

    


endmodule