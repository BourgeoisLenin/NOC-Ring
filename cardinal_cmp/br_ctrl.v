module br_ctrl (
    ID_decode_ctrl_bez,ID_decode_ctrl_bnez, M_type_rD_data,ID_br_ctrl,ID_forward_rB,br_hazard_stall
);
    
    input wire ID_decode_ctrl_bez,ID_decode_ctrl_bnez,ID_forward_rB;
    input wire [0:63] M_type_rD_data;
    output reg ID_br_ctrl,br_hazard_stall;

    always@(*) begin
        br_hazard_stall = 0;
        if(ID_forward_rB) begin
            br_hazard_stall = 1;
        end
        else if(ID_decode_ctrl_bez) begin
            ID_br_ctrl = !(|M_type_rD_data);
            br_hazard_stall = 0;
        end
        else if(ID_decode_ctrl_bnez) begin
            ID_br_ctrl = (|M_type_rD_data);
            br_hazard_stall = 0;
        end
        else begin
            ID_br_ctrl = 0;
            br_hazard_stall = 0;
        end
    end
    
endmodule