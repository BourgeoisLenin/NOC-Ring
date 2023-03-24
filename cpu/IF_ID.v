module IF_ID (
    clk,reset,flush,IF_inst,IF_pc,ID_inst,ID_pc,stall
);
    input wire clk,reset,flush;
    input wire [0:31] IF_inst;
    input wire [0:31] IF_pc;
    input wire stall;
    output reg [0:31] ID_inst;
    output reg [0:31] ID_pc;

    always @(posedge clk) begin
        if(reset) begin
            ID_inst <= 0;
            ID_pc <= 0;
        end
        else if(flush) begin
            ID_inst <= 32'h F0000000;
            ID_pc <= 0;
        end
        else if(!stall)begin
            ID_inst <= IF_inst;
            ID_pc <= IF_pc;
        end
    end

endmodule