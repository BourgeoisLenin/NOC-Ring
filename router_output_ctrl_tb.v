module router_output_ctrl_tb;
    reg clk, reset, polarity, req1, req2, ro;
    reg [63:0] di1, di2;
    wire ack1, ack2;
    wire [63:0] dout;
    wire so;
    
    wire[7:0] hop1, hop2;

    integer test_case, test_count, clk_count, fp;

    assign hop1 = di1[55:48];
    assign hop2 = di2[55:48];

    router_output_ctrl dut(clk, reset, polarity,req1,req2,ack1,ack2, di1,di2,dout,
    so, ro);

    initial begin
        test_count = 0;
        clk = 0;
        reset = 1;
        polarity <= 0;
        test_case = 0;
        clk_count = 0;
        req1 = 0;
        req2 = 0;
        ro = 1;
        di1 = $random;
        di2 = $random;
        fp=$fopen("output_ctrl.out");
        $fmonitor(fp,"clk_count %d, polarity %d, req1 %d, req2 %d, ack1 %d, ack2 %d, ro %d, so %d, di1 %d, di2 %d. odd_full %d    odd_buf %d,     even_full  %d      even_buf %d." 
        ,clk_count,polarity,req1,req2,ack1, ack2,ro, so, di1,di2,dut.odd_full,dut.odd_buf,dut.even_full,dut.even_buf);
    end

    always @(negedge clk ) begin
        if(reset == 1 && clk_count >1)
            reset = 0;
        if(test_case ==0 &&reset == 0) begin
            di1[47:0] = 0;
            di2[47:0] = 0;
            di1[55:48] = $random % 3;
            di2[55:48] = $random % 3;
            di1[63:56] = $random;
            di2[63:56] = $random;
            req1 = $random;
            req2 = $random;
            ro = $random;
        end
        if(clk_count > 30) begin
            $stop();
        end
        if(reset == 0)
            polarity = ~polarity;
        clk_count = clk_count+1;
    end

    always begin
        #2 clk = ~clk;
    end

    
endmodule