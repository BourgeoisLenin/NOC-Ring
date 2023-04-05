module arbiter (
    clk, reset, req1, req2, ack1, ack2
);
    input wire clk, reset, req1,req2;
    output reg ack1,ack2;

    reg priority; // 1 to grant ack2, 0 to grant ack1;

    always @(posedge clk) begin
        if (reset) begin
            priority <= 1'b0;
        end 
        else if(req1&&req2) begin
            priority <= ~priority;
        end
    end

    always @(*) begin
        if(req1&&req2) begin
            ack1 = ~priority;
            ack2 = priority;
        end
        else begin
            ack1 = req1;
            ack2 = req2;
        end
    end
    

endmodule
