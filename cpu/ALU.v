module ALU  (rA_data,rB_data,rD_data,WW,ALU_opr);

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

    always @(*) begin
        rD_data = 0;
        case (ALU_opr)
            And: rD_data = rA_data & rB_data;
            Or : rD_data = rA_data | rB_data;
            XOR: rD_data = rA_data ^ rB_data;
            Not: rD_data = ~rA_data;
            Move:rD_data = rA_data;
            Add:begin
                rD_data = rA_data + rB_data;
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7]+rB_data[0:7];
                    rD_data[8:15] = rA_data[8:15]+rB_data[8:15];
                    rD_data[16:23] = rA_data[16:23]+rB_data[16:23];
                    rD_data[24:31] = rA_data[24:31]+rB_data[24:31];
                    rD_data[32:39] = rA_data[32:39]+rB_data[32:39];
                    rD_data[40:47] = rA_data[40:47]+rB_data[40:47];
                    rD_data[48:55] = rA_data[48:55]+rB_data[48:55];
                    rD_data[56:63] = rA_data[56:63]+rB_data[56:63];
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15]+rB_data[0:15];
                    rD_data[16:31] = rA_data[16:31]+rB_data[16:31];
                    rD_data[32:47] = rA_data[32:47]+rB_data[32:47];
                    rD_data[48:63] = rA_data[48:63]+rB_data[48:63];
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31]+rB_data[0:31];
                    rD_data[32:63] = rA_data[32:63]+rB_data[32:63];
                end
                size_64: rD_data = rA_data + rB_data;

                    default: rD_data = rA_data + rB_data;
                endcase
            end
            Subtract:begin
                rD_data = rA_data - rB_data;
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7]-rB_data[0:7];
                    rD_data[8:15] = rA_data[8:15]-rB_data[8:15];
                    rD_data[16:23] = rA_data[16:23]-rB_data[16:23];
                    rD_data[24:31] = rA_data[24:31]-rB_data[24:31];
                    rD_data[32:39] = rA_data[32:39]-rB_data[32:39];
                    rD_data[40:47] = rA_data[40:47]-rB_data[40:47];
                    rD_data[48:55] = rA_data[48:55]-rB_data[48:55];
                    rD_data[56:63] = rA_data[56:63]-rB_data[56:63];
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15]-rB_data[0:15];
                    rD_data[16:31] = rA_data[16:31]-rB_data[16:31];
                    rD_data[32:47] = rA_data[32:47]-rB_data[32:47];
                    rD_data[48:63] = rA_data[48:63]-rB_data[48:63];
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31]-rB_data[0:31];
                    rD_data[32:63] = rA_data[32:63]-rB_data[32:63];
                end
                size_64: rD_data = rA_data - rB_data;

                    default: rD_data = rA_data - rB_data;
                endcase
            end
            Mult_even_unsign:begin
                rD_data = rA_data[0:31] *rB_data[0:31];
                case (WW)
                size_8:begin
                    rD_data[0:15] = rA_data[0:7]*rB_data[0:7];
                    rD_data[16:31] = rA_data[16:23]*rB_data[16:23];
                    rD_data[32:47] = rA_data[32:39]*rB_data[32:39];
                    rD_data[48:63] = rA_data[48:55]*rB_data[48:55];
                end
                size_16:begin
                    rD_data[0:31] = rA_data[0:15]*rB_data[0:15];
                    rD_data[32:63] = rA_data[32:47]*rB_data[32:47];
                end
                size_32:begin
                    rD_data = rA_data[0:31] *rB_data[0:31];
                end
                    default: rD_data = rA_data[0:31] *rB_data[0:31];
                endcase
            end
            Mult_odd_unsign:begin
                rD_data = rA_data[32:63] *rB_data[32:63];
                case (WW)
                size_8:begin
                    rD_data[0:15] = rA_data[8:15]*rB_data[8:15];
                    rD_data[16:31] = rA_data[24:31]*rB_data[24:31];
                    rD_data[32:47] = rA_data[40:47]*rB_data[40:47];
                    rD_data[48:63] = rA_data[56:63]*rB_data[56:63];
                end
                size_16:begin
                    rD_data[0:31] = rA_data[16:31]*rB_data[16:31];
                    rD_data[32:63] = rA_data[48:63]*rB_data[48:63];
                end
                size_32:begin
                    rD_data = rA_data[32:63] *rB_data[32:63];
                end
                    default: rD_data = rA_data[32:63] *rB_data[32:63];
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
                rD_data[0:63] = rA_data[0:63] >>> rB_data[58:63];
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7] >>> rB_data[5:7];
                    rD_data[8:15] = rA_data[8:15] >>> rB_data[13:15];
                    rD_data[16:23] = rA_data[16:23] >>> rB_data[21:23];
                    rD_data[24:31] = rA_data[24:31] >>> rB_data[29:31];
                    rD_data[32:39] = rA_data[32:39] >>> rB_data[37:39];
                    rD_data[40:47] = rA_data[40:47] >>> rB_data[45:47];
                    rD_data[48:55] = rA_data[48:55] >>> rB_data[53:55];
                    rD_data[56:63] = rA_data[56:63] >>> rB_data[61:63];
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15] >>> rB_data[12:15];
                    rD_data[16:31] = rA_data[16:31] >>> rB_data[28:31];
                    rD_data[32:47] = rA_data[32:47] >>> rB_data[44:47];
                    rD_data[48:63] = rA_data[48:63] >>> rB_data[60:63];
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31] >>> rB_data[27:31];
                    rD_data[32:63] = rA_data[32:63] >>> rB_data[59:63];
                end
                size_64:rD_data[0:63] = rA_data[0:63] >>> rB_data[58:63];
                    default: rD_data[0:63] = rA_data[0:63] >>> rB_data[58:63];
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
                rD_data = rA_data / rB_data;
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7]/rB_data[0:7];
                    rD_data[8:15] = rA_data[8:15]/rB_data[8:15];
                    rD_data[16:23] = rA_data[16:23]/rB_data[16:23];
                    rD_data[24:31] = rA_data[24:31]/rB_data[24:31];
                    rD_data[32:39] = rA_data[32:39]/rB_data[32:39];
                    rD_data[40:47] = rA_data[40:47]/rB_data[40:47];
                    rD_data[48:55] = rA_data[48:55]/rB_data[48:55];
                    rD_data[56:63] = rA_data[56:63]/rB_data[56:63];
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15]/rB_data[0:15];
                    rD_data[16:31] = rA_data[16:31]/rB_data[16:31];
                    rD_data[32:47] = rA_data[32:47]/rB_data[32:47];
                    rD_data[48:63] = rA_data[48:63]/rB_data[48:63];
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31]/rB_data[0:31];
                    rD_data[32:63] = rA_data[32:63]/rB_data[32:63];
                end
                size_64: rD_data = rA_data / rB_data;

                    default: rD_data = rA_data / rB_data;
                endcase
            end
            Modulo_int_unsign:begin
                rD_data = rA_data % rB_data;
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7]%rB_data[0:7];
                    rD_data[8:15] = rA_data[8:15]%rB_data[8:15];
                    rD_data[16:23] = rA_data[16:23]%rB_data[16:23];
                    rD_data[24:31] = rA_data[24:31]%rB_data[24:31];
                    rD_data[32:39] = rA_data[32:39]%rB_data[32:39];
                    rD_data[40:47] = rA_data[40:47]%rB_data[40:47];
                    rD_data[48:55] = rA_data[48:55]%rB_data[48:55];
                    rD_data[56:63] = rA_data[56:63]%rB_data[56:63];
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15]%rB_data[0:15];
                    rD_data[16:31] = rA_data[16:31]%rB_data[16:31];
                    rD_data[32:47] = rA_data[32:47]%rB_data[32:47];
                    rD_data[48:63] = rA_data[48:63]%rB_data[48:63];
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31]%rB_data[0:31];
                    rD_data[32:63] = rA_data[32:63]&rB_data[32:63];
                end
                size_64: rD_data = rA_data % rB_data;

                    default: rD_data = rA_data % rB_data;
                endcase
            end

            Square_even_unsign:begin
                rD_data = rA_data[0:31] *rA_data[0:31];
                case (WW)
                size_8:begin
                    rD_data[0:15] = rA_data[0:7]*rA_data[0:7];
                    rD_data[16:31] = rA_data[16:23]*rA_data[16:23];
                    rD_data[32:47] = rA_data[32:39]*rA_data[32:39];
                    rD_data[48:63] = rA_data[48:55]*rA_data[48:55];
                end
                size_16:begin
                    rD_data[0:31] = rA_data[0:15]*rA_data[0:15];
                    rD_data[32:63] = rA_data[32:47]*rA_data[32:47];
                end
                size_32:begin
                    rD_data = rA_data[0:31] *rA_data[0:31];
                end
                    default: rD_data = rA_data[0:31] *rA_data[0:31];
                endcase
            end
            Square_odd_unsign:begin
                rD_data = rA_data[32:63] *rA_data[32:63];
                case (WW)
                size_8:begin
                    rD_data[0:15] = rA_data[8:15]*rA_data[8:15];
                    rD_data[16:31] = rA_data[24:31]*rA_data[24:31];
                    rD_data[32:47] = rA_data[40:47]*rA_data[40:47];
                    rD_data[48:63] = rA_data[56:63]*rA_data[56:63];
                end
                size_16:begin
                    rD_data[0:31] = rA_data[16:31]*rA_data[16:31];
                    rD_data[32:63] = rA_data[48:63]*rA_data[48:63];
                end
                size_32:begin
                    rD_data = rA_data[32:63] *rA_data[32:63];
                end
                    default: rD_data = rA_data[32:63] *rA_data[32:63];
                endcase
            end
            Square_root_int:begin
                rD_data = rA_data **(0.5);
                case (WW)
                size_8:begin
                    rD_data[0:7] = rA_data[0:7]**(0.5);
                    rD_data[8:15] = rA_data[8:15]**(0.5);
                    rD_data[16:23] = rA_data[16:23]**(0.5);
                    rD_data[24:31] = rA_data[24:31]**(0.5);
                    rD_data[32:39] = rA_data[32:39]**(0.5);
                    rD_data[40:47] = rA_data[40:47]**(0.5);
                    rD_data[48:55] = rA_data[48:55]**(0.5);
                    rD_data[56:63] = rA_data[56:63]**(0.5);
                end
                size_16:begin
                    rD_data[0:15] = rA_data[0:15]**(0.5);
                    rD_data[16:31] = rA_data[16:31]**(0.5);
                    rD_data[32:47] = rA_data[32:47]**(0.5);
                    rD_data[48:63] = rA_data[48:63]**(0.5);
                end
                size_32:begin
                    rD_data[0:31] = rA_data[0:31]**(0.5);
                    rD_data[32:63] = rA_data[32:63]**(0.5);
                end
                size_64: rD_data = rA_data **(0.5);

                    default: rD_data = rA_data **(0.5);
                endcase
            end
            default: rD_data = 0;
        endcase    
    end
endmodule