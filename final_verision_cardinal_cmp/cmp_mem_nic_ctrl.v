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