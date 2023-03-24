module EXMEM (
    clk,reset,
    EXMEM_rA_data, EXMEM_rB_data,
    EXMEM_rD,EXMEM_WW,
    EXMEM_op_code,EXMEM_wrEn,EXMEM_memEn,EXMEM_memwrEn,
    EXMEM_forward_rA, EXMEM_forward_rB,EXMEM_imm_addr,
    WB_data, WB_ppp,

    EXMEM_ALU_out,EXMEM_mem_data_in,EXMEM_stall,EXMEM_rD_data_select

);

    input wire clk, reset;
    input wire [0:63] EXMEM_rA_data, EXMEM_rB_data,WB_data; 
    // m type inst rb data is actually rd data, use for store
    input wire [0:4] EXMEM_rD;
    input wire [0:2] WB_ppp;
    input wire [0:1] EXMEM_WW;
    input wire [0:5] EXMEM_op_code;
    input wire EXMEM_wrEn,EXMEM_memEn, EXMEM_memwrEn;
    input wire EXMEM_forward_rA, EXMEM_forward_rB;
    input wire [0:15] EXMEM_imm_addr;

    output wire [0:63] EXMEM_ALU_out; // to EXMEM_WB
    output wire [0:63] EXMEM_mem_data_in; // to dmem
    output reg EXMEM_stall; // to IF_ID, ID_EXMEM as stall, to EXMEM_WB as nop
    output reg EXMEM_rD_data_select; // to EXMEM_WB 1 for mem, 0 for alu

    reg [0:63] EXMEM_forwarded_rA_data,EXMEM_forwarded_rB_data;

    reg counter;
    reg next_counter;

    assign EXMEM_mem_data_in = EXMEM_forwarded_rB_data;

    ALU alu(EXMEM_forwarded_rA_data,EXMEM_forwarded_rB_data,EXMEM_ALU_out,EXMEM_WW,EXMEM_op_code);

    
    always @(posedge clk) begin
        if(reset)
            counter <= 0;
        else
            counter <= next_counter;
    end

    //forwarding
    always @(*) begin
        //ra data
        EXMEM_forwarded_rA_data = EXMEM_rA_data;
        if(EXMEM_forward_rA) begin
            if(!(|WB_ppp)) begin
                EXMEM_forwarded_rA_data = WB_data;
            end
            else if(WB_ppp==3'b001) begin
                EXMEM_forwarded_rA_data [0:31] = WB_data[0:31];

            end
            else if(WB_ppp==3'b010) begin
                EXMEM_forwarded_rA_data [32:63] = WB_data[32:63];
            end
            else if(WB_ppp==3'b011) begin
                EXMEM_forwarded_rA_data [0:7] = WB_data [0:7];
                EXMEM_forwarded_rA_data [16:23] = WB_data[16:23];
                EXMEM_forwarded_rA_data [32:39] = WB_data[32:39];
                EXMEM_forwarded_rA_data [48:55] = WB_data[48:55];
                //register_file[rD] <= {d_in[0:7], register_file[rD][8:15], d_in[16:23],register_file[24:31],d_in[32:39],register_file[40:47],d_in[48:55],register_file[56:63]};
            end
            else if(WB_ppp==3'b100) begin
                EXMEM_forwarded_rA_data [8:15] = WB_data[8:15];
                EXMEM_forwarded_rA_data [24:31] = WB_data[24:31];
                EXMEM_forwarded_rA_data [40:47] = WB_data[40:47];
                EXMEM_forwarded_rA_data [56:63] = WB_data[56:63];
            end
        end

        // rb data
        EXMEM_forwarded_rB_data = EXMEM_rB_data;
        if(EXMEM_forward_rB) begin
            if(!(|WB_ppp)) begin
                EXMEM_forwarded_rB_data = WB_data;
            end
            else if(WB_ppp==3'b001) begin
                EXMEM_forwarded_rB_data [0:31] = WB_data[0:31];
            end
            else if(WB_ppp==3'b010) begin
                EXMEM_forwarded_rB_data [32:63] = WB_data[32:63];
            end
            else if(WB_ppp==3'b011) begin
                EXMEM_forwarded_rB_data [0:7] = WB_data [0:7];
                EXMEM_forwarded_rB_data [16:23] = WB_data[16:23];
                EXMEM_forwarded_rB_data [32:39] = WB_data[32:39];
                EXMEM_forwarded_rB_data [48:55] = WB_data[48:55];
                //register_file[rD] <= {d_in[0:7], register_file[rD][8:15], d_in[16:23],register_file[24:31],d_in[32:39],register_file[40:47],d_in[48:55],register_file[56:63]};
            end
            else if(WB_ppp==3'b100) begin
                EXMEM_forwarded_rB_data [8:15] = WB_data[8:15];
                EXMEM_forwarded_rB_data [24:31] = WB_data[24:31];
                EXMEM_forwarded_rB_data [40:47] = WB_data[40:47];
                EXMEM_forwarded_rB_data [56:63] = WB_data[56:63];
            end
        end
    end

    //memory load wrapper/stall
    always @(*) begin
        if(EXMEM_memEn&&EXMEM_wrEn&& (!EXMEM_memwrEn)) begin //load
            EXMEM_rD_data_select = 1;
            if(!counter) begin
                EXMEM_stall = 1;
                next_counter = ~counter;
            end
            else if(counter) begin
                EXMEM_stall = 0;
                next_counter = ~counter;
            end
        end
        else 
            EXMEM_rD_data_select = 0;
        /*
        else if (EXMEM_memEn&& (!EXMEM_wrEn) && EXMEM_memwrEn) begin //store
            
        end
        */
    end

endmodule