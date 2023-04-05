module gold_ring(
    clk,reset,node0_polarity,node3_polarity,node1_polarity,node2_polarity,
    node0_pesi, node0_peri, node0_pedi,
    node0_peso, node0_pero, node0_pedo,
    node1_pesi, node1_peri, node1_pedi,
    node1_peso, node1_pero, node1_pedo,
    node2_pesi, node2_peri, node2_pedi,
    node2_peso, node2_pero, node2_pedo,
    node3_pesi, node3_peri, node3_pedi,
    node3_peso, node3_pero, node3_pedo
);

    input wire clk,reset;
    input wire node0_pesi,node0_pero;
    input wire node1_pesi,node1_pero;
    input wire node2_pesi,node2_pero;
    input wire node3_pesi,node3_pero;
    input wire [63:0] node0_pedi,node1_pedi,node2_pedi,node3_pedi;
    output wire node0_peri,node0_peso;
    output wire node1_peri,node1_peso;
    output wire node2_peri,node2_peso;
    output wire node3_peri,node3_peso;
    output wire [63:0] node0_pedo,node1_pedo,node2_pedo,node3_pedo;

    reg polarity;
    output wire node0_polarity,node3_polarity,node1_polarity,node2_polarity;
    assign node0_polarity = polarity;
    assign node1_polarity = polarity;
    assign node2_polarity = polarity;
    assign node3_polarity = polarity;

    //node0 signal
    wire node0_cwsi,node0_cwri;
    wire [63:0] node0_cwdi,node0_ccwdi,node0_cwdo,node0_ccwdo;
    wire node0_ccwsi,node0_ccwri;
    wire node0_cwso,node0_cwro;
    wire node0_ccwso,node0_ccwro;
    router node0(
        clk,reset,polarity,
        node0_cwsi,node0_cwri,node0_cwdi,
        node0_ccwsi,node0_ccwri,node0_ccwdi,
        node0_pesi,node0_peri,node0_pedi,
        node0_cwso,node0_cwro,node0_cwdo,
        node0_ccwso,node0_ccwro,node0_ccwdo,
        node0_peso,node0_pero,node0_pedo);
        
    
    //node1 signal
   wire node1_cwsi,node1_cwri;
    wire [63:0] node1_cwdi,node1_ccwdi,node1_cwdo,node1_ccwdo;
    wire node1_ccwsi,node1_ccwri;
    wire node1_cwso,node1_cwro;
    wire node1_ccwso,node1_ccwro;
    router node1(
        clk,reset,polarity,
        node1_cwsi,node1_cwri,node1_cwdi,
        node1_ccwsi,node1_ccwri,node1_ccwdi,
        node1_pesi,node1_peri,node1_pedi,
        node1_cwso,node1_cwro,node1_cwdo,
        node1_ccwso,node1_ccwro,node1_ccwdo,
        node1_peso,node1_pero,node1_pedo);

    //node2 signal
    wire node2_cwsi,node2_cwri;
    wire [63:0] node2_cwdi,node2_ccwdi,node2_cwdo,node2_ccwdo;
    wire node2_ccwsi,node2_ccwri;
    wire node2_cwso,node2_cwro;
    wire node2_ccwso,node2_ccwro;
    router node2(
        clk,reset,polarity,
        node2_cwsi,node2_cwri,node2_cwdi,
        node2_ccwsi,node2_ccwri,node2_ccwdi,
        node2_pesi,node2_peri,node2_pedi,
        node2_cwso,node2_cwro,node2_cwdo,
        node2_ccwso,node2_ccwro,node2_ccwdo,
        node2_peso,node2_pero,node2_pedo);

    //node3 signal
    wire node3_cwsi,node3_cwri;
    wire [63:0] node3_cwdi,node3_ccwdi,node3_cwdo,node3_ccwdo;
    wire node3_ccwsi,node3_ccwri;
    wire node3_cwso,node3_cwro;
    wire node3_ccwso,node3_ccwro;
    router node3(
        clk,reset,polarity,
        node3_cwsi,node3_cwri,node3_cwdi,
        node3_ccwsi,node3_ccwri,node3_ccwdi,
        node3_pesi,node3_peri,node3_pedi,
        node3_cwso,node3_cwro,node3_cwdo,
        node3_ccwso,node3_ccwro,node3_ccwdo,
        node3_peso,node3_pero,node3_pedo);

    // node1 to node 0;
    assign node0_cwro = node1_cwri;
    assign node0_ccwsi = node1_ccwso;
    assign node0_ccwdi = node1_ccwdo;
    // node 3 to node 0;
    assign node0_cwsi = node3_cwso;
    assign node0_cwdi = node3_cwdo;
    assign node0_ccwro = node3_ccwri;
    
    //node0 to node1
    assign node1_cwsi = node0_cwso;
    assign node1_cwdi = node0_cwdo;
    assign node1_ccwro = node0_ccwri;
    //node2 to node1
    assign node1_cwro = node2_cwri;
    assign node1_ccwsi = node2_ccwso;
    assign node1_ccwdi = node2_ccwdo;

    //node1 to node2
    assign node2_cwsi = node1_cwso;
    assign node2_cwdi = node1_cwdo;
    assign node2_ccwro = node1_ccwri;
    //node3 to node2
    assign node2_cwro = node3_cwri;
    assign node2_ccwsi = node3_ccwso;
    assign node2_ccwdi = node3_ccwdo;

    //node2 to node3
    assign node3_cwsi = node2_cwso;
    assign node3_cwdi = node2_cwdo;
    assign node3_ccwro = node2_ccwri;
    //node0 to node3
    assign node3_cwro = node0_cwri;
    assign node3_ccwsi = node0_ccwso;
    assign node3_ccwdi = node0_ccwdo;

    always @(posedge clk) begin
        if(reset)
            polarity <= 0;
        else 
            polarity <= ~polarity;
    end
endmodule