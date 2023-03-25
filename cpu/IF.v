module IF (
    clk,reset,inst_in,ID_br_pc,br_ctrl,pc_out,stall
);

    input wire clk, reset, br_ctrl,stall;
    input wire [0:31] inst_in;
    input wire [0:31] ID_br_pc;
    output wire [0:31] pc_out;
    
    reg [0:31] next_pc;
    wire [0:31] pc_plus_four;
    reg [0:31] pc;

    assign pc_out = pc;
    assign pc_plus_four = pc + 4;
    always @(posedge clk) begin
        if(reset) begin
            pc <= 0;
        end
        else if(!stall) begin
            pc <= next_pc;
        end
    end

    always @(*) begin
        if(br_ctrl) begin
            next_pc = ID_br_pc;
        end
        else begin
            next_pc = pc_plus_four;
        end
    end

endmodule