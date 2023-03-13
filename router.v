

module router #(
    parameter WIDTH = 64
) (
    clk, reset, polarity,
    cwsi,cwri,cwdi,
    ccwsi,ccwri,ccwdi,
    pesi,peri,pedi,
    cwso,cwro,cwdo,
    ccwso,ccwro,ccwdo,
    peso,pero,pedo
);
    input wire clk, reset, polarity, cwsi,ccwsi,pesi,cwro,ccwro,pero;
    input wire [63:0] cwdi,ccwdi,pedi;
    output reg cwri,ccwri,peri,cwso,ccwso,peso;
    output reg [63:0] cwdo,ccwdo,pedo;
    
    //cw_input_ctrl internal signal
    wire [63:0] cw_input_buffer_data;
    wire cw_input_req, cw_hop_continue;
    //cw_output_ctrl signal
    wire cw_output_req_from_cw, cw_output_req_from_pe, cw_output_ack_to_cw, cw_output_ack_to_pe;

    //ccw input signal
    wire [63:0] ccw_input_buffer_data;
    wire ccw_input_req, ccw_hop_continue;
    //ccw output signal
    wire ccw_output_req_from_ccw, ccw_output_req_from_pe, ccw_output_ack_to_ccw, ccw_output_ack_to_pe;


    //pe_input internal signal
    wire [63:0] pe_input_buffer_data;
    wire pe_input_req, pe_dir;
    //pe output signal
    wire pe_output_req_from_cw,pe_output_req_from_ccw,pe_output_ack_to_cw, pe_output_ack_to_ccw;

    assign cw_hop_continue = |(cwdi[55:48]);//if asserted, forward to cw output, else to pe
    assign ccw_hop_continue = |(ccwdi[55:48]);
    assign pe_dir = pe_input_buffer_data[62]; // 1 for ccw, 0 for cc

    assign cw_output_req_from_cw = cw_hop_continue && cw_input_req;
    assign cw_output_req_from_pe = !cw_hop_continue && cw_input_req;
    assign ccw_output_req_from_ccw = ccw_hop_continue && ccw_input_req;
    assign ccw_output_req_from_pe = !ccw_hop_continue && ccw_input_req;
    assign pe_output_req_from_cw = !pe_dir && pe_input_req;
    assign pe_output_req_from_ccw = pe_dir && pe_input_req;


    router_input_ctrl cw_input_ctrl (clk,reset,polarity,cwsi,cwri,cwdi,cw_input_buffer_data,cw_input_req,cw_output_ack_to_cw||pe_output_ack_to_cw);
    router_output_ctrl cw_output_ctrl (clk,reset,polarity,cw_output_req_from_cw,cw_output_req_from_pe,cw_output_ack_to_cw,cw_output_ack_to_pe,cw_input_buffer_data,pe_input_buffer_data,cwdo,cwso,cwro);

    router_input_ctrl ccw_input_ctrl (clk,reset,polarity,ccwsi,ccwri,ccwdi,ccw_input_buffer_data,ccw_input_req,ccw_output_ack_to_ccw||pe_output_ack_to_ccw);
    router_output_ctrl ccw_output_ctrl (clk,reset,polarity,ccw_output_req_from_ccw,ccw_output_req_from_pe,ccw_output_ack_to_ccw,ccw_output_ack_to_pe,ccw_input_buffer_data,pe_input_buffer_data,ccwdo,ccwso,ccwro);

    router_input_ctrl pe_input_ctrl (clk,reset,polarity,pesi,peri,pedi,pe_input_buffer_data,pe_input_req,cw_output_ack_to_pe||ccw_output_ack_to_pe);
    router_output_ctrl pe_output_ctrl (clk,reset,polarity,pe_output_req_from_cw,pe_output_req_from_ccw,pe_output_ack_to_cw,pe_output_ack_to_ccw,cw_input_buffer_data,ccw_input_buffer_data,pedo,peso,pero);

endmodule