module decode_ctrl (
    inst,
    ID_wrEn,ID_rD,ID_rA,ID_rB,ID_WW,
    ID_memEn,ID_memwrEn,ID_decode_ctrl_bez,ID_decode_ctrl_bnez
);
    input wire[0:31] inst;
    output wire [0:4] ID_rD,ID_rA,ID_rB;
    output wire [0:1] ID_WW;
    output reg ID_wrEn,ID_memEn,ID_memwrEn,ID_decode_ctrl_bez,ID_decode_ctrl_bnez;

    parameter RTYPE = 6'b101010;
    parameter VLD = 6'b100000;
    parameter VSD = 6'b100001;
    parameter VBEZ = 6'b100010;
    parameter VBNEZ = 6'b100011;
    parameter VNOP = 6'b111100;
    /*
    parameter WW_BYTE = 2'b00;
    parameter WW_HALF = 2'b01;
    parameter WW_WORD = 2'b10;
    parameter WW_DW = 2'b11;
    */

    wire [0:5] type_identifier;
    wire [0:5] OP_code;
    wire [0:15] imm_addr;
    wire [0:2] ppp;

    //general
    assign type_identifier = inst[0:5];
    assign ID_rD = inst[6:10];

    //RTYPE
    assign OP_code = inst[26:31];
    
    assign ID_rA = inst[11:15];
    assign ID_rB = inst[16:20];
    assign ppp = inst[21:23];
    assign ID_WW = inst[24:25];
    //MTYPE
    assign imm_addr = inst[16:31];

    // inst decode
    always @(*) begin
        ID_wrEn = 0;
        ID_memEn = 0;
        ID_memwrEn = 0;
        ID_decode_ctrl_bez = 0;
        ID_decode_ctrl_bnez = 0;
        case (type_identifier)
            RTYPE: begin
                ID_wrEn = 1;
                ID_memEn = 0;
                ID_memwrEn = 0;
                ID_decode_ctrl_bez = 0;
                ID_decode_ctrl_bnez = 0;
            end
            VLD: begin
                ID_wrEn = 0;
                ID_memEn = (!(|ID_rA));
                ID_memwrEn = 0;
                ID_decode_ctrl_bez = 0;
                ID_decode_ctrl_bnez = 0;  
                
            end 
            VSD: begin
                ID_wrEn = 0;
                ID_memEn = (!(|ID_rA));
                ID_memwrEn = (!(|ID_rA));
                ID_decode_ctrl_bez = 0;
                ID_decode_ctrl_bnez = 0;
            end 
            VBEZ: begin
                ID_wrEn = 0;
                ID_memEn = 0;
                ID_memwrEn = 0;
                ID_decode_ctrl_bez = (!(|ID_rA));
                ID_decode_ctrl_bnez = 0;
            end
            VBEZ: begin
                ID_wrEn = 0;
                ID_memEn = 0;
                ID_memwrEn = 0;
                ID_decode_ctrl_bez = 0;
                ID_decode_ctrl_bnez = (!(|ID_rA));
            end 
            VNOP: begin
                ID_wrEn = 0;
                ID_memEn = 0;
                ID_memwrEn = 0;
                ID_decode_ctrl_bez = 0;
                ID_decode_ctrl_bnez = 0;
            end
            default: begin
                ID_wrEn = 0;
                ID_memEn = 0;
                ID_memwrEn = 0;
                ID_decode_ctrl_bez = 0;
                ID_decode_ctrl_bnez = 0;
            end
        endcase
    end
endmodule