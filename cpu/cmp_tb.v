`timescale 1ns/1ns
module cmp_tb;
    reg clk,reset;
    wire [0:31] inst_in;
    wire [0:63] d_in;
    wire [0:31] pc_out;
    wire [0:63] d_out;
    wire [0:31] addr_out;
    wire memWrEn, memEn;
    integer i, clk_count,dmem0_dump_file;

    imem IM_node0 (
	.memAddr		(pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(inst_in)		// 32-bit  Instruction
	);

    dmem DM_node0 (
	.clk 		(clk),				// System Clock
	.memEn		(memEn),			// data-memory enable (to avoid spurious reads)
	.memWrEn	(memWrEn),		// data-memory Write Enable
	.memAddr	(addr_out[24:31]),	// 8-bit Memory address
	.dataIn		(d_out),			// 64-bit data to data-memory
	.dataOut	(d_in)			// 64-bit data from data-memory
	);	

    cmp dut(clk,reset,inst_in,d_in,pc_out,d_out,addr_out,memWrEn,memEn);

    initial begin
        #50000
        $finish;
    end

    initial begin
        clk = 0;
        reset = 1;
        clk_count = 0;
        $readmemh("imem_1.fill", IM_node0.MEM);
        $readmemh("dmem.fill", DM_node0.MEM);
        wait (inst_in == 32'h00000000);
        $display("The program completed in %d cycles", clk_count);
        repeat(5) @(negedge clk); 
        // Open file for output
        dmem0_dump_file = $fopen("cmp_test.dmem0.dump");
        for (i=0; i<128; i=i+1) 
        begin
            $fdisplay(dmem0_dump_file, "Memory location #%d : %h ", i, DM_node0.MEM[i]);
        end
        $fclose(dmem0_dump_file);
        $finish;
    end

    always begin
        #2
        clk = ~clk;
    end

    always@(posedge clk) begin
        if(clk_count == 3)
            reset = 0;
        clk_count = clk_count+1;
    end
endmodule