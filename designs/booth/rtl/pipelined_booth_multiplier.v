module pipelined_booth_multiplier #(
    parameter WIDTH = 64
) (
    input  wire                 clk,
    input  wire                 rst_n,
    input  wire                 in_valid,
    input  wire [WIDTH-1:0]     operand_A,
    input  wire [WIDTH-1:0]     operand_B,
    output reg                  out_valid,
    output reg  [2*WIDTH-1:0]   pipelined_product
);

    reg valid_r1, valid_r2, valid_r3;
    reg [WIDTH-1:0] r1_A, r1_B;
    wire [64:0]     w_raw_pp [31:0];
    wire [31:0]     w_corr_carries;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r1_A     <= {WIDTH{1'b0}}; 
            r1_B     <= {WIDTH{1'b0}};
            valid_r1 <= 1'b0;
        end else begin
            valid_r1 <= in_valid;
            if (in_valid) begin
                r1_A <= operand_A; 
                r1_B <= operand_B;
            end
        end
    end

    genvar g;
    generate
        for (g = 0; g < 32; g = g + 1) begin : booth_gen
            booth_encoder_selector eng (
                .multiplicand_x(r1_A),
                .multiplier_group_y((g == 0) ? {r1_B[1], r1_B[0], 1'b0} : {r1_B[2*g+1], r1_B[2*g], r1_B[2*g-1]}),
                .partial_prod_out(w_raw_pp[g]),
                .correction_carry(w_corr_carries[g])
            );
        end
    endgenerate

    reg [2*WIDTH-1:0] r2_matrix [31:0];
    integer k;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_r2 <= 1'b0;
            for (k = 0; k < 32; k = k + 1) r2_matrix[k] <= {(2*WIDTH){1'b0}};
        end else begin
            valid_r2 <= valid_r1;
            for (k = 0; k < 32; k = k + 1) begin
                r2_matrix[k] <= ({ {63{w_raw_pp[k][64]}}, w_raw_pp[k] } << (2 * k)) + 
                                ({{127{1'b0}}, w_corr_carries[k]} << (2 * k));
            end
        end
    end

    wire [127:0] L1_S[9:0]; wire [127:0] L1_C_raw[9:0]; wire [127:0] L1_C[9:0];
    generate for(g=0; g<10; g=g+1) begin : layer1
        csa_3to2_vector csa (.in1(r2_matrix[3*g]), .in2(r2_matrix[3*g+1]), .in3(r2_matrix[3*g+2]), .sum_out(L1_S[g]), .carry_out(L1_C_raw[g]));
        assign L1_C[g] = L1_C_raw[g] << 1;
    end endgenerate

    wire [127:0] L2_in [21:0];
    generate for(g=0; g<10; g=g+1) begin : map_l2
        assign L2_in[g]    = L1_S[g];
        assign L2_in[g+10] = L1_C[g];
    end endgenerate
    assign L2_in[20] = r2_matrix[30]; assign L2_in[21] = r2_matrix[31];

    wire [127:0] L2_S[6:0]; wire [127:0] L2_C_raw[6:0]; wire [127:0] L2_C[6:0];
    generate for(g=0; g<7; g=g+1) begin : layer2
        csa_3to2_vector csa (.in1(L2_in[3*g]), .in2(L2_in[3*g+1]), .in3(L2_in[3*g+2]), .sum_out(L2_S[g]), .carry_out(L2_C_raw[g]));
        assign L2_C[g] = L2_C_raw[g] << 1;
    end endgenerate

    wire [127:0] L3_in [14:0];
    generate for(g=0; g<7; g=g+1) begin : map_l3
        assign L3_in[g]   = L2_S[g];
        assign L3_in[g+7] = L2_C[g];
    end endgenerate
    assign L3_in[14] = L2_in[21];

    wire [127:0] L3_S[4:0]; wire [127:0] L3_C_raw[4:0]; wire [127:0] L3_C[4:0];
    generate for(g=0; g<5; g=g+1) begin : layer3
        csa_3to2_vector csa (.in1(L3_in[3*g]), .in2(L3_in[3*g+1]), .in3(L3_in[3*g+2]), .sum_out(L3_S[g]), .carry_out(L3_C_raw[g]));
        assign L3_C[g] = L3_C_raw[g] << 1;
    end endgenerate

    wire [127:0] L4_in [9:0];
    generate for(g=0; g<5; g=g+1) begin : map_l4
        assign L4_in[g]   = L3_S[g];
        assign L4_in[g+5] = L3_C[g];
    end endgenerate

    wire [127:0] L4_S[2:0]; wire [127:0] L4_C_raw[2:0]; wire [127:0] L4_C[2:0];
    generate for(g=0; g<3; g=g+1) begin : layer4
        csa_3to2_vector csa (.in1(L4_in[3*g]), .in2(L4_in[3*g+1]), .in3(L4_in[3*g+2]), .sum_out(L4_S[g]), .carry_out(L4_C_raw[g]));
        assign L4_C[g] = L4_C_raw[g] << 1;
    end endgenerate

    wire [127:0] L5_in [6:0];
    generate for(g=0; g<3; g=g+1) begin : map_l5
        assign L5_in[g]   = L4_S[g];
        assign L5_in[g+3] = L4_C[g];
    end endgenerate
    assign L5_in[6] = L4_in[9];

    wire [127:0] L5_S[1:0]; wire [127:0] L5_C_raw[1:0]; wire [127:0] L5_C[1:0];
    generate for(g=0; g<2; g=g+1) begin : layer5
        csa_3to2_vector csa (.in1(L5_in[3*g]), .in2(L5_in[3*g+1]), .in3(L5_in[3*g+2]), .sum_out(L5_S[g]), .carry_out(L5_C_raw[g]));
        assign L5_C[g] = L5_C_raw[g] << 1;
    end endgenerate

    wire [127:0] L6_in [4:0];
    assign L6_in[0] = L5_S[0]; assign L6_in[1] = L5_S[1];
    assign L6_in[2] = L5_C[0]; assign L6_in[3] = L5_C[1];
    assign L6_in[4] = L5_in[6];

    wire [127:0] L6_S; wire [127:0] L6_C_raw; wire [127:0] L6_C;
    csa_3to2_vector csa6 (.in1(L6_in[0]), .in2(L6_in[1]), .in3(L6_in[2]), .sum_out(L6_S), .carry_out(L6_C_raw));
    assign L6_C = L6_C_raw << 1;

    wire [127:0] L7_S; wire [127:0] L7_C_raw; wire [127:0] L7_C;
    csa_3to2_vector csa7 (.in1(L6_S), .in2(L6_C), .in3(L6_in[3]), .sum_out(L7_S), .carry_out(L7_C_raw));
    assign L7_C = L7_C_raw << 1;

    wire [127:0] final_S; wire [127:0] final_C_raw; wire [127:0] final_C;
    csa_3to2_vector csa8 (.in1(L7_S), .in2(L7_C), .in3(L6_in[4]), .sum_out(final_S), .carry_out(final_C_raw));
    assign final_C = final_C_raw << 1;

    reg [2*WIDTH-1:0] r3_sum;
    reg [2*WIDTH-1:0] r3_car;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin 
            r3_sum   <= {(2*WIDTH){1'b0}}; 
            r3_car   <= {(2*WIDTH){1'b0}}; 
            valid_r3 <= 1'b0;
        end else begin 
            r3_sum   <= final_S; 
            r3_car   <= final_C; 
            valid_r3 <= valid_r2;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pipelined_product <= {(2*WIDTH){1'b0}};
            out_valid         <= 1'b0;
        end else begin
            pipelined_product <= r3_sum + r3_car;
            out_valid         <= valid_r3;
        end
    end
endmodule