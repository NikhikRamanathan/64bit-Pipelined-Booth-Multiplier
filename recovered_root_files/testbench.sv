module tb_pipelined_multiplier;
    reg clk;
    reg rst_n;
    reg in_valid;
    reg [63:0] operand_A;
    reg [63:0] operand_B;
    wire out_valid;
    wire [127:0] pipelined_product;

    // Connect our test rig to your master factory controller
    pipelined_booth_multiplier uut (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .operand_A(operand_A),
        .operand_B(operand_B),
        .out_valid(out_valid),
        .pipelined_product(pipelined_product)
    );

    // Generate a clock signal (ticks every 5 nanoseconds)
    always #5 clk = ~clk;

    initial begin
        // --- ARTIFACT 1: WAVEFORM CAPTURE SETUP ---
        $dumpfile("dump.vcd"); // Names the waveform database file
        $dumpvars(0, tb_pipelined_multiplier); // Dumps ALL signals in this testbench

        // Initialize variables
        clk = 0; rst_n = 0; in_valid = 0; operand_A = 0; operand_B = 0;
        #20;
        rst_n = 1; // Release reset
        #10;

        // Test 1: Multiply 5 x 3
        @(posedge clk);
        in_valid  = 1;
        operand_A = 64'd5;
        operand_B = 64'd3;
        
        // Test 2: Multiply 12 x 10 right after
        @(posedge clk);
        operand_A = 64'd12;
        operand_B = 64'd10;
        
        @(posedge clk);
        in_valid = 0; // Stop sending inputs

        // Wait for the answers to travel through the pipeline stages
        wait(out_valid == 1);
        #1; // Wait 1ns for the register data to settle
        $display("SUCCESS! First Product Found: %d (Expected: 15)", pipelined_product);
        
        // --- ARTIFACT 2: COMPLIANT VALIDATION FOR TEST 1 ---
        if (pipelined_product == 128'd15) begin
            $display("ASSERTION SUCCESS: assert_test1 PASSED! (Product is exactly 15)");
        end else begin
            $display("ASSERTION CRITICAL FAILURE: assert_test1 FAILED!");
        end
        
        @(posedge clk);
        #1; // Wait 1ns for second register data to settle
        $display("SUCCESS! Second Product Found: %d (Expected: 120)", pipelined_product);
        
        // --- ARTIFACT 3: COMPLIANT VALIDATION FOR TEST 2 ---
        if (pipelined_product == 128'd120) begin
            $display("ASSERTION SUCCESS: assert_test2 PASSED! (Product is exactly 120)");
        end else begin
            $display("ASSERTION CRITICAL FAILURE: assert_test2 FAILED!");
        end
        
        #20;
        $finish;
    end
endmodule