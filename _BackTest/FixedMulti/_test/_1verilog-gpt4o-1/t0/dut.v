module dut(
    input clk,                     // Clock signal
    input rst,                     // Reset signal (active high)
    input [31:0] a,                // First operand in IEEE 754 format
    input [31:0] b,                // Second operand in IEEE 754 format
    output reg [31:0] z            // Result of the multiplication in IEEE 754 format
);

    // Internal signals
    reg [2:0] counter;             // Cycle counter
    reg [23:0] a_mantissa, b_mantissa, z_mantissa;  // Mantissas
    reg [9:0] a_exponent, b_exponent, z_exponent;   // Exponents
    reg a_sign, b_sign, z_sign;    // Sign bits
    reg [49:0] product;            // Intermediate product of mantissas
    reg guard_bit, round_bit, sticky; // Rounding control bits

    // IEEE-754 Constants
    localparam EXP_BIAS = 127;

    // Reset behavior and cycle counter initialization
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            z <= 32'b0;
        end else begin
            case (counter)
                3'd0: begin
                    // Extract sign, exponent, and mantissa for operand a
                    a_sign <= a[31];
                    b_sign <= b[31];
                    a_exponent <= a[30:23];
                    b_exponent <= b[30:23];
                    
                    // Add implicit 1 to mantissa
                    a_mantissa <= {1'b1, a[22:0]};
                    b_mantissa <= {1'b1, b[22:0]};

                    counter <= 3'd1; // Move to next stage
                end

                3'd1: begin
                    // Handle special cases: zero, infinity, NaN
                    if ((a_exponent == 8'hFF && a_mantissa != 0) || 
                        (b_exponent == 8'hFF && b_mantissa != 0)) begin
                        // NaN case
                        z <= {1'b0, 8'hFF, {1'b1, 22'b0}}; // Output NaN
                        counter <= 0; // Reset
                    end else if ((a_exponent == 8'hFF) || (b_exponent == 8'hFF)) begin
                        // Infinity case
                        z <= {a_sign ^ b_sign, 8'hFF, 23'b0};
                        counter <= 0; // Reset
                    end else if ((a_exponent == 0) || (b_exponent == 0)) begin
                        // Zero case
                        z <= {a_sign ^ b_sign, 31'b0};
                        counter <= 0; // Reset
                    end else begin
                        counter <= 3'd2; // Move to multiplication stage
                    end
                end

                3'd2: begin
                    // Perform multiplication of mantissas
                    product <= a_mantissa * b_mantissa;

                    // Combine exponent values with bias subtraction
                    z_exponent <= a_exponent + b_exponent - EXP_BIAS;

                    // Compute final sign
                    z_sign <= a_sign ^ b_sign;
                    counter <= 3'd3; // Normalize mantissa
                end

                3'd3: begin
                    // Normalize mantissa if necessary
                    if (product[47] == 1) begin
                        z_mantissa <= product[46:24]; // Drop guard/round/sticky bits
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                        
                        z_exponent <= z_exponent + 1; // Adjust exponent
                    end else begin
                        z_mantissa <= product[45:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end
                    counter <= 3'd4; // Rounding stage
                end

                3'd4: begin
                    // Round mantissa based on guard, round, and sticky bits
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;

                        // Check for mantissa overflow
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= z_mantissa >> 1; // Shift back
                            z_exponent <= z_exponent + 1; // Adjust exponent up
                        end
                    end

                    // Handle overflow of exponent
                    if (z_exponent >= 8'hFF) begin
                        z <= {z_sign, 8'hFF, 23'b0}; // Output Infinity
                    end else if (z_exponent <= 0) begin
                        z <= {z_sign, 31'b0}; // Output zero (underflow)
                    end else begin
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]}; // Combine IEEE-754 format
                    end
                    
                    counter <= 0; // Reset for next operation
                end

                default: counter <= 0;
            endcase
        end
    end
endmodule
