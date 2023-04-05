module RF (
    clk,reset, wrEn, rA, rB, rD, ppp, d_in, 
    d_out1, d_out2
);
    input wire clk, reset, wrEn;
    input wire [0:4] rA, rB, rD;
    input wire [0:2] ppp;
    // rD, ppp and wrEn comes from WB
    input wire [0:63] d_in; 
    output wire [0:63] d_out1,d_out2;

    reg [0:63] register_file [31:0];
    reg [0:5] i;

    assign d_out1 = wrEn&&(rD==rA)?d_in:register_file[rA];
    assign d_out2 = wrEn&&(rD==rB)?d_in:register_file[rB];

    always @(posedge clk) begin
        if(reset) begin
            for(i = 0; i < 32; i = i + 1) begin
                register_file [i] <= 0;
            end
        end
        else if(wrEn) begin
            if(rD != 0) begin
                if(!(|ppp)) begin
                    register_file[rD] <= d_in;
                end
                else if(ppp==3'b001) begin
                    register_file[rD] [0:31] <= d_in[0:31];
                end
                else if(ppp==3'b010) begin
                    register_file[rD] [32:63] <= d_in[32:63];
                end
                else if(ppp==3'b011) begin
                    register_file[rD][0:7] <= d_in[0:7];
                    register_file[rD][16:23] <= d_in[16:23];
                    register_file[rD][32:39] <= d_in[32:39];
                    register_file[rD][48:55] <= d_in[48:55];
                    //register_file[rD] <= {d_in[0:7], register_file[rD][8:15], d_in[16:23],register_file[24:31],d_in[32:39],register_file[40:47],d_in[48:55],register_file[56:63]};
                end
                else if(ppp==3'b100) begin
                    register_file[rD][8:15] <= d_in[8:15];
                    register_file[rD][24:31] <= d_in[24:31];
                    register_file[rD][40:47] <= d_in[40:47];
                    register_file[rD][56:63] <= d_in[56:63];
                end
            end 
        end
    end

endmodule
