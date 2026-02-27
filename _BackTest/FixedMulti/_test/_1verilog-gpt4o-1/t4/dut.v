module dut (
    input              clk,           // Clock signal
    input              rst,           // Reset signal (active high)
    input      [31:0]  a,             // First operand in IEEE 754 format
    input      [31:0]  b,             // Second operand in IEEE 754 format
    output reg [31:0]  z              // Result of the multiplication in IEEE 754 format
);

    // Internal registers and wires
    reg  [22:0] a_mantissa, b_mantissa;  // Mantissas of a and b (23 bits including implied leading 1 for normalization)
    reg  [23:0] z_mantissa;              // Mantissa of output z
    reg  [7:0]  a_exponent, b_exponent;  // Exponents of a and b (8 bits)
    reg  [7:0]  z_exponent;              // Exponent of output z
    reg         a_sign, b_sign;          // Sign bits of a and b
    reg         z_sign;                  // Sign bit of output z
    reg  [47:0] product;                 // Intermediate product (48 bits to avoid overflow)
    reg         guard_bit, round_bit, sticky; // Rounding control bits
    reg  [2:0]  counter;                 // Cycle counter for operation sequencing

    // Special constants for IEEE-754 standard
    localparam EXP_BIAS = 8'd127;        // Bias for single-precision floating point
    
    // Sequential operation (driven by clock signal)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset internal registers and outputs
            z            <= 32'b0;
            counter      <= 3'b0;
        end else begin
            case (counter)
                3'b000: begin
                    // Step 1: Extract IEEE-754 components from inputs
                    a_sign     <= a[31];
                    b_sign     <= b[31];
                    a_exponent <= a[30:23];
                    b_exponent <= b[30:23];
                    // Include implied leading 1 for normalization
                    a_mantissa <= {1'b1, a[22:0]};
                    b_mantissa <= {1'b1, b[22:0]};
                    counter    <= 3'b001;
                end

                3'b001: begin
                    // Step 2: Detect special cases (NaN, infinity, zero)
                    if (a_exponent == 8'hFF || b_exponent == 8'hFF) begin
                        // Handle NaN and infinity cases
                        z         <= {1'b0, 8'hFF, 23'b0}; // Default infinity
                        counter   <= 3'b000;
                    end else if (a == 32'b0 || b == 32'b0) begin
                        // Handle multiplication by zero
                        z         <= 32'b0;
                        counter   <= 3'b000;
                    end else begin
                        counter   <= 3'b010; // Proceed to multiplication
                    end
                end

                3'b010: begin
                    // Step 3: Perform multiplication and combine sign bits
                    product    <= a_mantissa * b_mantissa; // 24-bit mantissa multiplication
                    z_sign     <= a_sign ^ b_sign;        // XOR for sign bits
                    z_exponent <= a_exponent + b_exponent - EXP_BIAS; // Exponent adjustment
                    counter    <= 3'b011;
                end

                3'b011: begin
                    // Step 4: Normalize the product
                    if (product[47]) begin
                        // Shift mantissa right for normalization
                        z_mantissa <= product[47:24];
                        guard_bit  <= product[23];
                        round_bit  <= product[22];
                        sticky     <= |product[21:0];
                        z_exponent <= z_exponent + 8'd1; // Increase exponent
                    end else begin
                        // Mantissa already normalized
                        z_mantissa <= product[46:23];
                        guard_bit  <= product[22];
                        round_bit  <= product[21];
                        sticky     <= |product[20:0];
                    end
                    counter <= 3'b100;
                end

                3'b100: begin
                    // Step 5: Round the result
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1'b1;
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= z_mantissa >> 1;
                            z_exponent <= z_exponent + 8'd1;
                        end
                    end
                    counter <= 3'b101;
                end

                3'b101: begin
                    // Step 6: Handle overflow and underflow
                    if (z_exponent >= 8'hFF) begin
                        // Overflow case
                        z <= {z_sign, 8'hFF, 23'b0}; // Infinity
                    end else if (z_exponent <= 8'd0) begin
                        // Underflow case
                        z <= 32'b0; // Zero
                    end else begin
                        // Normal output
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    counter <= 3'b000;
                end

                default: begin
                    counter <= 3'b000; // Default reset state
                end
            endcase
        end
    end

endmodule
