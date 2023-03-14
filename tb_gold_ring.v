module tb_gold_ring;
    
    parameter INPUT_BUFFER = 2'b00;
    parameter INPUT_STATUS = 2'b01;
    parameter OUTPUT_BUFFER = 2'b10;
    parameter OUTPUT_STATUS = 2'b11;

    reg clk, reset;
    reg [0:1] node0_addr,node1_addr,node2_addr,node3_addr;
    reg [0:63] node0_d_in,node1_d_in,node2_d_in,node3_d_in;
    wire [0:63] node0_d_out,node1_d_out,node2_d_out,node3_d_out;
    wire [0:63] node0_net_do,node1_net_do,node2_net_do,node3_net_do;
    wire [0:63] node0_net_di,node1_net_di,node2_net_di,node3_net_di;
    reg node0_nicEn,node1_nicEn,node2_nicEn,node3_nicEn;
    reg node0_nicWrEn,node1_nicWrEn,node2_nicWrEn,node3_nicWrEn; 
    wire node0_net_so,node1_net_so,node2_net_so,node3_net_so;
    reg node0_net_ro,node1_net_ro,node2_net_ro,node3_net_ro;
    wire node0_polarity,node1_polarity,node2_polarity,node3_polarity;
    reg node0_net_si,node1_net_si,node2_net_si,node3_net_si;
    wire node0_net_ri,node1_net_ri,node2_net_ri,node3_net_ri;

    gold_ring ring(
        clk,reset,node0_polarity,node3_polarity,node1_polarity,node2_polarity,
        node0_pesi, node0_peri, node0_pedi,
        node0_peso, node0_pero, node0_pedo,
        node1_pesi, node1_peri, node1_pedi,
        node1_peso, node1_pero, node1_pedo,
        node2_pesi, node2_peri, node2_pedi,
        node2_peso, node2_pero, node2_pedo,
        node3_pesi, node3_peri, node3_pedi,
        node3_peso, node3_pero, node3_pedo);
    NIC node0(
        clk,reset,node0_addr,node0_d_in,node0_d_out,node0_nicEn,node0_nicWrEn,
        node0_net_so,node0_net_ro,node0_net_do,node0_polarity,node0_net_si,node0_net_ri,node0_net_di);
    NIC node1(
        clk,reset,node1_addr,node1_d_in,node1_d_out,node1_nicEn,node1_nicWrEn,
        node1_net_so,node1_net_ro,node1_net_do,node1_polarity,node1_net_si,node1_net_ri,node1_net_di);
    NIC node2(
        clk,reset,node2_addr,node2_d_in,node2_d_out,node2_nicEn,node2_nicWrEn,
        node2_net_so,node2_net_ro,node2_net_do,node2_polarity,node2_net_si,node2_net_ri,node2_net_di);
    NIC node3(
        clk,reset,node3_addr,node3_d_in,node3_d_out,node3_nicEn,node3_nicWrEn,
        node3_net_so,node3_net_ro,node3_net_do,node3_polarity,node3_net_si,node3_net_ri,node3_net_di);

endmodule