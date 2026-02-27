module dut (
    input wire clk,
    input wire rst,
    input wire [31:0] a,
    input wire [31:0] b,
    output reg [31:0] z
);

    // Internal registers
    reg [2:0] counter;
    reg [23:0] a_mantissa, b_mantissa, z_mantissa;
    reg [9:0] a_exponent, b_exponent, z_exponent;
    reg a_sign, b_sign, z_sign;
    reg [49:0] product;
    reg guard_bit, round_bit, sticky;
    reg [7:0] exponent_sum;
    reg [31:0] a_reg, b_reg;
    reg is_nan, is_infinity, is_zero;

    // Parameter definitions
    parameter BIAS = 8'd127;
    parameter INF_EXP = 8'd255;
    parameter NAN_EXP = 8'd255;
    parameter ZERO_EXP = 8'd0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers
            counter <= 3'b0;
            a_mantissa <= 24'b0;
            b_mantissa <= 24'b0;
            z_mantissa <= 24'b0;
            a_exponent <= 10'b0;
            b_exponent <= 10'b0;
            z_exponent <= 10'b0;
            a_sign <= 1'b0;
            b_sign <= 1'b0;
            z_sign <= 1'b0;
            product <= 50'b0;
            guard_bit <= 1'b0;
            round_bit <= 1'b0;
            sticky <= 1'b0;
            exponent_sum <= 8'b0;
            a_reg <= 32'b0;
            b_reg <= 32'b0;
            is_nan <= 1'b0;
            is_infinity <= 1'b0;
            is_zero <= 1'b0;
            z <= 32'b0;
        end else begin
            case (counter)
                3'd0: begin
                    // Stage 0: Input registration and special case detection
                    a_reg <= a;
                    b_reg <= b;
                    
                    // Extract components from inputs
                    a_sign <= a[31];
                    b_sign <= b[31];
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    
                    // Check for NaN or infinity
                    if ((a_exponent == NAN_EXP && a[22:0] != 0) || 
                       (b_exponent == NAN_EXP && b[22:0] != 0)) begin
                        is_nan <= 1'b1;
                    end else if (a_exponent == INF_EXP || b_exponent == INF_EXP) begin
                        is_infinity <= 1'b1;
                        // Infinity * 0 = NaN
                        if ((a_exponent == ZERO_EXP && a[22:0] == 0) || 
                            (b_exponent == ZERO_EXP && b[22:0] == 0)) begin
                            is_nan <= 1'b1;
                            is_infinity <= 1'b0;
                        end
                    end
                    
                    // Check for zero
                    if ((a_exponent == ZERO_EXP && a[22:0] == 0) || 
                       (b_exponent == ZERO_EXP && b[22:0] == 0)) begin
                        is_zero <= 1'b1;
                    end
                    
                    // Prepare mantissas (add implicit 1 for normalized numbers)
                    a_mantissa <= (a_exponent != 0) ? {1'b1, a[22:0]} : {1'b0, a[22:0]};
                    b_mantissa <= (b_exponent != 0) ? {1'b1, b[22:0]} : {1'b0, b[22:0]};
                    
                    counter <= counter + 1;
                end
                
                3'd1: begin
                    // Stage 1: Multiply mantissas
                    product <= a_mantissa * b_mantissa;
                    
                    // Calculate exponent sum (with bias adjustment)
                    exponent_sum <= a_exponent[7:0] + b_exponent[7:0] - BIAS;
                    
                    counter <= counter + 1;
                end
                
                3'd2: begin
                    // Stage 2: Normalize product and calculate rounding bits
                    if (product[47]) begin
                        // Product is in [2,4), shift right by 1
                        z_mantissa <= product[47:24];
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                        exponent_sum <= exponent_sum + 1;
                    end else begin
                        // Product is in [1,2), no shift needed
                        z_mantissa <= product[46:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end
                    
                    counter <= counter + 1;
                end
                
                3'd3: begin
                    // Stage 3: Rounding
                    // Round to nearest even (IEEE default)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Check for mantissa overflow
                        if (z_mantissa == 24'hFFFFFF) begin
                            exponent_sum <= exponent_sum + 1;
                            z_mantissa <= 24'h800000; // Shift right by 1
                        end
                    end
                    
                    counter <= counter + 1;
                end
                
                3'd4: begin
                    // Stage 4: Handle special cases and final output
                    if (is_nan) begin
                        // Return quiet NaN
                        z <= {1'b0, NAN_EXP, 22'b0, 1'b1};
                    end else if (is_infinity) begin
                        // Infinity output
                        z <= {a_sign ^ b_sign, INF_EXP, 23'b0};
                    end else if (is_zero) begin
                        // Zero output (signed)
                        z <= {a_sign ^ b_sign, 31'b0};
                    end else begin
                        // Check for exponent overflow/underflow
                        if (exponent_sum >= INF_EXP) begin
                            // Overflow - return infinity
                            z <= {a_sign ^ b_sign, INF_EXP, 23'b0};
                        end else if (exponent_sum <= 0) begin
                            // Underflow - return zero
                            z <= {a_sign ^ b_sign, 31'b0};
                        end else begin
                            // Normal result
                            z <= {a_sign ^ b_sign, exponent_sum[7:0], z_mantissa[22:0]};
                        end
                    end
                    
                    // Reset for next operation
                    counter <= 3'b0;
                    is_nan <= 1'b0;
                    is_infinity <= 1'b0;
                    is_zero <= 1'b0;
                end
                
                default: counter <= 3'b0;
            endcase
        end
    end

endmodule