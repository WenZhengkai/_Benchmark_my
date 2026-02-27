module dut(
    input clk,                     // Clock signal
    input rst,                     // Reset signal
    input [31:0] a,                // First operand in IEEE 754 format
    input [31:0] b,                // Second operand in IEEE 754 format
    output reg [31:0] z            // Result of multiplication
);

    // Internal signals
    reg [2:0] counter;             // Cycle counter
    reg [23:0] a_mantissa, b_mantissa, z_mantissa; // Mantissas
    reg [9:0] a_exponent, b_exponent, z_exponent;  // Exponents
    reg a_sign, b_sign, z_sign;    // Signs
    reg [49:0] product;            // Intermediate product of mantissas
    reg guard_bit, round_bit, sticky; // Rounding control bits
    reg special_case;              // Indicator for special cases (NaN/Infinity)

    // Constants
    localparam EXP_BIAS = 127;     // Exponent bias for IEEE 754 single-precision

    // Sequential process
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset logic
            z          <= 32'b0;
            counter    <= 3'b0;
            special_case <= 1'b0;
        end else begin
            case (counter)
                3'b000: begin
                    // Extract sign, exponent, and mantissa of input 'a'
                    a_sign     <= a[31];
                    a_exponent <= {2'b00, a[30:23]}; // Zero-extend exponent for addition
                    a_mantissa <= {1'b1, a[22:0]};  // Add implicit leading '1' for normalized numbers

                    // Extract sign, exponent, and mantissa of input 'b'
                    b_sign     <= b[31];
                    b_exponent <= {2'b00, b[30:23]}; // Zero-extend exponent for addition
                    b_mantissa <= {1'b1, b[22:0]};  // Add implicit leading '1' for normalized numbers

                    // Check for special cases (NaN, Infinity, Zero)
                    special_case <= (a[30:23] == 8'hFF) || (b[30:23] == 8'hFF) || // NaN/Infinity
                                    ((a[30:0] == 0) || (b[30:0] == 0));          // Zero

                    counter <= 3'b001;
                end

                3'b001: begin
                    if (!special_case) begin
                        // Compute product of mantissas
                        product       <= a_mantissa * b_mantissa;

                        // Compute new exponent (add exponents and subtract bias)
                        z_exponent    <= a_exponent + b_exponent - EXP_BIAS;

                        // Compute resulting sign bit
                        z_sign        <= a_sign ^ b_sign;
                    end

                    counter <= 3'b010;
                end

                3'b010: begin
                    if (!special_case) begin
                        // Normalize product (handle leading zeros)
                        if (product[47] == 0) begin
                            product   <= product << 1; // Normalize product
                            z_exponent <= z_exponent - 1;
                        end
                        z_mantissa   <= product[46:24]; // Extract top 23 bits
                        guard_bit    <= product[23];    // Guard bit
                        round_bit    <= product[22];    // Round bit
                        sticky       <= |product[21:0]; // Sticky bit (combine remaining bits)
                    end

                    counter <= 3'b011;
                end

                3'b011: begin
                    if (!special_case) begin
                        // Perform rounding based on guard, round, and sticky bits
                        if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                            z_mantissa <= z_mantissa + 1;
                            if (z_mantissa == 24'hFFFFFF) begin // Overflow in mantissa
                                z_mantissa <= z_mantissa >> 1;
                                z_exponent <= z_exponent + 1;
                            end
                        end

                        // Check for overflow and underflow
                        if (z_exponent >= 255) begin
                            // Overflow: result is Infinity
                            z_mantissa <= 0;
                            z_exponent <= 8'hFF;
                        end else if (z_exponent <= 0) begin
                            // Underflow: result is Zero
                            z_mantissa <= 0;
                            z_exponent <= 0;
                        end
                    end

                    counter <= 3'b100;
                end

                3'b100: begin
                    if (special_case) begin
                        // Handle special cases
                        if ((a[30:23] == 8'hFF && a[22:0] != 0) || 
                            (b[30:23] == 8'hFF && b[22:0] != 0)) begin
                            // NaN case
                            z          <= {1'b1, 8'hFF, 23'b1}; // NaN representation
                        end else if ((a[30:0] == 0) || (b[30:0] == 0)) begin
                            // Zero case
                            z          <= 32'b0; // Zero representation
                        end else begin
                            // Infinity case
                            z          <= {z_sign, 8'hFF, 23'b0}; // Infinity representation
                        end
                    end else begin
                        // Construct final IEEE 754 result
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end

                    counter <= 3'b000; // Reset counter for next operation
                end
            endcase
        end
    end

endmodule
