module EXMEM (
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

    wire [0:63] EXMEM_forwarded_rA_data,EXMEM_forwarded_rB_data;

    reg [0:1] counter;
    reg [0:1] next_counter;

    assign EXMEM_forwarded_rA_data = EXMEM_forward_rA?WB_data:EXMEM_rA_data;
    assign EXMEM_forwarded_rB_data = EXMEM_forward_rB?WB_data:EXMEM_rB_data;
    assign EXMEM_mem_data_in = EXMEM_forwarded_rB_data;

    //TODO: forwarding

    ALU alu(EXMEM_forwarded_rA_data,EXMEM_forwarded_rB_data,EXMEM_ALU_out,{EXMEM_WW,EXMEM_op_code});

    
    always @(posedge clk ) begin
        if(reset)
            counter <= 0;
        else
            counter <= next_counter;
    end

    //memory load wrapper/stall
    always @(*) begin
        rD_data_select = 0;
        if(EXMEM_memEn&&EXMEM_wrEn&& (!EXMEM_memwrEn)) begin //load
            rD_data_select = 1;
            if(counter == 0) begin
                EXMEM_stall = 1;
                next_counter = counter + 1;
            end
            else if(counter == 2'b10) begin
                EXMEM_stall = 0;
                next_counter = 0;
            end
        end
        /*
        else if (EXMEM_memEn&& (!EXMEM_wrEn) && EXMEM_memwrEn) begin //store
            
        end
        */
    end

endmodule