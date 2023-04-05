module router_input_ctrl (
    clk, reset, polarity, si,ri,di, dout, req,ack
);
    input wire clk, reset, polarity, si;
    input wire [63:0] di;
    input wire ack;
    output reg  ri, req;
    output reg [63:0] dout;

    reg odd_full, even_full;
    reg [63:0] odd_buf, even_buf;

    always @(posedge clk) begin
        if(reset) begin
            odd_full <= 1'b0;
            even_full <= 1'b0;
            even_buf <= 0;
            odd_buf <= 0;
        end
        else begin
            if(si) begin // externally receive
                if(polarity) begin
                    even_buf <= di;
                    even_full <= 1'b1;
                end
                else begin
                    odd_buf <= di;
                    odd_full <= 1'b1; 
                end
            end
            if(ack) begin // internal forward granted
                if(polarity)
                    odd_full <= 1'b0;
                else   
                    even_full <= 1'b0;
            end
        end
    end

    always @(*) begin
        if(polarity) begin
            //internal forawrd
            req = odd_full;
            dout = odd_buf;
            //external receive
            ri = !even_full;
        end
        else begin
            //internal forward
            req = even_full;
            dout = even_buf;
            //external receive
            ri = !odd_full;
        end
    end
    

endmodule