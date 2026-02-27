module dut (
    input clk,                // Clock signal
    input rst,                // Reset signal (active high)
    input [31:0] a,           // First operand (IEEE 754 format)
    input [31:0] b,           // Second operand (IEEE 754 format)
    output reg [31:0] z       // Result of multiplication (IEEE 754 format)
);

    // Internal signals
    reg [2:0] counter;        // Operation sequencing counter
    reg [23:0] a_mantissa, b_mantissa, z_mantissa; // Mantissas
    reg [9:0] a_exponent, b_exponent, z_exponent; // Exponents
    reg a_sign, b_sign, z_sign;                   // Sign bits
    reg [49:0] product;       // Intermediate mantissa product
    reg guard_bit, round_bit, sticky; // Rounding control bits
    reg overflow, underflow;  // Flag for overflow and underflow

    // Parameters for IEEE 754 fields
    parameter EXP_BIAS = 127;

    // Sequential logic for operation control
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic
            counter      <= 3'b000;
            z            <= 32'h0;
            overflow     <= 1'b0;
            underflow    <= 1'b0;
        end else begin
            case (counter)
                3'b000: begin
                    // Extract sign, exponent and mantissas from inputs a and b
                    a_sign    <= a[31];
                    b_sign    <= b[31];

                    a_exponent <= {2'b0, a[30:23]} - EXP_BIAS; // Unbias the exponent
                    b_exponent <= {2'b0, b[30:23]} - EXP_BIAS;

                    // Add an implicit leading '1' to the mantissas
                    a_mantissa <= {1'b1, a[22:0]};
                    b_mantissa <= {1'b1, b[22:0]};

                    // Handle special cases (zero, infinity, NaN)
                    if (a[30:23] == 8'h00 || b[30:23] == 8'h00) begin
                        z <= 32'h0; // Zero result
                        counter <= 3'b111; // Finish operation
                    end else if (a[30:23] == 8'hFF || b[30:23] == 8'hFF) begin
                        z <= {a_sign ^ b_sign, 8'hFF, 23'b0}; // Infinity or NaN
                        counter <= 3'b111; // Finish operation
                    end else begin
                        counter <= 3'b001; // Proceed to next stage
                    end
                end

                3'b001: begin
                    // Perform multiplication of mantissas (24-bit x 24-bit = 48-bit)
                    product <= a_mantissa * b_mantissa;

                    // Combine the signs (XOR for multiplication)
                    z_sign <= a_sign ^ b_sign;

                    // Add exponents (bias adjustment required later)
                    z_exponent <= a_exponent + b_exponent;

                    counter <= 3'b010; // Proceed to normalize mantissa
                end

                3'b010: begin
                    // Normalize product
                    if (product[47]) begin
                        // Mantissa is normalized
                        z_mantissa <= product[47:24];
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                        z_exponent <= z_exponent + 1;
                    end else begin
                        // Mantissa needs normalization
                        z_mantissa <= product[46:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end

                    counter <= 3'b011; // Proceed to rounding
                end

                3'b011: begin
                    // Rounding (round to nearest even)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;

                        // Check if overflow occurs during rounding
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_exponent <= z_exponent + 1;
                        end
                    end

                    // Check for overflow
                    if (z_exponent + EXP_BIAS > 8'hFF) begin
                        overflow <= 1'b1;
                        z <= {z_sign, 8'hFF, 23'h0}; // Set to infinity
                    end else if (z_exponent + EXP_BIAS < 8'h00) begin
                        underflow <= 1'b1;
                        z <= 32'h0; // Set to zero
                    end else begin
                        z <= {z_sign, (z_exponent + EXP_BIAS)[7:0], z_mantissa[22:0]}; // Final result
                    end

                    counter <= 3'b111; // Finish operation
                end

                3'b111: begin
                    // Idle state, ready for next operation
                    counter <= 3'b000;
                end
            endcase
        end
    end
endmodule
