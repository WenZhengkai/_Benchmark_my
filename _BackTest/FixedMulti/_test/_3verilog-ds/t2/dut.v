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
    reg a_is_nan, a_is_inf, a_is_zero;
    reg b_is_nan, b_is_inf, b_is_zero;
    reg z_is_nan, z_is_inf, z_is_zero;

    // Main operation
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
            a_is_nan <= 1'b0;
            a_is_inf <= 1'b0;
            a_is_zero <= 1'b0;
            b_is_nan <= 1'b0;
            b_is_inf <= 1'b0;
            b_is_zero <= 1'b0;
            z_is_nan <= 1'b0;
            z_is_inf <= 1'b0;
            z_is_zero <= 1'b0;
            z <= 32'b0;
        end else begin
            case (counter)
                3'b000: begin // Cycle 0: Input processing and special case detection
                    // Extract sign bits
                    a_sign <= a[31];
                    b_sign <= b[31];
                    
                    // Extract exponents
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    
                    // Extract mantissas and add implicit leading bit
                    a_mantissa <= (|a[30:23]) ? {1'b1, a[22:0]} : {1'b0, a[22:0]};
                    b_mantissa <= (|b[30:23]) ? {1'b1, b[22:0]} : {1'b0, b[22:0]};
                    
                    // Detect special cases
                    a_is_nan <= (&a[30:23]) && (|a[22:0]);  // Exponent all 1s, mantissa non-zero
                    a_is_inf <= (&a[30:23]) && (~|a[22:0]); // Exponent all 1s, mantissa zero
                    a_is_zero <= ~|a[30:0];                  // All bits zero (except sign)
                    
                    b_is_nan <= (&b[30:23]) && (|b[22:0]);
                    b_is_inf <= (&b[30:23]) && (~|b[22:0]);
                    b_is_zero <= ~|b[30:0];
                    
                    counter <= counter + 1;
                end
                
                3'b001: begin // Cycle 1: Handle special cases and prepare multiplication
                    // Handle NaN cases (NaN * anything = NaN)
                    if (a_is_nan || b_is_nan) begin
                        z_is_nan <= 1'b1;
                        counter <= 3'b100; // Jump to output stage
                    end 
                    // Handle infinity cases
                    else if ((a_is_inf && !b_is_zero) || (b_is_inf && !a_is_zero)) begin
                        z_is_inf <= 1'b1;
                        z_sign <= a_sign ^ b_sign;
                        counter <= 3'b100; // Jump to output stage
                    end
                    // Handle 0 * inf (invalid operation)
                    else if ((a_is_zero && b_is_inf) || (a_is_inf && b_is_zero)) begin
                        z_is_nan <= 1'b1;
                        counter <= 3'b100; // Jump to output stage
                    end
                    // Handle zero cases
                    else if (a_is_zero || b_is_zero) begin
                        z_is_zero <= 1'b1;
                        z_sign <= a_sign ^ b_sign;
                        counter <= 3'b100; // Jump to output stage
                    end
                    else begin
                        // Normal case: perform multiplication
                        product <= a_mantissa * b_mantissa; // 24x24 multiplication
                        z_exponent <= a_exponent + b_exponent - 10'd127; // Add exponents and subtract bias
                        z_sign <= a_sign ^ b_sign;
                        counter <= counter + 1;
                    end
                end
                
                3'b010: begin // Cycle 2: Normalization and rounding preparation
                    // Check if product needs normalization (product[47] is the leading bit)
                    if (product[47]) begin
                        // Product is in the form 1x.xxxxx... (already normalized)
                        z_mantissa <= product[46:23]; // Take 24 bits (including leading 1)
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                        z_exponent <= z_exponent + 1; // Increment exponent due to shift
                    end else begin
                        // Product is in the form 01.xxxxx... (needs normalization)
                        z_mantissa <= product[45:22];
                        guard_bit <= product[21];
                        round_bit <= product[20];
                        sticky <= |product[19:0];
                        // No exponent adjustment needed
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b011: begin // Cycle 3: Rounding and overflow/underflow handling
                    // Apply rounding (round to nearest even)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Check for mantissa overflow (carry into bit 24)
                        if (&z_mantissa) begin
                            z_mantissa <= {1'b1, 23'b0};
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    
                    // Check for exponent overflow/underflow
                    if (z_exponent[9] || (&z_exponent[8:0])) begin // Underflow or overflow
                        if (z_exponent[9]) begin // Underflow
                            z_is_zero <= 1'b1;
                        end else begin // Overflow
                            z_is_inf <= 1'b1;
                        end
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b100: begin // Cycle 4: Output formatting
                    if (z_is_nan) begin
                        z <= {1'b0, 8'hFF, 23'h7FFFFF}; // Canonical NaN
                    end else if (z_is_inf) begin
                        z <= {z_sign, 8'hFF, 23'b0}; // Infinity
                    end else if (z_is_zero) begin
                        z <= {z_sign, 31'b0}; // Zero
                    end else begin
                        // Normal case
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    
                    // Reset for next operation
                    counter <= 3'b0;
                    z_is_nan <= 1'b0;
                    z_is_inf <= 1'b0;
                    z_is_zero <= 1'b0;
                end
            endcase
        end
    end

endmodule