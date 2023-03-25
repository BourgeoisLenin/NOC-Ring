module cardinal_cmp(
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
	node3_memEn
);

    input wire clk,reset;
    input wire [0:31] node0_inst_in,node1_inst_in,node2_inst_in,node3_inst_in;
    input wire [0:63] node0_d_in,node1_d_in,node2_d_in,node3_d_in;
    output wire [0:31] node0_pc_out,node1_pc_out,node2_pc_out,node3_pc_out;
    output wire [0:63] node0_d_out,node1_d_out,node2_d_out,node3_d_out;
    output wire [0:31] node0_addr_out,node1_addr_out,node2_addr_out,node3_addr_out;
    output wire node0_memWrEn,node1_memWrEn,node2_memWrEn,node3_memWrEn;
    output wire node0_memEn,node1_memEn,node2_memEn,node3_memEn;

    cmp node0cpu(
        clk,
        reset,
        node0_inst_in,
        node0_d_in,
        node0_pc_out,
        node0_d_out,
        node0_addr_out,
        node0_memWrEn,
        node0_memEn
    );
    cmp node1cpu(
        clk,
        reset,
        node1_inst_in,
        node1_d_in,
        node1_pc_out,
        node1_d_out,
        node1_addr_out,
        node1_memWrEn,
        node1_memEn
    );
    cmp node2cpu(
        clk,
        reset,
        node2_inst_in,
        node2_d_in,
        node2_pc_out,
        node2_d_out,
        node2_addr_out,
        node2_memWrEn,
        node2_memEn
    );
    cmp node3cpu(
        clk,
        reset,
        node3_inst_in,
        node3_d_in,
        node3_pc_out,
        node3_d_out,
        node3_addr_out,
        node3_memWrEn,
        node3_memEn
    );
endmodule