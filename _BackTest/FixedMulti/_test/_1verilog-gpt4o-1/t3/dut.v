module dut (
    input clk,                       // Clock signal
    input rst,                       // Reset signal (active high)
    input [31:0] a,                  // First IEEE 754 operand
    input [31:0] b,                  // Second IEEE 754 operand
    output reg [31:0] z              // Output IEEE 754 result
);

    // Internal signals
    reg [2:0] counter;               // Cycle counter for operation sequencing
    reg [23:0] a_mantissa, b_mantissa, z_mantissa; // Mantissas
    reg [9:0]  a_exponent, b_exponent, z_exponent; // Exponents
    reg        a_sign, b_sign, z_sign;             // Sign bits
    reg [47:0] product;            // Intermediate product of mantissas
    reg        guard_bit, round_bit, sticky; // Rounding control bits

    // Constants for IEEE 754 format
    localparam EXP_BIAS = 127; // Bias value for single-precision

    // Initialization
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            z <= 0;
        end else begin
            case (counter)
                // Step 1: Extract IEEE 754 components
                3'd0: begin
                    a_sign     <= a[31];
                    b_sign     <= b[31];
                    a_exponent <= a[30:23];
                    b_exponent <= b[30:23];
                    a_mantissa <= {1'b1, a[22:0]}; // Append implicit "1" for normalized numbers
                    b_mantissa <= {1'b1, b[22:0]}; // Append implicit "1"
                    counter    <= counter + 1'b1;
                end

                // Step 2: Check for special cases (Zero, NaN, Infinity)
                3'd1: begin
                    if ((a_exponent == 8'hFF && a[22:0] != 0) || (b_exponent == 8'hFF && b[22:0] != 0)) begin
                        // NaN case: Exponent is all 1s and mantissa is non-zero
                        z <= {1'b0, 8'hFF, 1'b1, {22{1'b0}}}; // NaN representation
                        counter <= 0;
                    end else if (a_exponent == 8'hFF || b_exponent == 8'hFF) begin
                        // Infinity case
                        z <= {a_sign ^ b_sign, 8'hFF, {23{1'b0}}}; // Infinity representation
                        counter <= 0;
                    end else if (a_exponent == 0 || b_exponent == 0) begin
                        // Zero multiplication case
                        z <= 0;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1'b1;
                    end
                end

                // Step 3: Perform multiplication
                3'd2: begin
                    product <= a_mantissa * b_mantissa; // Multiply mantissas
                    z_sign  <= a_sign ^ b_sign;        // XOR sign bits
                    z_exponent <= a_exponent + b_exponent - EXP_BIAS; // Adjust exponent bias
                    counter <= counter + 1'b1;
                end

                // Step 4: Normalize result and handle rounding
                3'd3: begin
                    // Normalize the product
                    if (product[47]) begin
                        z_mantissa <= product[47:24]; // Mantissa fits within 23 bits
                        guard_bit  <= product[23];
                        round_bit  <= product[22];
                        sticky     <= |product[21:0];
                        z_exponent <= z_exponent + 1'b1; // Adjust exponent
                    end else begin
                        z_mantissa <= product[46:23];
                        guard_bit  <= product[22];
                        round_bit  <= product[21];
                        sticky     <= |product[20:0];
                    end

                    // Rounding logic (round-to-nearest, ties to even)
                    if (round_bit && (guard_bit || sticky)) begin
                        z_mantissa <= z_mantissa + 1'b1; // Increment mantissa for rounding
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= 24'hFFFFFF >> 1; // Adjust for overflow during rounding
                            z_exponent <= z_exponent + 1'b1;
                        end
                    end

                    counter <= counter + 1'b1;
                end

                // Step 5: Assemble IEEE 754 output
                3'd4: begin
                    if (z_exponent >= 8'hFF) begin
                        // Overflow: Result is Infinity
                        z <= {z_sign, 8'hFF, {23{1'b0}}};
                    end else if (z_exponent <= 8'h00) begin
                        // Underflow: Result is Zero
                        z <= 0;
                    end else begin
                        // Normal case
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end

                    counter <= 0; // Reset counter for next operation
                end

                default: counter <= 0; // Fail-safe reset
            endcase
        end
    end
endmodule
