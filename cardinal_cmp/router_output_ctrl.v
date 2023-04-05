module router_output_ctrl (
    clk, reset, polarity,req1,req2,ack1,ack2, di1,di2,dout,
    so, ro
);
    input wire clk, reset, polarity, req1, req2, ro;
    input wire [63:0] di1, di2;
    output wire ack1, ack2;
    output wire [63:0] dout;
    output reg so;

    wire arb_ack1,arb_ack2;

    reg odd_full, even_full;
    reg [63:0] odd_buf, even_buf;

    //internal ack
    assign ack1 = polarity?(!odd_full&&arb_ack1):(!even_full&&arb_ack1);
    assign ack2 = polarity?(!odd_full&&arb_ack2):(!even_full&&arb_ack2);
    //external forwarding, output
    assign dout = polarity?even_buf:odd_buf;


    arbiter arbitration(clk,reset,req1,req2,arb_ack1, arb_ack2);

    always @(posedge clk) begin
        if(reset) begin
            odd_full <= 0;
            even_full <= 0;
            odd_buf <= 0;
            even_buf <= 0;
        end
        // internal receiving, input select
        if(ack1) begin
            if(polarity) begin
                odd_buf <= {di1[63:56],1'b0,di1[55:49],di1[47:0]};
                odd_full <= 1;
            end
            else begin
                even_buf <= {di1[63:56],1'b0,di1[55:49],di1[47:0]};
                even_full <= 1;
            end
        end
        else if(ack2) begin
            if(polarity) begin
                odd_buf <= {di2[63:56],1'b0,di2[55:49],di2[47:0]};
                odd_full <= 1;
            end
            else begin
                even_buf <= {di2[63:56],1'b0,di2[55:49],di2[47:0]};
                even_full <= 1;
            end
        end
        // external forwarding
        if(so) begin
            if(polarity)
                even_full <= 0;
            else
                odd_full <= 0;
        end
    end

    //external forwarding signal control
    always @(*) begin
        if(ro) begin
            if(polarity)
                so = even_full; 
            else if (!polarity)
                so = odd_full;
            else
                so = 0;
        end
        else
            so = 0;
    end

endmodule