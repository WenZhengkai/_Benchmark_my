module dut (
    input clk,
    input rst,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] z
);

    // Internal registers
    reg [2:0] counter;
    reg [23:0] a_mantissa, b_mantissa, z_mantissa;
    reg [9:0] a_exponent, b_exponent, z_exponent;
    reg a_sign, b_sign, z_sign;
    reg [49:0] product;
    reg guard_bit, round_bit, sticky;
    reg [7:0] final_exponent;
    reg [22:0] final_mantissa;
    
    // Special case flags
    reg a_is_nan, a_is_inf, a_is_zero;
    reg b_is_nan, b_is_inf, b_is_zero;
    reg z_is_nan, z_is_inf, z_is_zero;
    
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
            final_exponent <= 8'b0;
            final_mantissa <= 23'b0;
            z <= 32'b0;
            
            // Reset special case flags
            a_is_nan <= 1'b0;
            a_is_inf <= 1'b0;
            a_is_zero <= 1'b0;
            b_is_nan <= 1'b0;
            b_is_inf <= 1'b0;
            b_is_zero <= 1'b0;
            z_is_nan <= 1'b0;
            z_is_inf <= 1'b0;
            z_is_zero <= 1'b0;
        end else begin
            case (counter)
                3'b000: begin // Cycle 0: Input processing and special case detection
                    // Extract sign bits
                    a_sign <= a[31];
                    b_sign <= b[31];
                    
                    // Extract exponents
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    
                    // Extract mantissas and add implicit leading 1 for normalized numbers
                    a_mantissa <= (a[30:23] == 8'b0) ? {1'b0, a[22:0]} : {1'b1, a[22:0]};
                    b_mantissa <= (b[30:23] == 8'b0) ? {1'b0, b[22:0]} : {1'b1, b[22:0]};
                    
                    // Detect special cases
                    // NaN: exponent all 1s and mantissa non-zero
                    a_is_nan <= (a[30:23] == 8'hFF) && (a[22:0] != 23'b0);
                    b_is_nan <= (b[30:23] == 8'hFF) && (b[22:0] != 23'b0);
                    
                    // Infinity: exponent all 1s and mantissa zero
                    a_is_inf <= (a[30:23] == 8'hFF) && (a[22:0] == 23'b0);
                    b_is_inf <= (b[30:23] == 8'hFF) && (b[22:0] == 23'b0);
                    
                    // Zero: exponent all 0s and mantissa zero
                    a_is_zero <= (a[30:23] == 8'b0) && (a[22:0] == 23'b0);
                    b_is_zero <= (b[30:23] == 8'b0) && (b[22:0] == 23'b0);
                    
                    counter <= counter + 1;
                end
                
                3'b001: begin // Cycle 1: Handle special cases and prepare for multiplication
                    // Handle NaN cases (NaN takes precedence)
                    if (a_is_nan || b_is_nan) begin
                        z_is_nan <= 1'b1;
                        counter <= 3'b111; // Jump to final stage
                    end 
                    // Handle infinity cases
                    else if (a_is_inf || b_is_inf) begin
                        if (a_is_zero || b_is_zero) begin
                            // Infinity * 0 = NaN
                            z_is_nan <= 1'b1;
                        end else begin
                            z_is_inf <= 1'b1;
                            z_sign <= a_sign ^ b_sign;
                        end
                        counter <= 3'b111; // Jump to final stage
                    end
                    // Handle zero cases
                    else if (a_is_zero || b_is_zero) begin
                        z_is_zero <= 1'b1;
                        z_sign <= a_sign ^ b_sign;
                        counter <= 3'b111; // Jump to final stage
                    end
                    // Normal case: proceed with multiplication
                    else begin
                        counter <= counter + 1;
                    end
                end
                
                3'b010: begin // Cycle 2: Multiply mantissas and add exponents
                    // Multiply the mantissas (24x24 bits)
                    product <= a_mantissa * b_mantissa;
                    
                    // Add exponents and subtract bias (127)
                    z_exponent <= a_exponent + b_exponent - 10'd127;
                    
                    // Calculate result sign
                    z_sign <= a_sign ^ b_sign;
                    
                    counter <= counter + 1;
                end
                
                3'b011: begin // Cycle 3: Normalize the product
                    // Check if product needs normalization (product[47] is the MSB)
                    if (product[47]) begin
                        // Product is in [2,4), shift right by 1 and increment exponent
                        z_mantissa <= product[47:24];
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                        z_exponent <= z_exponent + 1;
                    end else begin
                        // Product is in [1,2), no shift needed
                        z_mantissa <= product[46:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b100: begin // Cycle 4: Rounding
                    // Round to nearest even (IEEE 754 default rounding mode)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Check for mantissa overflow (only possible if mantissa was all 1s)
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= 24'h800000; // 1.0 * 2^1
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b101: begin // Cycle 5: Check for overflow/underflow and prepare output
                    // Check for exponent overflow (exponent > 254 after bias adjustment)
                    if (z_exponent[9] || (z_exponent[7:0] > 8'd254)) begin
                        z_is_inf <= 1'b1;
                        z_is_nan <= 1'b0;
                        z_is_zero <= 1'b0;
                    end
                    // Check for exponent underflow (exponent < 1 after bias adjustment)
                    else if (z_exponent[7:0] < 8'd1) begin
                        z_is_zero <= 1'b1;
                        z_is_inf <= 1'b0;
                        z_is_nan <= 1'b0;
                    end
                    // Normal case
                    else begin
                        final_exponent <= z_exponent[7:0];
                        final_mantissa <= z_mantissa[22:0];
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b110: begin // Cycle 6: Final output assembly
                    if (z_is_nan) begin
                        z <= {1'b0, 8'hFF, 23'h7FFFFF}; // Quiet NaN
                    end else if (z_is_inf) begin
                        z <= {z_sign, 8'hFF, 23'b0}; // Infinity
                    end else if (z_is_zero) begin
                        z <= {z_sign, 8'b0, 23'b0}; // Zero
                    end else begin
                        z <= {z_sign, final_exponent, final_mantissa};
                    end
                    
                    counter <= 3'b0; // Reset for next operation
                end
                
                default: begin
                    counter <= 3'b0;
                end
            endcase
        end
    end

endmodule