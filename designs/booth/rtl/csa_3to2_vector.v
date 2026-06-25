module csa_3to2_vector #(parameter WIDTH = 128) (
    input  wire [WIDTH-1:0] in1,
    input  wire [WIDTH-1:0] in2,
    input  wire [WIDTH-1:0] in3,
    output wire [WIDTH-1:0] sum_out,
    output wire [WIDTH-1:0] carry_out
);
    assign sum_out   = in1 ^ in2 ^ in3;
    assign carry_out = (in1 & in2) | (in2 & in3) | (in1 & in3);
endmodule