module dut (
    input clk,
    input rst,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] z
);

    // Internal signals
    reg [2:0] counter;
    reg [23:0] a_mantissa, b_mantissa, z_mantissa;
    reg [8:0] a_exponent, b_exponent, z_exponent;
    reg a_sign, b_sign, z_sign;
    reg [49:0] product;
    reg guard_bit, round_bit, sticky;

    // Constants
    localparam EXPONENT_BIAS = 8'd127;
    localparam SIGNIFICAND_WIDTH = 23;

    // Process logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            z <= 0;
        end else begin
            case (counter)
                0: begin // Extract input components
                    a_sign <= a[31];
                    b_sign <= b[31];
                    a_exponent <= a[30:23];
                    b_exponent <= b[30:23];

                    // Normalize mantissas
                    a_mantissa <= {1'b1, a[22:0]}; // Implicit 1 in IEEE-754
                    b_mantissa <= {1'b1, b[22:0]}; // Implicit 1 in IEEE-754

                    counter <= counter + 1;
                end

                1: begin // Handle special cases (NaN, infinity, zero)
                    if (a_exponent == 8'hFF || b_exponent == 8'hFF) begin
                        // Handle NaN and infinity
                        z_sign <= a_sign ^ b_sign;
                        z_exponent <= 8'hFF;
                        z_mantissa <= (a[22:0] | b[22:0]) ? {1'b1, a[22:0] | b[22:0]} : 23'b0;  // NaN
                        counter <= 0;
                    end else if (a_exponent == 0 || b_exponent == 0) begin
                        // Handle zero multiplication
                        z_sign <= a_sign ^ b_sign;
                        z_exponent <= 0;
                        z_mantissa <= 0;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                2: begin // Perform multiplication
                    product <= a_mantissa * b_mantissa;
                    z_sign <= a_sign ^ b_sign;

                    // Combine exponents and subtract bias
                    z_exponent <= a_exponent + b_exponent - EXPONENT_BIAS;
                    counter <= counter + 1;
                end

                3: begin // Normalize the product
                    if (product[47]) begin
                        z_mantissa <= product[47:24];
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                    end else begin
                        z_mantissa <= product[46:23];
                        z_exponent <= z_exponent - 1;
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end
                    counter <= counter + 1;
                end

                4: begin // Perform rounding (Round to nearest, ties to even)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        if (z_mantissa == 24'hFFFFFF) begin // Handle mantissa overflow
                            z_mantissa <= z_mantissa >> 1;
                            z_exponent <= z_exponent + 1;
                        end
                    end

                    // Handle overflow and underflow
                    if (z_exponent > 8'hFF) begin
                        z_exponent <= 8'hFF; // Overflow: set to infinity
                        z_mantissa <= 0;
                    end else if (z_exponent == 0) begin
                        z_exponent <= 0; // Underflow
                        z_mantissa <= 0;
                    end

                    // Assemble final result
                    z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    counter <= 0; // Reset for next operation
                end
            endcase
        end
    end
endmodule
