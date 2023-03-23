module IF_ID (
    clk,reset,ID_flush,IF_inst,IF_pc,ID_inst,ID_pc
);
    input wire clk,reset,ID_flush;
    input wire [0:31] IF_inst;
    input wire [0:31] IF_pc;
    output reg [0:31] ID_inst;
    output reg [0:31] ID_pc;

    always @(posedge clk) begin
        if(reset) begin
            ID_inst <= 0;
            ID_pc <= 0;
        end
        else if(ID_flush) begin
            ID_inst <= 32'h F0000000;
            ID_pc <= 0;
        end
        else begin
            ID_inst <= IF_inst;
            ID_pc <= IF_pc;
        end
    end

endmodule