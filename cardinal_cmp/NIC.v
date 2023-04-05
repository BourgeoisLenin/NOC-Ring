module NIC 
(clk,reset,addr,d_in,d_out,nicEn,nicWrEn,net_so,net_ro,net_do,net_polarity,net_si,net_ri,net_di);

    parameter INPUT_BUFFER = 2'b00;
    parameter INPUT_STATUS = 2'b01;
    parameter OUTPUT_BUFFER = 2'b10;
    parameter OUTPUT_STATUS = 2'b11;

    input wire clk,reset;
    input wire [0:1] addr;
    input wire  [0:63] d_in;
    input wire nicEn,nicWrEn;
    output reg [0:63] d_out;
    output wire net_so;
    input wire net_ro;
    output wire [0:63] net_do;
    input wire net_polarity;
    input wire net_si;
    output wire net_ri;
    input wire[0:63] net_di;


    reg [0:63] output_buffer; //network output channel
    reg [0:63] input_buffer; // network input 
    reg output_status_reg,input_status_reg;
    //wire d_in_to_outbuf_ctrl;
    reg [0:63] d_out_comb;


    //assign d_in_to_outbuf_ctrl = ((nicEn && nicWrEn && (~output_status_reg) && (addr == OUTPUT_BUFFER))) ? 1'b1:1'b0;
    assign net_so =(output_status_reg && net_ro && (output_buffer[0] == (~net_polarity))) ? 1'b1:1'b0;
    //assign dout_ctrl = nicEn && (~nicWrEn);
    assign net_ri = ~input_status_reg ;//|| (input_status_reg && addr==INPUT_BUFFER && nicEn && !nicWrEn);
    assign net_do = output_buffer;

    //output buffer
    always @(posedge clk ) begin
        if(reset)begin
            output_buffer <= 64'b 0;
            output_status_reg <= 1'b 0;
        end
        else begin
            // processor wants to write to output buffer
            if(nicEn && nicWrEn && (addr==OUTPUT_BUFFER)) begin
                if(!output_status_reg) begin
                    output_buffer <= d_in;
                    output_status_reg <= 1'b1;
                end 
                /*else if(net_so) begin
                    output_buffer <= d_in;
                    output_status_reg <= 1'b1;
                end*/    
            end
            /*
            if (d_in_to_outbuf_ctrl) begin
                output_buffer <= d_in;
                output_status_reg <= 1'b1;
            end
            */
            // processor does not want to write, so if net_so is high, forward to router
            else if (net_so) begin
                output_status_reg <= 1'b0;
            end
        end
    end

    //input buffer
    always @(posedge clk ) begin
        if (reset) begin
            input_status_reg <= 1'b 0;
            input_buffer <= 0;
        end
        else begin
            // net_si is asserted when buffer is empty or buffer is full but will be empty next cycle
            if (net_si) begin
                input_buffer <= net_di;
                input_status_reg <= 1'b1;
            end
            else if (input_status_reg && addr==INPUT_BUFFER && nicEn && !nicWrEn) begin
                input_status_reg <= 1'b0;
            end
        end
    end

    //d_out
    always @(posedge clk) begin
        if (reset || !nicEn) begin
            d_out <= 0;
        end
        else begin
            if(nicEn && (~nicWrEn)) begin
                case (addr)
                    INPUT_BUFFER: d_out <= input_buffer;
                    INPUT_STATUS: d_out <= {63'b0, input_status_reg};
                    OUTPUT_STATUS: d_out = {63'b0, output_status_reg};
                    default: d_out <= d_out;
                endcase
            end
        end
    end

/*
    always @(*) begin
        if (dout_ctrl) begin
            d_out_comb = 64'b 0;
            case (addr)
            2'b 00 : d_out_comb = input_buffer;
            2'b 01 : d_out_comb = {63'b0, input_status_reg};
            2'b 11 : d_out_comb = {63'b0,output_status_reg};
                default: d_out_comb = 64'b 0;
            endcase
        end
    end
*/
endmodule