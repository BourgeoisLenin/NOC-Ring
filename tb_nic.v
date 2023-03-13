`timescale 1ns/1ns
module tb_NIC ;
    parameter TEST_CASE = 100;

    reg clk,reset;
    reg [0:1] addr;
    reg  [0:63] d_in;
    reg nicEn,nicWrEn;
    wire [0:63] d_out;
    wire net_so;
    reg net_ro;
    wire [0:63] net_do;
    reg net_polarity;
    reg net_si;
    wire net_ri;
    reg[0:63] net_di;
    integer clk_count,i;

    reg[0:1] addr_test[TEST_CASE-1:0];
    reg d_in_vc[TEST_CASE-1:0];
    reg [0:62]d_in_left[TEST_CASE-1:0];
    reg [0:63]d_in_test [TEST_CASE-1:0];
    reg [0:63]d_out_test [TEST_CASE-1:0];
    reg nicEn_test[TEST_CASE-1:0];
    reg nicWrEn_test[TEST_CASE-1:0];
    reg net_so_test[TEST_CASE-1:0];
    reg net_ro_test[TEST_CASE-1:0];
    reg [0:63] net_do_test[TEST_CASE-1:0];
    reg net_si_test[TEST_CASE-1:0];
    reg net_ri_test[TEST_CASE-1:0];
    reg [0:20]net_di_test[TEST_CASE-1:0];
    wire input_status_reg,output_status_reg;
    wire [0:63] input_buffer;

    reg net_si_reg;
    integer read_test=0;
    integer write_test = 0;
    integer write_test_adrrandom = 1;
    integer read_test_adrrandom =0;
    integer fp1,fp2,fp3,fp4;

   NIC U1(clk,reset,addr,d_in,d_out,nicEn,nicWrEn,net_so,net_ro,net_do,net_polarity,net_si,net_ri,net_di);     

/*processor writer to nic
    register empty, write
    register full, write
    register full, but is being read, write

processor read from nic
    read input status, output status
    input buffer.
        read empty buffer,
        read signal is low, dout =0 ?
        read full buffer,
        continusously read full buffer

corner cases 
    read output buffer
  */  
assign input_status_reg = U1.input_status_reg;
assign output_status_reg = U1.output_status_reg;
assign input_buffer = U1.input_buffer;

    initial begin
        clk = 0;
        reset = 1;
        clk_count =0;
        net_ri_test[0] = 1;
        for (i = 0;i<TEST_CASE ;i=i+1 ) begin
            addr_test[i] = $random()% 4;
            d_in_vc[i]= $random()%2;
            d_in_left[i] = $random()%40;
            //d_in_test[i] = {d_in_vc,d_in_left};
            nicEn_test[i] = $random()%2;
            nicWrEn_test[i] = $random()%2;
            net_ro_test[i] = $random()%2;
            net_di_test[i] = $random()%50;
         //   net_si_test[i] = net_ri_test[i];
    end
    addr = addr_test[0];
    d_in = {d_in_vc[0],d_in_left[0]};
    nicEn = nicEn_test[0];
    nicWrEn = nicWrEn_test[0];
    net_ro = net_ro_test[0];
    net_di = {43'b 0,net_di_test[0]};
    i = 0;
    #10
    i = 0;
    reset = 0;
    end



initial begin
    fp1 = $fopen("write_test_address_random.dump");
    $fmonitor(fp1," address = %b , d_in_vc = %b , net_polarity = %b , d_in = %d , net_do = %d , test_value = %d ",addr,d_in[0],net_polarity,d_in,net_do,write_test_adrrandom);
    fp2 = $fopen("write_test.dump");
    $fmonitor(fp2," address = %b , d_in_vc = %b , net_polarity = %b , d_in = %d , net_do = %d , test_value = %d ",addr,d_in[0],net_polarity,d_in,net_do,write_test);
    fp3 = $fopen(" read_test_address_random.dump");
    $fmonitor(fp3," address = %b , net_ri = %b , net_si = %b , input_status_reg = %b , output_status_reg = %b , d_out = %d , input_buffer = %d , net_di = %d , test_value = %d",addr,net_ri,net_si,U1.input_status_reg,U1.output_status_reg,d_out,U1.input_buffer,net_di,read_test_adrrandom);
    fp4 = $fopen("read_test.dump");
    $fmonitor(fp4," address = %b , net_ri = %b , net_si = %b , input_status_reg = %b , output_status_reg = %b , d_out = %d, input_buffer = %d , net_di = %d , test_value = %d",addr,net_ri,net_si,U1.input_status_reg,U1.output_status_reg,d_out,U1.input_buffer,net_di,read_test);
end

always  begin
        # 2 clk = ~clk;
    end

always @(posedge clk ) begin
        clk_count = clk_count+1;
        net_si <= net_ri;
        if(!reset)
            net_polarity = ~net_polarity;
        else
            net_polarity = 0;
    end

always @(negedge clk ) begin
    if(write_test_adrrandom == 1)begin
    addr = addr_test[i];
    //addr = 2'b10;
    d_in = {d_in_vc[i],d_in_left[i]};
    //nicEn = nicEn_test[i];
    nicEn = 1'b1;
    //nicWrEn = nicWrEn_test[i];
    nicWrEn = 1'b1;
    //net_ro = net_ro_test[i];
    net_ro = 1'b1;
    net_di = {43'b 0,net_di_test[i]};
    end

    if (write_test ==1 ) begin
    //addr = addr_test[i];
    addr = 2'b10;
    d_in = {d_in_vc[i],d_in_left[i]};
    //nicEn = nicEn_test[i];
    nicEn = 1'b1;
    //nicWrEn = nicWrEn_test[i];
    nicWrEn = 1'b1;
    //net_ro = net_ro_test[i];
    net_ro = 1'b1;
    net_di = {43'b 0,net_di_test[i]};
    end

    if (read_test_adrrandom ==1) begin
        addr = addr_test[i];
        //addr = 2'b 00;
        d_in = {d_in_vc[i],d_in_left[i]};
        nicEn = 1'b1;
        nicWrEn = 1'b0;
        net_ro = 1'b0;
        net_di = {43'b 0,net_di_test[i]};
    end
    if((read_test ==1))begin
        //addr = addr_test[i];
        addr = 2'b 00;
        d_in = {d_in_vc[i],d_in_left[i]};
        nicEn = 1'b1;
        nicWrEn = 1'b0;
        net_ro = 1'b0;
        net_di = {43'b 0,net_di_test[i]};
    end


    if(i>(TEST_CASE+3) && read_test ==1) 
        #5 $stop();
    else if(i>(TEST_CASE+1) && read_test_adrrandom==1)begin
        i = 0;
        write_test =0;
        read_test_adrrandom =0;
        write_test_adrrandom = 0;
        read_test =1;
    end
    else if (i>(TEST_CASE+1) && write_test==1) begin
        i = 0;
        write_test =0;
        read_test_adrrandom =1;
        write_test_adrrandom = 0;
        read_test =0;
    end
    else if (i>(TEST_CASE+1) && write_test_adrrandom==1) begin
        i = 0;
        write_test =1;
        read_test_adrrandom =0;
        write_test_adrrandom = 0;
        read_test =0;
    end
     
    if(!reset)
    i=i+1;
end
endmodule