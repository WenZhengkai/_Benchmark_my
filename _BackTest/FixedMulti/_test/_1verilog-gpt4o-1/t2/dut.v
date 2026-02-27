module dut (
    input wire clk,                 // Clock signal
    input wire rst,                 // Reset signal
    input wire [31:0] a,            // Input floating-point operand A
    input wire [31:0] b,            // Input floating-point operand B
    output reg [31:0] z             // Output floating-point result Z
);

    // Internal signals
    reg [2:0] counter;              // Cycle counter for operation sequencing
    reg [23:0] a_mantissa, b_mantissa, z_mantissa; // Mantissas
    reg [9:0] a_exponent, b_exponent, z_exponent;  // Exponents
    reg a_sign, b_sign, z_sign;     // Sign bits
    reg [49:0] product;             // Intermediate product of mantissas
    reg guard_bit, round_bit, sticky; // Rounding control bits

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all internal registers on reset
            counter <= 0;
            z <= 32'b0;
        end else begin
            case (counter)
                3'b000: begin
                    // Step 1: Extract components of inputs
                    a_sign <= a[31];
                    b_sign <= b[31];
                    a_exponent <= a[30:23] - 8'd127;   // Unbiased exponent
                    b_exponent <= b[30:23] - 8'd127;   // Unbiased exponent
                    a_mantissa <= {1'b1, a[22:0]};     // Implicit leading 1 in mantissa
                    b_mantissa <= {1'b1, b[22:0]};     // Implicit leading 1 in mantissa
                    counter <= 3'b001;
                end

                3'b001: begin
                    // Step 2: Handle special cases for NaN and infinity
                    if (a_exponent == 8'hFF || b_exponent == 8'hFF) begin
                        if (a[22:0] != 0 || b[22:0] != 0) begin
                            // NaN case
                            z <= {1'b1, 8'hFF, 23'b1}; // IEEE NaN
                        end else begin
                            // Infinity case
                            z <= {a_sign ^ b_sign, 8'hFF, 23'b0}; // Sign-adjusted infinity
                        end
                        counter <= 3'b000; // Reset counter
                    end else begin
                        // Normal arithmetic
                        counter <= 3'b010;
                    end
                end

                3'b010: begin
                    // Step 3: Multiply mantissas, compute sign and exponent
                    product <= a_mantissa * b_mantissa; // Multiply mantissas
                    z_sign <= a_sign ^ b_sign;          // XOR for final sign
                    z_exponent <= a_exponent + b_exponent + 8'd127; // Combine exponents
                    counter <= 3'b011;
                end

                3'b011: begin
                    // Step 4: Normalize the result
                    if (product[47]) begin
                        // Normalized case
                        z_mantissa <= product[47:24];
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                    end else begin
                        // Denormalized case (shift)
                        z_mantissa <= product[46:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                        z_exponent <= z_exponent - 1;
                    end
                    counter <= 3'b100;
                end

                3'b100: begin
                    // Step 5: Perform rounding (round to nearest, ties to even)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= z_mantissa >> 1;
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    counter <= 3'b101;
                end

                3'b101: begin
                    // Step 6: Handle overflow, underflow
                    if (z_exponent > 8'hFF) begin
                        // Overflow: Return infinity
                        z <= {z_sign, 8'hFF, 23'b0};
                    end else if (z_exponent < 0) begin
                        // Underflow: Return zero
                        z <= {z_sign, 31'b0};
                    end else begin
                        // Final result
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    counter <= 3'b000; // Reset counter after operation
                end
            endcase
        end
    end
endmodule
