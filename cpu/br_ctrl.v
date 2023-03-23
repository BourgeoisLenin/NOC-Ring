module br_ctrl (
    ID_decode_ctrl_bez,ID_decode_ctrl_bnez, M_type_rD_data,ID_br_ctrl
);
    
    input wire ID_decode_ctrl_bez,ID_decode_ctrl_bnez;
    input wire [0:63] M_type_rD_data;
    output reg ID_br_ctrl;

    always@(*) begin
        if(ID_decode_ctrl_bez) begin
            ID_br_ctrl = !(|M_type_rD_data);
        end
        else if(ID_decode_ctrl_bnez) begin
            ID_br_ctrl = (|M_type_rD_data);
        end
        else begin
            ID_br_ctrl = 0;
        end
    end
    
endmodule