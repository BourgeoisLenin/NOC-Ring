module tb_gold_ring;
    
    parameter INPUT_BUFFER = 2'b00;
    parameter INPUT_STATUS = 2'b01;
    parameter OUTPUT_BUFFER = 2'b10;
    parameter OUTPUT_STATUS = 2'b11;

    reg [1:0] i,j;
    integer fp, clk_count;
    reg clk, reset;
    wire [0:1] node0_addr,node1_addr,node2_addr,node3_addr;
    wire [0:63] node0_d_in,node1_d_in,node2_d_in,node3_d_in;
    wire [0:63] node0_d_out,node1_d_out,node2_d_out,node3_d_out;
    wire [0:63] node0_net_do,node1_net_do,node2_net_do,node3_net_do;
    wire [0:63] node0_net_di,node1_net_di,node2_net_di,node3_net_di;
    wire node0_nicEn,node1_nicEn,node2_nicEn,node3_nicEn;
    wire node0_nicWrEn,node1_nicWrEn,node2_nicWrEn,node3_nicWrEn; 
    wire node0_net_so,node1_net_so,node2_net_so,node3_net_so;
    wire node0_net_ro,node1_net_ro,node2_net_ro,node3_net_ro;
    wire node0_polarity,node1_polarity,node2_polarity,node3_polarity;
    wire node0_net_si,node1_net_si,node2_net_si,node3_net_si;
    wire node0_net_ri,node1_net_ri,node2_net_ri,node3_net_ri;

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

    reg [0:63] d_in_comb;
    reg [0:63] d_in_test [3:0];
    wire [0:63] d_out_test [3:0];
    reg [0:1] addr_test [3:0];
    reg [3:0] nicEn_test;
    reg [3:0] nicWrEn_test;

    assign node0_d_in = d_in_test[0];
    assign node0_addr = addr_test[0];
    assign node0_nicEn = nicEn_test[0];
    assign node0_nicWrEn = nicWrEn_test[0];
    assign d_out_test[0] = node0_d_out;

    assign node1_d_in = d_in_test[1];
    assign node1_addr = addr_test[1];
    assign node1_nicEn = nicEn_test[1];
    assign node1_nicWrEn = nicWrEn_test[1];
    assign d_out_test[1] = node1_d_out;

    assign node2_d_in = d_in_test[2];
    assign node2_addr = addr_test[2];
    assign node2_nicEn = nicEn_test[2];
    assign node2_nicWrEn = nicWrEn_test[2];
    assign d_out_test[2] = node2_d_out;

    assign node3_d_in = d_in_test[3];
    assign node3_addr = addr_test[3];
    assign node3_nicEn = nicEn_test[3];
    assign node3_nicWrEn = nicWrEn_test[3];
    assign d_out_test[3] = node3_d_out;

    //reg [3:0] send_start;
    reg [3:0] check_complete;
    reg [3:0] send_complete;
    reg [3:0] receive_complete;

    initial begin
        clk = 0;
        reset = 1;
        clk_count = 0;
        i = 0;
        j = 0;
        check_complete = 0;
        send_complete = 0;
        receive_complete = 0;
        fp = $fopen("gold_ring.out");

        //send_start = 0;
        //node0_d_in[32:63] = i;
        //node 0 1 is even, node 2 3 is odd.
        //source field [16:32] is source of send node
        // data field is destination node
        //hop [8:15], vc [0], dir [1], data [32:63]
        // send or receive using addr, d_in, d_out,nicEn,nicWrEn
    end

    always @(posedge clk) begin
        if(reset&&clk_count==4) begin
            reset = 0;
        end
        else begin
            if(((|check_complete))) begin
                $fdisplay(fp,"checking output status reg");
                for(j = 0; j < 4; j=j+1) begin
                    if(j!=i) begin
                        addr_test[j] = OUTPUT_STATUS;
                        nicEn_test[j] = 1;
                        nicWrEn_test[j] = 0;
                        d_in_comb[32:63] = i;
                        d_in_comb[16:31] = j;
                        d_in_comb[2:7] = 0;
                        if((j-1) == 1) begin
                            //ccw, dir = 1, hop = 1
                            d_in_comb[1] = 1;
                            d_in_comb[8:15] = 1;
                        end
                        else if((j+2)==i)begin
                            //ccw dir = 0 hop = 2
                            d_in_comb[1] = 0;
                            d_in_comb[8:15] = 2;
                        end
                        else if((j+1)==i) begin
                            //cw dir 0 hop 1
                            d_in_comb[1] = 0;
                            d_in_comb[8:15] = 1;
                        end
                        if(j ==0 || j == 1)
                            d_in_comb[0] = 0;
                        else
                            d_in_comb[0] = 1;
                        d_in_test[j] = d_in_comb;
                        check_complete[j] = 1;
                    end
                    else begin
                        check_complete[i] = 1; 
                    end
                end
            end 
            /*else if (&check_complete && !(&send_complete)) begin
                $fdisplay(fp,"writing to output buffer");
                for(j = 0; j < 4; j=j+1) begin
                    if(j!=i && d_out_test[j]==0 && !send_complete[j]) begin
                        addr_test[j] = OUTPUT_BUFFER;
                        nicEn_test[j] = 1;
                        nicWrEn_test[j] = 1;
                        send_complete[j] = 1;
                    end
                    else if(j!=i && send_complete[j]) begin
                        nicEn_test[j] = 1;
                        nicWrEn_test[j] = 0;
                    end
                    else 
                        send_complete[i] = 1;
                end
            end
            else if(&send_complete && !(&receive_complete)) begin
                nicWrEn_test = 0;
            end
            */

            //i=i+1;
        end
        clk_count = clk_count + 1;
        j=0;
    end

    always @(posedge clk) begin
        if(&send_complete) begin
            addr_test[i] = INPUT_STATUS;
            nicEn_test[i] = 1;
            nicWrEn_test[i] = 0;
            if(d_out_test[i] == 1) begin
                $fdisplay(fp,"receive count = %d, d_out = %h.",receive_complete,d_out_test[i]);
                receive_complete = receive_complete + 1;
            end
        end
        if(receive_complete == 3'd3) begin
            #4 
            $fclose(fp);
            $stop();
        end
    end

    always begin
        #2 clk = ~clk;
    end

    always @(posedge clk ) begin
        if(clk_count > 1000) begin
            $display("ERROR, ABORT. Over 1000 cycles");
            $fclose(fp);
            $stop();
        end
    end

endmodule