module router_tb;
    reg clk, reset, polarity, cwsi,ccwsi,pesi,cwro,ccwro,pero;
    reg [63:0] cwdi,ccwdi,pedi;
    wire cwri,ccwri,peri,cwso,ccwso,peso;
    wire [63:0] cwdo,ccwdo,pedo;

    router dut(clk, reset, polarity,
    cwsi,cwri,cwdi,
    ccwsi,ccwri,ccwdi,
    pesi,peri,pedi,
    cwso,cwro,cwdo,
    ccwso,ccwro,ccwdo,
    peso,pero,pedo);

    assign cwsi = cwri;

    initial begin
        clk = 0;
        reset = 1;
        polarity = 0;
        cwdi = $random();
        $monitor("polarity %d, cwsi %d, cwri %d, cwro %d, cwso %,d cwdi %h, cwdo %h", polarity, cwsi, cwri, cwro, cwso, cwdi, cwdo);
    end 
endmodule