module decode (
    inst,ID_wrEn,ID_rD,ID_rA,ID_rB,ID_WW
);
    input wire[0:31] inst;
    output wire [0:4] ID_rD,ID_rA,ID_rB;
    output wire [0:1] ID_WW;
    output reg ID_wrEn;

    parameter RTYPE = 6'b101010;
    parameter WW_BYTE = 2'b00;
    parameter WW_HALF = 2'b01;
    parameter WW_WORD = 2'b10;
    parameter WW_DW = 2'b11;

    wire [0:5] type_identifier;
    wire [0:5] OP_code;
    wire [0:15] imm_addr;
    wire [0:2] ppp;

    assign type_identifier = inst[0:5];
    assign OP_code = inst[26:31];
    assign imm_addr = inst[16:31];
    assign ppp = inst[21:23];
    

    always @(*) begin
        if()
    end
    
endmodule