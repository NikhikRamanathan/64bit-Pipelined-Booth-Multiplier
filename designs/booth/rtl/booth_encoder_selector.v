module booth_encoder_selector (
    input  wire [63:0] multiplicand_x,
    input  wire [2:0]  multiplier_group_y,
    output reg  [64:0] partial_prod_out,
    output reg         correction_carry
);

    wire [64:0] shifted_two_x = ({multiplicand_x[63], multiplicand_x} << 1);

    always @(*) begin
        partial_prod_out = 65'b0;
        correction_carry = 1'b0;
        
        case (multiplier_group_y)
            3'b000, 3'b111: begin 
                partial_prod_out = 65'b0; 
                correction_carry = 1'b0; 
            end
            3'b001, 3'b010: begin 
                partial_prod_out = {multiplicand_x[63], multiplicand_x}; 
                correction_carry = 1'b0; 
            end
            3'b011: begin 
                partial_prod_out = shifted_two_x; 
                correction_carry = 1'b0; 
            end
            3'b100: begin 
                partial_prod_out = ~shifted_two_x; 
                correction_carry = 1'b1; 
            end
            3'b101, 3'b110: begin 
                partial_prod_out = ~{multiplicand_x[63], multiplicand_x}; 
                correction_carry = 1'b1; 
            end
            default: begin
                partial_prod_out = 65'b0;
                correction_carry = 1'b0;
            end
        endcase
    end
endmodule