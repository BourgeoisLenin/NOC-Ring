`timescale 1ns/1ns
module router_input_ctrl_tb;
    reg clk, reset, polarity,si;
    reg ack;
    wire ri,req;
    reg [63:0] di;
    wire [63:0] dout;

    integer fp, test_case, test_count, i, clk_count;

    router_input_ctrl dut (clk, reset, polarity, si,ri,di, dout, req,ack);


    initial begin
        test_count = 0;
        clk = 0;
        reset = 1;
        polarity <= 0;
        test_case = 0;
        si = 0;
        clk_count = 0;
        fp=$fopen("input_ctrl.out");
        $fmonitor(fp,"clk_count %d, polarity %d, si %d, di %d, ack %d, ri %d, req %d. odd_full %d    odd_buf %d,     even_full  %d      even_buf %d." 
        ,clk_count,polarity,si,di,ack,ri,req,dut.odd_full,dut.odd_buf,dut.even_full,dut.even_buf);
    end

    always @(posedge clk) begin
        if(reset == 1 && clk_count >2)
            reset = 0;
        if(test_case == 0) begin
            //non blocking
            ack = $random();
            di = $random();
            si = ri;
            test_count = test_count + 1;
            if(polarity) begin
                if(req != dut.odd_full) 
                    $display("TEST1 req ERROR, expected %d, got %d, at clk %d, polarity %d", dut.odd_full,req,clk_count,polarity);
                if(ri != !dut.even_full) 
                    $display("TEST1 ri ERROR, expected %d, got %d, at clk %d, polarity %d", !dut.even_full,ri,clk_count,polarity);
                //
            end
            if(!polarity) begin
                if(req != dut.even_full) 
                    $display("TEST1 req ERROR, expected %d, got %d, at clk %d, polarity %d", dut.even_full,req,clk_count,polarity);
                if(ri != !dut.odd_full) 
                    $display("TEST1 ri ERROR, expected %d, got %d, at clk %d, polarity %d", !dut.odd_full,ri,clk_count,polarity);
                //
            end
        end
        if(test_count == 20)
            $stop();
        polarity <= ~polarity;
        clk_count = clk_count+1;
    end
    


    always begin
        #2 clk = ~clk;
    end

endmodule