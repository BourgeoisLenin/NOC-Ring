module shift_arith (a,b,c);
    parameter  WIDTH = 8;
    parameter  WIDTH_for_B = 3;

    input signed [WIDTH-1:0] a;
    input signed [WIDTH_for_B-1:0] b;
    output signed [WIDTH-1:0] c;

    assign c = a >>>b;
endmodule