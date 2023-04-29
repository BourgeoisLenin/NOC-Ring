module EXMEM_WB (
    clk,reset,flush,
    EXMEM_rD,EXMEM_wrEn,EXMEM_ppp,
    EXMEM_ALU_out,EXMEM_mem_data_out,EXMEM_rD_data_select,
    WB_wrEn,WB_rD_data_select,WB_rD,WB_ALU_out,WB_mem_data_out,WB_ppp
);
    
    input wire clk,reset,flush,EXMEM_wrEn,EXMEM_rD_data_select;
    input wire [0:2] EXMEM_ppp;
    input wire [0:4] EXMEM_rD;
    input wire [0:63] EXMEM_ALU_out,EXMEM_mem_data_out;

    output reg WB_wrEn,WB_rD_data_select;
    output reg [0:4] WB_rD;
    output reg [0:63] WB_ALU_out,WB_mem_data_out;
    output reg [0:2] WB_ppp;

    always @(posedge clk) begin
        if(reset | flush) begin
            WB_wrEn <= 0;
            WB_rD <= 0;
            WB_rD_data_select <= 0;
            WB_ALU_out <= 0;
            WB_mem_data_out <= 0;
            WB_ppp <= 0;
        end
        else begin
            WB_wrEn <= EXMEM_wrEn;
            WB_rD <= EXMEM_rD;
            WB_rD_data_select <= EXMEM_rD_data_select;
            WB_ALU_out <= EXMEM_ALU_out;
            WB_mem_data_out <= EXMEM_mem_data_out;
            WB_ppp <= EXMEM_ppp;
        end
    end

endmodule