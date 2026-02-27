module dut (
    input clk,                       // Clock signal for synchronization
    input rst,                       // Reset signal (active high)
    input [31:0] a,                  // First operand in IEEE-754 format
    input [31:0] b,                  // Second operand in IEEE-754 format
    output reg [31:0] z              // Result of multiplication in IEEE-754 format
);

    // Internal signals
    reg [23:0] a_mantissa, b_mantissa, z_mantissa;
    reg [7:0]  a_exponent, b_exponent, z_exponent;
    reg a_sign, b_sign, z_sign;
    reg [49:0] product;              // Intermediate product of mantissas
    reg guard_bit, round_bit, sticky;
    reg [2:0] counter;               // Operation sequencing counter

    // IEEE 754 constants
    parameter EXP_BIAS = 8'd127;     // Exponent bias for IEEE 754 single precision

    // Sequential logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all internal signals
            z              <= 32'b0;
            counter        <= 3'b0;
            a_mantissa     <= 24'b0;
            b_mantissa     <= 24'b0;
            z_mantissa     <= 24'b0;
            product        <= 50'b0;
            a_exponent     <= 8'b0;
            b_exponent     <= 8'b0;
            z_exponent     <= 8'b0;
            a_sign         <= 1'b0;
            b_sign         <= 1'b0;
            z_sign         <= 1'b0;
            guard_bit      <= 1'b0;
            round_bit      <= 1'b0;
            sticky         <= 1'b0;
        end else begin
            case (counter)
                3'd0: begin
                    // Extract components from inputs
                    a_sign     <= a[31];
                    b_sign     <= b[31];
                    a_exponent <= a[30:23];
                    b_exponent <= b[30:23];
                    a_mantissa <= {1'b1, a[22:0]}; // Implicit leading 1
                    b_mantissa <= {1'b1, b[22:0]}; // Implicit leading 1

                    z_sign     <= a_sign ^ b_sign; // XOR of signs for product
                    counter    <= 3'd1;
                end
                3'd1: begin
                    // Multiply mantissas
                    product    <= a_mantissa * b_mantissa;

                    // Add exponents and subtract bias
                    z_exponent <= a_exponent + b_exponent - EXP_BIAS;

                    counter    <= 3'd2;
                end
                3'd2: begin
                    // Normalize product
                    if (product[47]) begin
                        // If MSB of product is set, use it directly
                        z_mantissa <= product[47:24];
                        guard_bit  <= product[23];
                        round_bit  <= product[22];
                        sticky     <= |product[21:0];
                        z_exponent <= z_exponent + 1; // Adjust exponent
                    end else begin
                        // Otherwise, shift product left for normalization
                        z_mantissa <= product[46:23];
                        guard_bit  <= product[22];
                        round_bit  <= product[21];
                        sticky     <= |product[20:0];
                    end

                    counter <= 3'd3;
                end
                3'd3: begin
                    // Perform rounding
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        if (z_mantissa == 24'hffffff) begin
                            z_exponent <= z_exponent + 1;
                        end
                    end

                    // Special case handling
                    if (a_exponent == 8'hFF || b_exponent == 8'hFF) begin
                        // Handle NaN and infinite inputs
                        if ((a_exponent == 8'hFF && |a[22:0]) || 
                            (b_exponent == 8'hFF && |b[22:0])) begin
                            // NaN
                            z <= {1'b0, 8'hFF, 1'b1, 22'b0};
                        end else begin
                            // Infinity
                            z <= {z_sign, 8'hFF, 23'b0};
                        end
                    end else if (z_exponent < 8'h01) begin
                        // Handle underflow
                        z <= {z_sign, 8'b0, 23'b0}; // Zero
                    end else if (z_exponent > 8'hFE) begin
                        // Handle overflow
                        z <= {z_sign, 8'hFF, 23'b0}; // Infinity
                    end else begin
                        // Assemble final result
                        z <= {z_sign, z_exponent, z_mantissa[22:0]};
                    end

                    counter <= 3'd0; // Reset counter for next operation
                end
            endcase
        end
    end

endmodule
