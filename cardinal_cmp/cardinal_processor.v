module cmp_mem_nic_ctrl (EXMEM_imm_addr,memEn,wrEn,memEn_dmem,wrEn_dmem,memEn_nic,wrEn_nic,mux_sel);
    input wire[0:31] EXMEM_imm_addr;
    input wire memEn,wrEn;
    output reg memEn_dmem,wrEn_dmem,memEn_nic,wrEn_nic,mux_sel;


    always @(*) begin
        if((EXMEM_imm_addr[16])&&(EXMEM_imm_addr[17])) begin// load or store data from nic
            memEn_nic = memEn;
            wrEn_nic = wrEn;
            memEn_dmem = 1'b 0;
            wrEn_dmem = 1'b 0;
            mux_sel = 1'b 0; //the data receive from nic  
        end
        else begin// load or store data from data_mem
            memEn_nic = 1'b 0;
            wrEn_nic = 1'b 0;
            memEn_dmem = memEn;
            wrEn_dmem = wrEn;
            mux_sel = 1'b 1; // the data receive from dmem
        end
    end
endmodule



module cardinal_processor (
    clk,reset,inst_in,d_in,pc_out,d_out,addr_out,memWrEn,memEn,addr_nic,din_nic,dout_nic,nicEn,nicWrEn
);
    input wire clk, reset;
    input wire [0:31] inst_in;
    input wire [0:63] d_in;
    output wire [0:31] pc_out;
    output wire [0:63] d_out;
    output wire [0:31] addr_out;
    output wire memWrEn, memEn;
    output wire[0:1] addr_nic;
    output wire [0:63] din_nic;
    input wire[0:63] dout_nic;
    output wire nicEn,nicWrEn;

    wire[0:31] addr_out1;
    wire memWrEn_cmp, memEn_cmp;
    wire memEn_dmem,wrEn_dmem;
    wire[0:63] d_out1;
    wire[0:63] d_in_sel;
    wire mux_sel;
    
    assign addr_nic = addr_out1[30:31];
    assign addr_out = addr_out1;
    assign memWrEn = wrEn_dmem;
    assign memEn = memEn_dmem;
    assign d_out = d_out1;
    assign din_nic = d_out1;

    assign d_in_sel = mux_sel? d_in: dout_nic;


    cmp cmp(clk,reset,inst_in,d_in_sel,pc_out,d_out1,addr_out1,memWrEn_cmp,memEn_cmp);
    cmp_mem_nic_ctrl ctrl_block(addr_out1,memEn_cmp,memWrEn_cmp,memEn_dmem,wrEn_dmem,nicEn,nicWrEn,mux_sel);
    

endmodule