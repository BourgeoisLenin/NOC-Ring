module WB (
    WB_wrEn,WB_rD_data_select, WB_rD,WB_ALU_out,WB_mem_data_out,
    WB_data
);

    input wire WB_wrEn,WB_rD_data_select;
    input wire [0:4] WB_rD;
    input wire [0:63] WB_ALU_out,WB_mem_data_out;
    output wire [0:63] WB_data;

    assign WB_data = WB_rD_data_select?WB_mem_data_out:WB_ALU_out;

endmodule