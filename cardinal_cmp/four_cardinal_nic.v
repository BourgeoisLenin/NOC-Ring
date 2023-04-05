module four_cardinal_nic (
    clk,
    reset,
    node0_addr,
    node0_d_in,
    node0_d_out,
    node0_nicEn,
    node0_nicWrEn,
    node0_net_so,
    node0_net_ro,
    node0_net_do,
    node0_net_polarity,
    node0_net_si,
    node0_net_ri,
    node0_net_di,


    node1_addr,
    node1_d_in,
    node1_d_out,
    node1_nicEn,
    node1_nicWrEn,
    node1_net_so,
    node1_net_ro,
    node1_net_do,
    node1_net_polarity,
    node1_net_si,
    node1_net_ri,
    node1_net_di,


    node2_addr,
    node2_d_in,
    node2_d_out,
    node2_nicEn,
    node2_nicWrEn,
    node2_net_so,
    node2_net_ro,
    node2_net_do,
    node2_net_polarity,
    node2_net_si,
    node2_net_ri,
    node2_net_di,


    node3_addr,
    node3_d_in,
    node3_d_out,
    node3_nicEn,
    node3_nicWrEn,
    node3_net_so,
    node3_net_ro,
    node3_net_do,
    node3_net_polarity,
    node3_net_si,
    node3_net_ri,
    node3_net_di
);
    
    input wire clk,reset;
    input wire [0:1] node0_addr,node1_addr,node2_addr,node3_addr;
    input wire  [0:63] node0_d_in,node1_d_in,node2_d_in,node3_d_in;
    input wire node0_nicEn,node0_nicWrEn,node1_nicEn,node1_nicWrEn,node2_nicEn,node2_nicWrEn,node3_nicEn,node3_nicWrEn;
    output wire [0:63] node0_d_out,node1_d_out,node2_d_out,node3_d_out;
    output wire node0_net_so,node1_net_so,node2_net_so,node3_net_so;
    input wire node0_net_ro,node1_net_ro,node2_net_ro,node3_net_ro;
    output wire [0:63] node0_net_do,node1_net_do,node2_net_do,node3_net_do;
    input wire node0_net_polarity,node1_net_polarity,node2_net_polarity,node3_net_polarity;
    input wire node0_net_si,node1_net_si,node2_net_si,node3_net_si;
    output wire node0_net_ri,node1_net_ri,node2_net_ri,node3_net_ri;
    input wire[0:63] node0_net_di,node1_net_di,node2_net_di,node3_net_di;

    NIC node0_NIC(
    clk,
    reset,
    node0_addr,
    node0_d_in,
    node0_d_out,
    node0_nicEn,
    node0_nicWrEn,
    node0_net_so,
    node0_net_ro,
    node0_net_do,
    node0_net_polarity,
    node0_net_si,
    node0_net_ri,
    node0_net_di
    );

    NIC node1_NIC(
    clk,
    reset,
    node1_addr,
    node1_d_in,
    node1_d_out,
    node1_nicEn,
    node1_nicWrEn,
    node1_net_so,
    node1_net_ro,
    node1_net_do,
    node1_net_polarity,
    node1_net_si,
    node1_net_ri,
    node1_net_di
    );
    NIC node2_NIC(
    clk,
    reset,
    node2_addr,
    node2_d_in,
    node2_d_out,
    node2_nicEn,
    node2_nicWrEn,
    node2_net_so,
    node2_net_ro,
    node2_net_do,
    node2_net_polarity,
    node2_net_si,
    node2_net_ri,
    node2_net_di
    );
    NIC node3_NIC(
    clk,
    reset,
    node3_addr,
    node3_d_in,
    node3_d_out,
    node3_nicEn,
    node3_nicWrEn,
    node3_net_so,
    node3_net_ro,
    node3_net_do,
    node3_net_polarity,
    node3_net_si,
    node3_net_ri,
    node3_net_di
    );

endmodule

