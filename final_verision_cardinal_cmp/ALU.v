//`include "./include/sim_ver/DW_sqrt.v"
module ALU (rA_data,rB_data,rD_data,WW,ALU_opr);

    parameter And                  = 6'b 000001,
              Or                   = 6'b 000010,
              XOR                  = 6'b 000011,
              Not                  = 6'b 000100,
              Move                 = 6'b 000101,
              Add                  = 6'b 000110,
              Subtract             = 6'b 000111,
              Mult_even_unsign     = 6'b 001000,
              Mult_odd_unsign      = 6'b 001001,
              Shift_left_logic     = 6'b 001010,
              Shift_right_logic    = 6'b 001011,
              Shift_right_Arith    = 6'b 001100,
              Rotate_half          = 6'b 001101,
              Division_int_unsign  = 6'b 001110,
              Modulo_int_unsign    = 6'b 001111,
              Square_even_unsign   = 6'b 010000,
              Square_odd_unsign    = 6'b 010001,
              Square_root_int      = 6'b 010010;

    parameter size_8 = 2'b 00,
              size_16 = 2'b 01,
              size_32 = 2'b 10,
              size_64 = 2'b 11;


    input wire[0:63] rA_data,rB_data;
    output reg [0:63] rD_data;

    input wire [0:1] WW;
    input wire [0:5] ALU_opr;

    wire [0:63] squrt_data_8,squrt_data_16,squrt_data_32,squrt_data_64;
    wire [0:63] shiftr_data_8,shiftr_data_16,shiftr_data_32,shiftr_data_64;
    wire [0:63] div_data_8,div_data_16,div_data_32,div_data_64;
    wire [0:63] mod_data_8,mod_data_16,mod_data_32,mod_data_64;
    wire [0:63] add_data_8,add_data_16,add_data_32,add_data_64;
    wire [0:63] sub_data_8,sub_data_16,sub_data_32,sub_data_64;
    wire [0:63] mult_even_data_16,mult_even_data_32,mult_even_data_64;
    wire [0:63] mult_odd_data_16,mult_odd_data_32,mult_odd_data_64;
    wire [0:63] square_even_data_16,square_even_data_32,square_even_data_64;
    wire [0:63] square_odd_data_16,square_odd_data_32,square_odd_data_64;

    assign squrt_data_8[0:3] = 0;
    assign squrt_data_8[8:11] = 0;
    assign squrt_data_8[16:19] = 0;
    assign squrt_data_8[24:27] = 0;
    assign squrt_data_8[32:35] = 0;
    assign squrt_data_8 [40:43] = 0;
    assign squrt_data_8 [48:51] = 0;
    assign squrt_data_8 [56:59] = 0;

    assign squrt_data_16 [0:7] = 0;
    assign squrt_data_16 [16:23] = 0;
    assign squrt_data_16 [32:39] = 0;
    assign squrt_data_16 [48:55] = 0;
    
    assign squrt_data_32[0:15] = 0;
    assign squrt_data_32[32:47] = 0;

    assign squrt_data_64[0:31] =0;

    DW_sqrt sqrt1(rA_data[0:7],squrt_data_8[4:7]);
    DW_sqrt sqrt2(rA_data[8:15],squrt_data_8[12:15]);
    DW_sqrt sqrt3(rA_data[16:23],squrt_data_8[20:23]);
    DW_sqrt sqrt4(rA_data[24:31],squrt_data_8[28:31]);
    DW_sqrt sqrt5(rA_data[32:39],squrt_data_8[36:39]);
    DW_sqrt sqrt6(rA_data[40:47],squrt_data_8[44:47]);
    DW_sqrt sqrt7(rA_data[48:55],squrt_data_8[52:55]);
    DW_sqrt sqrt8(rA_data[56:63],squrt_data_8[60:63]);

    DW_sqrt#(.width(16)) sqrt9(rA_data[0:15],squrt_data_16[8:15]);
    DW_sqrt#(.width(16)) sqrt10(rA_data[16:31],squrt_data_16[24:31]);
    DW_sqrt#(.width(16)) sqrt11(rA_data[32:47],squrt_data_16[40:47]);
    DW_sqrt#(.width(16)) sqrt12(rA_data[48:63],squrt_data_16[56:63]);

    DW_sqrt#(.width(32)) sqrt13(rA_data[0:31],squrt_data_32[16:31]);
    DW_sqrt#(.width(32)) sqrt14(rA_data[32:63],squrt_data_32[48:63]);

    DW_sqrt #(.width(64)) sqrt15(rA_data[0:63],squrt_data_64[32:63]);



    shift_arith sra1(rA_data[0:7],rB_data[5:7],shiftr_data_8[0:7]);
    shift_arith sra2(rA_data[8:15],rB_data[13:15],shiftr_data_8[8:15]);
    shift_arith sra3(rA_data[16:23],rB_data[21:23],shiftr_data_8[16:23]);
    shift_arith sra4(rA_data[24:31],rB_data[29:31],shiftr_data_8[24:31]);
    shift_arith sra5(rA_data[32:39],rB_data[37:39],shiftr_data_8[32:39]);
    shift_arith sra6(rA_data[40:47],rB_data[45:47],shiftr_data_8[40:47]);
    shift_arith sra7(rA_data[48:55],rB_data[53:55],shiftr_data_8[48:55]);
    shift_arith sra8(rA_data[56:63],rB_data[61:63],shiftr_data_8[56:63]);

    shift_arith #(16,4)sra9(rA_data[0:15],rB_data[12:15],shiftr_data_16[0:15]);
    shift_arith #(16,4)sra10(rA_data[16:31],rB_data[28:31],shiftr_data_16[16:31]);
    shift_arith #(16,4)sra11(rA_data[32:47],rB_data[44:47],shiftr_data_16[32:47]);
    shift_arith #(16,4)sra12(rA_data[48:63],rB_data[60:63],shiftr_data_16[48:63]);

    shift_arith #(32,5)sra13(rA_data[0:31],rB_data[27:31],shiftr_data_32[0:31]);
    shift_arith #(32,5)sra14(rA_data[32:63],rB_data[59:63],shiftr_data_32[32:63]);

    shift_arith #(64,6)sra15(rA_data[0:63],rB_data[58:63],shiftr_data_64[0:63]);


    DW_div #(8,8,0,0) div1(rA_data[0:7],rB_data[0:7],div_data_8[0:7],mod_data_8[0:7],);
    DW_div #(8,8,0,0) div2(rA_data[8:15],rB_data[8:15],div_data_8[8:15],mod_data_8[8:15],);
    DW_div #(8,8,0,0) div3(rA_data[16:23],rB_data[16:23],div_data_8[16:23],mod_data_8[16:23],);
    DW_div #(8,8,0,0) div4(rA_data[24:31],rB_data[24:31],div_data_8[24:31],mod_data_8[24:31],);
    DW_div #(8,8,0,0) div5(rA_data[32:39],rB_data[32:39],div_data_8[32:39],mod_data_8[32:39],);
    DW_div #(8,8,0,0) div6(rA_data[40:47],rB_data[40:47],div_data_8[40:47],mod_data_8[40:47],);
    DW_div #(8,8,0,0) div7(rA_data[48:55],rB_data[48:55],div_data_8[48:55],mod_data_8[48:55],);
    DW_div #(8,8,0,0) div8(rA_data[56:63],rB_data[56:63],div_data_8[56:63],mod_data_8[56:63],);

    DW_div #(16,16,0,0) div9(rA_data[0:15],rB_data[0:15],div_data_16[0:15],mod_data_16[0:15],);
    DW_div #(16,16,0,0) div10(rA_data[16:31],rB_data[16:31],div_data_16[16:31],mod_data_16[16:31],);
    DW_div #(16,16,0,0) div11(rA_data[32:47],rB_data[32:47],div_data_16[32:47],mod_data_16[32:47],);
    DW_div #(16,16,0,0) div12(rA_data[48:63],rB_data[48:63],div_data_16[48:63],mod_data_16[48:63],);

    DW_div #(32,32,0,0) div13(rA_data[0:31],rB_data[0:31],div_data_32[0:31],mod_data_32[0:31],);
    DW_div #(32,32,0,0) div14(rA_data[32:63],rB_data[32:63],div_data_32[32:63],mod_data_32[32:63],);

    DW_div #(64,64,0,0) div15(rA_data[0:63],rB_data[0:63],div_data_64[0:63],mod_data_64[0:63],);


    DW01_add #(8) add1 ( rA_data[0:7], rB_data[0:7],1'b0,add_data_8[0:7],);
    DW01_add #(8) add2 ( rA_data[8:15], rB_data[8:15],1'b0,add_data_8[8:15],);
    DW01_add #(8) add3 ( rA_data[16:23], rB_data[16:23],1'b0,add_data_8[16:23],);
    DW01_add #(8) add4 ( rA_data[24:31], rB_data[24:31],1'b0,add_data_8[24:31],);
    DW01_add #(8) add5 ( rA_data[32:39], rB_data[32:39],1'b0,add_data_8[32:39],);
    DW01_add #(8) add6 ( rA_data[40:47], rB_data[40:47],1'b0,add_data_8[40:47],);
    DW01_add #(8) add7 ( rA_data[48:55], rB_data[48:55],1'b0,add_data_8[48:55],);
    DW01_add #(8) add8 ( rA_data[56:63], rB_data[56:63],1'b0,add_data_8[56:63],);

    DW01_add #(16) add9 ( rA_data[0:15], rB_data[0:15],1'b0,add_data_16[0:15],);
    DW01_add #(16) add10 ( rA_data[16:31], rB_data[16:31],1'b0,add_data_16[16:31],);
    DW01_add #(16) add11 ( rA_data[32:47], rB_data[32:47],1'b0,add_data_16[32:47],);
    DW01_add #(16) add12 ( rA_data[48:63], rB_data[48:63],1'b0,add_data_16[48:63],);

    DW01_add #(32) add13 ( rA_data[0:31], rB_data[0:31],1'b0,add_data_32[0:31],);
    DW01_add #(32) add14 ( rA_data[32:63], rB_data[32:63],1'b0,add_data_32[32:63],);

    DW01_add #(64) add15 ( rA_data[0:63], rB_data[0:63],1'b0,add_data_64[0:63],);


    DW01_sub #(8) sub1 ( rA_data[0:7], rB_data[0:7],1'b0,sub_data_8[0:7],);
    DW01_sub #(8) sub2 ( rA_data[8:15], rB_data[8:15],1'b0,sub_data_8[8:15],);
    DW01_sub #(8) sub3 ( rA_data[16:23], rB_data[16:23],1'b0,sub_data_8[16:23],);
    DW01_sub #(8) sub4 ( rA_data[24:31], rB_data[24:31],1'b0,sub_data_8[24:31],);
    DW01_sub #(8) sub5 ( rA_data[32:39], rB_data[32:39],1'b0,sub_data_8[32:39],);
    DW01_sub #(8) sub6 ( rA_data[40:47], rB_data[40:47],1'b0,sub_data_8[40:47],);
    DW01_sub #(8) sub7 ( rA_data[48:55], rB_data[48:55],1'b0,sub_data_8[48:55],);
    DW01_sub #(8) sub8 ( rA_data[56:63], rB_data[56:63],1'b0,sub_data_8[56:63],);

    DW01_sub #(16) sub9 ( rA_data[0:15], rB_data[0:15],1'b0,sub_data_16[0:15],);
    DW01_sub #(16) sub10 ( rA_data[16:31], rB_data[16:31],1'b0,sub_data_16[16:31],);
    DW01_sub #(16) sub11 ( rA_data[32:47], rB_data[32:47],1'b0,sub_data_16[32:47],);
    DW01_sub #(16) sub12 ( rA_data[48:63], rB_data[48:63],1'b0,sub_data_16[48:63],);

    DW01_sub #(32) sub13 ( rA_data[0:31], rB_data[0:31],1'b0,sub_data_32[0:31],);
    DW01_sub #(32) sub14 ( rA_data[32:63], rB_data[32:63],1'b0,sub_data_32[32:63],);

    DW01_sub #(64) sub15 ( rA_data[0:63], rB_data[0:63],1'b0,sub_data_64[0:63],);

    
    DW02_mult #(8,8) mult1 ( rA_data[0:7], rB_data[0:7],1'b0,mult_even_data_16[0:15]);
    DW02_mult #(8,8) mult2 ( rA_data[8:15], rB_data[8:15],1'b0,mult_odd_data_16[0:15]);
    DW02_mult #(8,8) mult3 ( rA_data[16:23], rB_data[16:23],1'b0,mult_even_data_16[16:31]);
    DW02_mult #(8,8) mult4 ( rA_data[24:31], rB_data[24:31],1'b0,mult_odd_data_16[16:31]);
    DW02_mult #(8,8) mult5 ( rA_data[32:39], rB_data[32:39],1'b0,mult_even_data_16[32:47]);
    DW02_mult #(8,8) mult6 ( rA_data[40:47], rB_data[40:47],1'b0,mult_odd_data_16[32:47]);
    DW02_mult #(8,8) mult7 ( rA_data[48:55], rB_data[48:55],1'b0,mult_even_data_16[48:63]);
    DW02_mult #(8,8) mult8 ( rA_data[56:63], rB_data[56:63],1'b0,mult_odd_data_16[48:63]);

    DW02_mult #(16,16) mult9 ( rA_data[0:15], rB_data[0:15],1'b0,mult_even_data_32[0:31]);
    DW02_mult #(16,16) mult10 ( rA_data[16:31], rB_data[16:31],1'b0,mult_odd_data_32[0:31]);
    DW02_mult #(16,16) mult11 ( rA_data[32:47], rB_data[32:47],1'b0,mult_even_data_32[32:63]);
    DW02_mult #(16,16) mult12 ( rA_data[48:63], rB_data[48:63],1'b0,mult_odd_data_32[32:63]);

    DW02_mult #(32,32) mult13 ( rA_data[0:31], rB_data[0:31],1'b0,mult_even_data_64[0:63]);
    DW02_mult #(32,32) mult14 ( rA_data[32:63], rB_data[32:63],1'b0,mult_odd_data_64[0:63]);


    DW_square #(8) square1 ( rA_data[0:7], 1'b0,square_even_data_16[0:15]);
    DW_square #(8) square2 ( rA_data[8:15], 1'b0,square_odd_data_16[0:15]);
    DW_square #(8) square3 ( rA_data[16:23],1'b0,square_even_data_16[16:31]);
    DW_square #(8) square4 ( rA_data[24:31],1'b0,square_odd_data_16[16:31]);
    DW_square #(8) square5 ( rA_data[32:39], 1'b0,square_even_data_16[32:47]);
    DW_square #(8) square6 ( rA_data[40:47], 1'b0,square_odd_data_16[32:47]);
    DW_square #(8) square7 ( rA_data[48:55], 1'b0,square_even_data_16[48:63]);
    DW_square #(8) square8 ( rA_data[56:63], 1'b0,square_odd_data_16[48:63]);

    DW_square #(16) square9 ( rA_data[0:15], 1'b0,square_even_data_32[0:31]);
    DW_square #(16) square10 ( rA_data[16:31],1'b0,square_odd_data_32[0:31]);
    DW_square #(16) square11 ( rA_data[32:47],1'b0,square_even_data_32[32:63]);
    DW_square #(16) square12 ( rA_data[48:63],1'b0,square_odd_data_32[32:63]);

    DW_square #(32) square13 ( rA_data[0:31],1'b0,square_even_data_64[0:63]);
    DW_square #(32) square14 ( rA_data[32:63],1'b0,square_odd_data_64[0:63]);


    always @(*) begin
        rD_data = 0;
        case (ALU_opr)
            And: rD_data = rA_data & rB_data;
            Or : rD_data = rA_data | rB_data;
            XOR: rD_data = rA_data ^ rB_data;
            Not: rD_data = ~rA_data;
            Move:rD_data = rA_data;
            Add:begin
                rD_data = add_data_64;
                case (WW)
                size_8:begin
                    rD_data[0:7] = add_data_8[0:7];
                    rD_data[8:15] = add_data_8[8:15];
                    rD_data[16:23] = add_data_8[16:23];
                    rD_data[24:31] = add_data_8[24:31];
                    rD_data[32:39] = add_data_8[32:39];
                    rD_data[40:47] = add_data_8[40:47];
                    rD_data[48:55] = add_data_8[48:55];
                    rD_data[56:63] = add_data_8[56:63];
                end
                size_16:begin
                    rD_data[0:15] = add_data_16[0:15];
                    rD_data[16:31] = add_data_16[16:31];
                    rD_data[32:47] = add_data_16[32:47];
                    rD_data[48:63] = add_data_16[48:63];
                end
                size_32:begin
                    rD_data[0:31] = add_data_32[0:31];
                    rD_data[32:63] = add_data_32[32:63];
                end
                size_64: rD_data = add_data_64;

                    default: rD_data = add_data_64;
                endcase
            end
            Subtract:begin
                rD_data = sub_data_64;
                case (WW)
                size_8:begin
                    rD_data[0:7] = sub_data_8[0:7];
                    rD_data[8:15] = sub_data_8[8:15];
                    rD_data[16:23] = sub_data_8[16:23];
                    rD_data[24:31] = sub_data_8[24:31];
                    rD_data[32:39] = sub_data_8[32:39];
                    rD_data[40:47] = sub_data_8[40:47];
                    rD_data[48:55] = sub_data_8[48:55];
                    rD_data[56:63] = sub_data_8[56:63];
                end
                size_16:begin
                    rD_data[0:15] = sub_data_16[0:15];
                    rD_data[16:31] = sub_data_16[16:31];
                    rD_data[32:47] = sub_data_16[32:47];
                    rD_data[48:63] = sub_data_16[48:63];
                end
                size_32:begin
                    rD_data[0:31] = sub_data_32[0:31];
                    rD_data[32:63] = sub_data_32[32:63];
                end
                size_64: rD_data = sub_data_64;

                    default: rD_data = sub_data_64;
                endcase
            end
            Mult_even_unsign:begin
                rD_data = mult_even_data_64[0:63];
                case (WW)
                size_8:begin
                    rD_data[0:15] = mult_even_data_16[0:15];
                    rD_data[16:31] = mult_even_data_16[16:31];
                    rD_data[32:47] = mult_even_data_16[32:47];
                    rD_data[48:63] = mult_even_data_16[48:63];
                end
                size_16:begin
                    rD_data[0:31] = mult_even_data_32[0:31];
                    rD_data[32:63] = mult_even_data_32[32:63];
                end
                size_32:begin
                    rD_data = mult_even_data_64[0:63];
                end
                    default: rD_data = mult_even_data_64[0:63];
                endcase
            end
            Mult_odd_unsign:begin
                rD_data = mult_odd_data_64[0:63];
                case (WW)
                size_8:begin
                    rD_data[0:15] = mult_odd_data_16[0:15];
                    rD_data[16:31] = mult_odd_data_16[16:31];
                    rD_data[32:47] = mult_odd_data_16[32:47];
                    rD_data[48:63] = mult_odd_data_16[48:63];
                end
                size_16:begin
                    rD_data[0:31] = mult_odd_data_32[0:31];
                    rD_data[32:63] = mult_odd_data_32[32:63];
                end
                size_32:begin
                    rD_data = mult_odd_data_64[0:63];
                end
                    default: rD_data = mult_odd_data_64[0:63];
                endcase
            end
            Shift_left_logic:begin
                rD_data[0:63] = rA_data[0:63] << rB_data[58:63];
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7] << rB_data[5:7];
                    rD_data[8:15] = rA_data[8:15] << rB_data[13:15];
                    rD_data[16:23] = rA_data[16:23] << rB_data[21:23];
                    rD_data[24:31] = rA_data[24:31] << rB_data[29:31];
                    rD_data[32:39] = rA_data[32:39] << rB_data[37:39];
                    rD_data[40:47] = rA_data[40:47] << rB_data[45:47];
                    rD_data[48:55] = rA_data[48:55] << rB_data[53:55];
                    rD_data[56:63] = rA_data[56:63] << rB_data[61:63];
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15] << rB_data[12:15];
                    rD_data[16:31] = rA_data[16:31] << rB_data[28:31];
                    rD_data[32:47] = rA_data[32:47] << rB_data[44:47];
                    rD_data[48:63] = rA_data[48:63] << rB_data[60:63];
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31] << rB_data[27:31];
                    rD_data[32:63] = rA_data[32:63] << rB_data[59:63];
                end
                size_64:rD_data[0:63] = rA_data[0:63] << rB_data[58:63];
                    default: rD_data[0:63] = rA_data[0:63] << rB_data[58:63];
                endcase    
            end
            Shift_right_logic:begin
                rD_data[0:63] = rA_data[0:63] >> rB_data[58:63];
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7] >> rB_data[5:7];
                    rD_data[8:15] = rA_data[8:15] >> rB_data[13:15];
                    rD_data[16:23] = rA_data[16:23] >> rB_data[21:23];
                    rD_data[24:31] = rA_data[24:31] >> rB_data[29:31];
                    rD_data[32:39] = rA_data[32:39] >> rB_data[37:39];
                    rD_data[40:47] = rA_data[40:47] >> rB_data[45:47];
                    rD_data[48:55] = rA_data[48:55] >> rB_data[53:55];
                    rD_data[56:63] = rA_data[56:63] >> rB_data[61:63];
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15] >> rB_data[12:15];
                    rD_data[16:31] = rA_data[16:31] >> rB_data[28:31];
                    rD_data[32:47] = rA_data[32:47] >> rB_data[44:47];
                    rD_data[48:63] = rA_data[48:63] >> rB_data[60:63];
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31] >> rB_data[27:31];
                    rD_data[32:63] = rA_data[32:63] >> rB_data[59:63];
                end
                size_64:rD_data[0:63] = rA_data[0:63] >> rB_data[58:63];
                    default: rD_data[0:63] = rA_data[0:63] >> rB_data[58:63];
                endcase
            end
            Shift_right_Arith:begin
                rD_data[0:63] = shiftr_data_64[0:63];
                case (WW)
                size_8:begin
                    /*rD_data[0:7] = rA_data[0:7] >>> rB_data[5:7];
                    rD_data[8:15] = rA_data[8:15] >>> rB_data[13:15];
                    rD_data[16:23] = rA_data[16:23] >>> rB_data[21:23];
                    rD_data[24:31] = rA_data[24:31] >>> rB_data[29:31];
                    rD_data[32:39] = rA_data[32:39] >>> rB_data[37:39];
                    rD_data[40:47] = rA_data[40:47] >>> rB_data[45:47];
                    rD_data[48:55] = rA_data[48:55] >>> rB_data[53:55];
                    rD_data[56:63] = rA_data[56:63] >>> rB_data[61:63];*/
                    rD_data[0:7] = shiftr_data_8[0:7];
                    rD_data[8:15] = shiftr_data_8[8:15];
                    rD_data[16:23] = shiftr_data_8[16:23];
                    rD_data[24:31] = shiftr_data_8[24:31];
                    rD_data[32:39] = shiftr_data_8[32:39];
                    rD_data[40:47] = shiftr_data_8[40:47];
                    rD_data[48:55] = shiftr_data_8[48:55];
                    rD_data[56:63] = shiftr_data_8[56:63];
                end
                size_16:begin
                    /*rD_data[0:15] = rA_data[0:15] >>> rB_data[12:15];
                    rD_data[16:31] = rA_data[16:31] >>> rB_data[28:31];
                    rD_data[32:47] = rA_data[32:47] >>> rB_data[44:47];
                    rD_data[48:63] = rA_data[48:63] >>> rB_data[60:63];*/
                    rD_data[0:15] = shiftr_data_16[0:15];
                    rD_data[16:31] = shiftr_data_16[16:31];
                    rD_data[32:47] = shiftr_data_16[32:47];
                    rD_data[48:63] = shiftr_data_16[48:63];
                end
                size_32:begin
                    //rD_data[0:31] = rA_data[0:31] >>> rB_data[27:31];
                    //rD_data[32:63] = rA_data[32:63] >>> rB_data[59:63];

                    rD_data[0:31] = shiftr_data_32[0:31];
                    rD_data[32:63] = shiftr_data_32[32:63];
                end
                size_64:rD_data[0:63] = shiftr_data_64[0:63];//rD_data[0:63] = rA_data[0:63] >>> rB_data[58:63];
                    default: rD_data[0:63] = shiftr_data_64[0:63];
                endcase
            end

            Rotate_half:begin
                rD_data[0:63] = {rA_data[32:63] , rA_data[0:31]};
                case (WW)
                    size_8:begin
                        rD_data[0:7] = {rA_data[4:7] , rA_data[0:3]};
                        rD_data[8:15] = {rA_data[12:15] , rA_data[8:11]};
                        rD_data[16:23] = {rA_data[20:23] , rA_data[16:19]};
                        rD_data[24:31] = {rA_data[28:31] , rA_data[24:27]};
                        rD_data[32:39] = {rA_data[36:39] , rA_data[32:35]};
                        rD_data[40:47] = {rA_data[44:47] , rA_data[40:43]};
                        rD_data[48:55] = {rA_data[52:55] , rA_data[48:51]};
                        rD_data[56:63] = {rA_data[60:63] , rA_data[56:59]};
                    end
                    size_16:begin
                        rD_data[0:15] = {rA_data[8:15] , rA_data[0:7]};
                        rD_data[16:31] = {rA_data[24:31] , rA_data[16:23]};
                        rD_data[32:47] = {rA_data[40:47] , rA_data[32:39]};
                        rD_data[48:63] = {rA_data[56:63] , rA_data[48:55]};
                    end
                    size_32:begin
                        rD_data[0:31] = {rA_data[16:31] , rA_data[0:15]};
                        rD_data[32:63] = {rA_data[48:63] , rA_data[32:47]};
                    end
                    size_64:rD_data[0:63] = {rA_data[32:63] , rA_data[0:31]};
                    default: rD_data[0:63] = {rA_data[32:63] , rA_data[0:31]};
                endcase
            end

            Division_int_unsign:begin
                rD_data = div_data_64;
                case (WW)
                size_8:begin
                    /*rD_data[0:7] = rA_data[0:7]/rB_data[0:7];
                    rD_data[8:15] = rA_data[8:15]/rB_data[8:15];
                    rD_data[16:23] = rA_data[16:23]/rB_data[16:23];
                    rD_data[24:31] = rA_data[24:31]/rB_data[24:31];
                    rD_data[32:39] = rA_data[32:39]/rB_data[32:39];
                    rD_data[40:47] = rA_data[40:47]/rB_data[40:47];
                    rD_data[48:55] = rA_data[48:55]/rB_data[48:55];
                    rD_data[56:63] = rA_data[56:63]/rB_data[56:63];*/
                    rD_data[0:7] = div_data_8[0:7];
                    rD_data[8:15] = div_data_8[8:15];
                    rD_data[16:23] = div_data_8[16:23];
                    rD_data[24:31] = div_data_8[24:31];
                    rD_data[32:39] = div_data_8[32:39];
                    rD_data[40:47] = div_data_8[40:47];
                    rD_data[48:55] = div_data_8[48:55];
                    rD_data[56:63] = div_data_8[56:63];
                end
                size_16:begin
                    /*rD_data[0:15] = rA_data[0:15]/rB_data[0:15];
                    rD_data[16:31] = rA_data[16:31]/rB_data[16:31];
                    rD_data[32:47] = rA_data[32:47]/rB_data[32:47];
                    rD_data[48:63] = rA_data[48:63]/rB_data[48:63];*/
                    rD_data[0:15] = div_data_16[0:15];
                    rD_data[16:31] = div_data_16[16:31];
                    rD_data[32:47] = div_data_16[32:47];
                    rD_data[48:63] = div_data_16[48:63];
                end
                size_32:begin
                    //rD_data[0:31] = rA_data[0:31]/rB_data[0:31];
                    //rD_data[32:63] = rA_data[32:63]/rB_data[32:63];
                    rD_data[0:31] = div_data_32[0:31];
                    rD_data[32:63] = div_data_32[32:63];
                end
                size_64:  rD_data = div_data_64;//rD_data = rA_data / rB_data;

                    default: rD_data = div_data_64;
                endcase
            end
            Modulo_int_unsign:begin
                rD_data = mod_data_64;
                case (WW)
                size_8:begin
                    /*rD_data[0:7] = rA_data[0:7]%rB_data[0:7];
                    rD_data[8:15] = rA_data[8:15]%rB_data[8:15];
                    rD_data[16:23] = rA_data[16:23]%rB_data[16:23];
                    rD_data[24:31] = rA_data[24:31]%rB_data[24:31];
                    rD_data[32:39] = rA_data[32:39]%rB_data[32:39];
                    rD_data[40:47] = rA_data[40:47]%rB_data[40:47];
                    rD_data[48:55] = rA_data[48:55]%rB_data[48:55];
                    rD_data[56:63] = rA_data[56:63]%rB_data[56:63];*/
                    rD_data[0:7] = mod_data_8[0:7];
                    rD_data[8:15] = mod_data_8[8:15];
                    rD_data[16:23] = mod_data_8[16:23];
                    rD_data[24:31] = mod_data_8[24:31];
                    rD_data[32:39] = mod_data_8[32:39];
                    rD_data[40:47] = mod_data_8[40:47];
                    rD_data[48:55] = mod_data_8[48:55];
                    rD_data[56:63] = mod_data_8[56:63];
                end
                size_16:begin
                    /*rD_data[0:15] = rA_data[0:15]%rB_data[0:15];
                    rD_data[16:31] = rA_data[16:31]%rB_data[16:31];
                    rD_data[32:47] = rA_data[32:47]%rB_data[32:47];
                    rD_data[48:63] = rA_data[48:63]%rB_data[48:63];*/
                    rD_data[0:15] = mod_data_16[0:15];
                    rD_data[16:31] = mod_data_16[16:31];
                    rD_data[32:47] = mod_data_16[32:47];
                    rD_data[48:63] = mod_data_16[48:63];
                end
                size_32:begin
                   // rD_data[0:31] = rA_data[0:31]%rB_data[0:31];
                    //rD_data[32:63] = rA_data[32:63]&rB_data[32:63];
                    rD_data[0:31] = mod_data_32[0:31];
                    rD_data[32:63] = mod_data_32[32:63];
                end
                size_64:  rD_data = mod_data_64;

                    default: rD_data = mod_data_64;
                endcase
            end

            Square_even_unsign:begin
                rD_data = square_even_data_64[0:63];
                case (WW)
                size_8:begin
                    rD_data[0:15] = square_even_data_16[0:15];
                    rD_data[16:31] = square_even_data_16[16:31];
                    rD_data[32:47] = square_even_data_16[32:47];
                    rD_data[48:63] = square_even_data_16[48:63];
                end
                size_16:begin
                    rD_data[0:31] = square_even_data_32[0:31];
                    rD_data[32:63] = square_even_data_32[32:63];
                end
                size_32:begin
                    rD_data = square_even_data_64[0:63];
                end
                    default: rD_data = square_even_data_64[0:63];
                endcase
            end
            Square_odd_unsign:begin
                 rD_data = square_odd_data_64[0:63];
                case (WW)
                size_8:begin
                    rD_data[0:15] = square_odd_data_16[0:15];
                    rD_data[16:31] = square_odd_data_16[16:31];
                    rD_data[32:47] = square_odd_data_16[32:47];
                    rD_data[48:63] = square_odd_data_16[48:63];
                end
                size_16:begin
                    rD_data[0:31] = square_odd_data_32[0:31];
                    rD_data[32:63] = square_odd_data_32[32:63];
                end
                size_32:begin
                    rD_data = square_odd_data_64[0:63];
                end
                    default: rD_data = square_odd_data_64[0:63];
                endcase
            end
            Square_root_int:begin
                //DW_sqrt #(.WIDTH(64)) sqrt15(rA_data[0:63],rD_data[0:63]);//rD_data = rA_data **(0.5);
                rD_data = squrt_data_64;
                case (WW)
                size_8:begin
                    /*DW_sqrt sqrt1(rA_data[0:7],rD_data[0:7]);
                    DW_sqrt sqrt2(rA_data[8:15],rD_data[8:15]);
                    DW_sqrt sqrt3(rA_data[16:23],rD_data[16:23]);
                    DW_sqrt sqrt4(rA_data[24:31],rD_data[24:31]);
                    DW_sqrt sqrt5(rA_data[32:39],rD_data[32:39]);
                    DW_sqrt sqrt6(rA_data[40:47],rD_data[40:47]);
                    DW_sqrt sqrt7(rA_data[48:55],rD_data[48:55]);
                    DW_sqrt sqrt8(rA_data[56:63],rD_data[56:63]);*/

                    /*rD_data[0:7] = rA_data[0:7]**(0.5);
                    rD_data[8:15] = rA_data[8:15]**(0.5);
                    rD_data[16:23] = rA_data[16:23]**(0.5);
                    rD_data[24:31] = rA_data[24:31]**(0.5);
                    rD_data[32:39] = rA_data[32:39]**(0.5);
                    rD_data[40:47] = rA_data[40:47]**(0.5);
                    rD_data[48:55] = rA_data[48:55]**(0.5);
                    rD_data[56:63] = rA_data[56:63]**(0.5);*/
                    rD_data[0:7] = squrt_data_8[0:7];
                    rD_data[8:15] = squrt_data_8[8:15];
                    rD_data[16:23] = squrt_data_8[16:23];
                    rD_data[24:31] = squrt_data_8[24:31];
                    rD_data[32:39] = squrt_data_8[32:39];
                    rD_data[40:47] = squrt_data_8[40:47];
                    rD_data[48:55] = squrt_data_8[48:55];
                    rD_data[56:63] = squrt_data_8[56:63];
                end
                size_16:begin
                    /*DW_sqrt#(.WIDTH(16)) sqrt9(rA_data[0:5],rD_data[0:15]);
                    DW_sqrt#(.WIDTH(16)) sqrt10(rA_data[16:31],rD_data[16:31]);
                    DW_sqrt#(.WIDTH(16)) sqrt11(rA_data[32:47],rD_data[32:47]);
                    DW_sqrt#(.WIDTH(16)) sqrt12(rA_data[48:63],rD_data[48:63]);
                    /*rD_data[0:15] = rA_data[0:15]**(0.5);
                    rD_data[16:31] = rA_data[16:31]**(0.5);
                    rD_data[32:47] = rA_data[32:47]**(0.5);
                    rD_data[48:63] = rA_data[48:63]**(0.5);*/
                    rD_data[0:15] = squrt_data_16[0:15];
                    rD_data[16:31] = squrt_data_16[16:31];
                    rD_data[32:47] = squrt_data_16[32:47];
                    rD_data[48:63] = squrt_data_16[48:63];
                end
                size_32:begin
                    //rD_data[0:31] = rA_data[0:31]**(0.5);
                    //rD_data[32:63] = rA_data[32:63]**(0.5);
                    rD_data[0:31] = squrt_data_32[0:31];
                    rD_data[32:63] = squrt_data_32[32:63];
                end
                size_64: rD_data = squrt_data_64;

                    default: rD_data = squrt_data_64;
                endcase
            end
            default: rD_data = 0;
        endcase    
    end
endmodule