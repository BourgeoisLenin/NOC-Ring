module cardinal_cmp 
    (
	clk,
    reset,
	node0_inst_in,
	node0_d_in,
	node0_pc_out,
	node0_d_out,
	node0_addr_out,
	node0_memWrEn,
	node0_memEn,

	node1_inst_in,
	node1_d_in,
	node1_pc_out,
	node1_d_out,
	node1_addr_out,
	node1_memWrEn,
	node1_memEn,
	
	node2_inst_in,
	node2_d_in,
	node2_pc_out,
	node2_d_out,
	node2_addr_out,
	node2_memWrEn,
	node2_memEn,

	node3_inst_in,
	node3_d_in,
	node3_pc_out,
	node3_d_out,
	node3_addr_out,
	node3_memWrEn,
	node3_memEn);
    


    //to memorys
    input wire clk,reset;
    input wire [0:31] node0_inst_in,node1_inst_in,node2_inst_in,node3_inst_in;
    input wire [0:63] node0_d_in,node1_d_in,node2_d_in,node3_d_in;
    output wire [0:31] node0_pc_out,node1_pc_out,node2_pc_out,node3_pc_out;
    output wire [0:63] node0_d_out,node1_d_out,node2_d_out,node3_d_out;
    output wire [0:31] node0_addr_out,node1_addr_out,node2_addr_out,node3_addr_out;
    output wire node0_memWrEn,node1_memWrEn,node2_memWrEn,node3_memWrEn;
    output wire node0_memEn,node1_memEn,node2_memEn,node3_memEn;

    //processor line
    wire[0:1] node0_addr_nic,node1_addr_nic,node2_addr_nic,node3_addr_nic;
    wire[0:63] node0_din_nic,node1_din_nic,node2_din_nic,node3_din_nic;
    wire[0:63] node0_dout_nic,node1_dout_nic,node2_dout_nic,node3_dout_nic;
    //wire node0_nicEn,node1_nicEn,node2_nicEn,node3_nicEn;
    //wire node0_nicWrEn,node1_nicWrEn,node2_nicWrEn,node3_nicWrEn;


    //NIC line
    wire [0:1] node0_addr,node1_addr,node2_addr,node3_addr;
    //wire  [0:63] node0_d_in,node1_d_in,node2_d_in,node3_d_in;
    wire node0_nicEn,node0_nicWrEn,node1_nicEn,node1_nicWrEn,node2_nicEn,node2_nicWrEn,node3_nicEn,node3_nicWrEn;
    //wire [0:63] node0_d_out,node1_d_out,node2_d_out,node3_d_out;
    wire node0_net_so,node1_net_so,node2_net_so,node3_net_so;
    wire node0_net_ro,node1_net_ro,node2_net_ro,node3_net_ro,node4_net_ro;
    wire [0:63] node0_net_do,node1_net_do,node2_net_do,node3_net_do;
    wire node0_net_polarity,node1_net_polarity,node2_net_polarity,node3_net_polarity;
    wire node0_net_si,node1_net_si,node2_net_si,node3_net_si;
    wire node0_net_ri,node1_net_ri,node2_net_ri,node3_net_ri;
    wire [0:63] node0_net_di,node1_net_di,node2_net_di,node3_net_di;



    //gold ring line
    wire node0_pesi,node0_pero;
    wire node1_pesi,node1_pero;
    wire node2_pesi,node2_pero;
    wire node3_pesi,node3_pero;
    wire [63:0] node0_pedi,node1_pedi,node2_pedi,node3_pedi;
    wire node0_peri,node0_peso;
    wire node1_peri,node1_peso;
    wire node2_peri,node2_peso;
    wire node3_peri,node3_peso;
    wire [63:0] node0_pedo,node1_pedo,node2_pedo,node3_pedo;

    //connect ring to nic
    assign node0_pesi = node0_net_so;
    assign node0_pero = node0_net_ri;
    assign node0_pedi = node0_net_do;
    assign node0_net_ro = node0_peri;
    assign node0_net_si = node0_peso;
    assign node0_net_di = node0_pedo;

    assign node1_pesi = node1_net_so;
    assign node1_pero = node1_net_ri;
    assign node1_pedi = node1_net_do;
    assign node1_net_ro = node1_peri;
    assign node1_net_si = node1_peso;
    assign node1_net_di = node1_pedo;

    assign node2_pesi = node2_net_so;
    assign node2_pero = node2_net_ri;
    assign node2_pedi = node2_net_do;
    assign node2_net_ro = node2_peri;
    assign node2_net_si = node2_peso;
    assign node2_net_di = node2_pedo;

    assign node3_pesi = node3_net_so;
    assign node3_pero = node3_net_ri;
    assign node3_pedi = node3_net_do;
    assign node3_net_ro = node3_peri;
    assign node3_net_si = node3_peso;
    assign node3_net_di = node3_pedo;
    
    //connect nic to processor
    assign node0_addr = node0_addr_nic;
    //assign node0_d_in = node0_din_nic;
    //assign node0_dout_nic = node0_d_out;

    assign node1_addr = node1_addr_nic;
    //assign node1_d_in = node1_din_nic;
    //assign node1_dout_nic = node1_d_out;

    assign node2_addr = node2_addr_nic;
    //assign node2_d_in = node2_din_nic;
    //assign node2_dout_nic = node2_d_out;

    assign node3_addr = node3_addr_nic;
    //assign node3_d_in = node3_din_nic;
    //assign node3_dout_nic = node3_d_out;


    cardinal_processors cardinal_processors(
        clk,
        reset,
        node0_inst_in,
        node0_d_in,
        node0_pc_out,
        node0_d_out,
        node0_addr_out,
        node0_memWrEn,
        node0_memEn,
        node0_addr_nic,
        node0_din_nic,
        node0_dout_nic,
        node0_nicEn,
        node0_nicWrEn,

        node1_inst_in,
        node1_d_in,
        node1_pc_out,
        node1_d_out,
        node1_addr_out,
        node1_memWrEn,
        node1_memEn,
        node1_addr_nic,
        node1_din_nic,
        node1_dout_nic,
        node1_nicEn,
        node1_nicWrEn,
        
        node2_inst_in,
        node2_d_in,
        node2_pc_out,
        node2_d_out,
        node2_addr_out,
        node2_memWrEn,
        node2_memEn,
        node2_addr_nic,
        node2_din_nic,
        node2_dout_nic,
        node2_nicEn,
        node2_nicWrEn,

        node3_inst_in,
        node3_d_in,
        node3_pc_out,
        node3_d_out,
        node3_addr_out,
        node3_memWrEn,
        node3_memEn,
        node3_addr_nic,
        node3_din_nic,
        node3_dout_nic,
        node3_nicEn,
        node3_nicWrEn
    );




    four_cardinal_nic cardinal_nics (
    clk,
    reset,
    node0_addr,
    node0_din_nic,
    node0_dout_nic,
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
    node1_din_nic,
    node1_dout_nic,
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
    node2_din_nic,
    node2_dout_nic,
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
    node3_din_nic,
    node3_dout_nic,
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

gold_ring cardinal_ring(
        clk,reset,node0_net_polarity,node3_net_polarity,node1_net_polarity,node2_net_polarity,
        node0_pesi, node0_peri, node0_pedi,
        node0_peso, node0_pero, node0_pedo,
        node1_pesi, node1_peri, node1_pedi,
        node1_peso, node1_pero, node1_pedo,
        node2_pesi, node2_peri, node2_pedi,
        node2_peso, node2_pero, node2_pedo,
        node3_pesi, node3_peri, node3_pedi,
        node3_peso, node3_pero, node3_pedo);


endmodule