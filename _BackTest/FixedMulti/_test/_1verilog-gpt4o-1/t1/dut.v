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
    reg [9:0] a_exponent, b_exponent, z_exponent;
    reg a_sign, b_sign, z_sign;
    reg [49:0] product;
    reg guard_bit, round_bit, sticky;

    // IEEE 754 constants
    localparam EXP_BIAS = 127;
    localparam MAX_EXP = 255;
    localparam MIN_EXP = 0;

    // Reset and initialization
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 3'd0;
            z <= 32'd0;
        end else begin
            case (counter)
                // Step 1: Extract fields from inputs
                3'd0: begin
                    a_sign <= a[31];
                    b_sign <= b[31];
                    a_exponent <= {2'b00, a[30:23]} - EXP_BIAS; // Un-bias exponent
                    b_exponent <= {2'b00, b[30:23]} - EXP_BIAS; // Un-bias exponent
                    a_mantissa <= {1'b1, a[22:0]}; // Add implicit 1 for normalized mantissa
                    b_mantissa <= {1'b1, b[22:0]}; // Add implicit 1 for normalized mantissa
                    counter <= 3'd1;
                end

                // Step 2: Check for special cases (NaN, infinity, zero)
                3'd1: begin
                    // Handle NaN and Infinity
                    if ((a[30:23] == MAX_EXP && a[22:0] != 0) || 
                        (b[30:23] == MAX_EXP && b[22:0] != 0)) begin
                        z <= {1'b1, MAX_EXP, 23'h400000}; // NaN representation
                    end else if (a[30:23] == MAX_EXP || b[30:23] == MAX_EXP) begin
                        z <= {a_sign ^ b_sign, MAX_EXP, 23'd0}; // Infinity representation
                    end else if (a[30:23] == MIN_EXP || b[30:23] == MIN_EXP) begin
                        z <= 32'd0; // Zero representation
                    end else begin
                        counter <= 3'd2;
                    end
                end

                // Step 3: Perform multiplication
                3'd2: begin
                    product <= a_mantissa * b_mantissa; // Multiply mantissas
                    z_sign <= a_sign ^ b_sign; // Compute sign of result
                    z_exponent <= a_exponent + b_exponent; // Add exponents
                    counter <= 3'd3;
                end

                // Step 4: Normalize and adjust exponent
                3'd3: begin
                    if (product[47]) begin
                        z_mantissa <= product[47:24]; // Normalized mantissa
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                        z_exponent <= z_exponent + 10'd1; // Adjust exponent
                    end else begin
                        z_mantissa <= product[46:23]; // Already normalized
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end
                    
                    counter <= 3'd4;
                end

                // Step 5: Round and finalize result
                3'd4: begin
                    // Perform IEEE 754 rounding
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Handle overflow due to rounding
                        if (z_mantissa == 24'h1000000) begin
                            z_mantissa <= z_mantissa >> 1; // Re-normalize
                            z_exponent <= z_exponent + 10'd1; // Adjust exponent
                        end
                    end

                    // Handle overflow and underflow for exponent
                    if (z_exponent >= MAX_EXP) begin
                        z <= {z_sign, MAX_EXP, 23'd0}; // Infinity
                    end else if (z_exponent <= MIN_EXP) begin
                        z <= 32'd0; // Underflow to zero
                    end else begin
                        z <= {z_sign, z_exponent[7:0] + EXP_BIAS, z_mantissa[22:0]};
                    end
                    
                    counter <= 3'd0; // Reset counter
                end
            endcase
        end
    end
endmodule
