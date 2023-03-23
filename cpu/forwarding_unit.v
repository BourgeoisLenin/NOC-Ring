module forwarding_unit (
    ID_rA, ID_rB, EX_MEM_rD, EX_MEM_wrEn, ID_forward_rA, ID_forawrd_rB
);
    input wire [0:4] ID_rA, ID_rB, EX_MEM_rD;
    input wire EX_MEM_wrEn;
    output wire ID_forward_rA, ID_forawrd_rB;

    assign ID_forward_rA = (ID_rA == EX_MEM_rD) && (|EX_MEM_rD) && EX_MEM_wrEn;
    assign ID_forward_rB = (ID_rB == EX_MEM_rD) && (|EX_MEM_rD) && EX_MEM_wrEn;

endmodule