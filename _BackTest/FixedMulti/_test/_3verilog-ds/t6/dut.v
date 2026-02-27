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
                    
                    // Extract mantissas (with implicit leading 1 for normalized numbers)
                    a_mantissa <= (|a[30:23]) ? {1'b1, a[22:0]} : {1'b0, a[22:0]};
                    b_mantissa <= (|b[30:23]) ? {1'b1, b[22:0]} : {1'b0, b[22:0]};
                    
                    // Detect special cases for a
                    a_is_nan <= (&a[30:23]) && (|a[22:0]); // Exponent all 1s, mantissa non-zero
                    a_is_inf <= (&a[30:23]) && (~|a[22:0]); // Exponent all 1s, mantissa zero
                    a_is_zero <= ~|a[30:0]; // All bits zero (except sign)
                    
                    // Detect special cases for b
                    b_is_nan <= (&b[30:23]) && (|b[22:0]);
                    b_is_inf <= (&b[30:23]) && (~|b[22:0]);
                    b_is_zero <= ~|b[30:0];
                    
                    counter <= counter + 1;
                end
                
                3'b001: begin // Cycle 1: Handle special cases and prepare multiplication
                    // Handle NaN cases (NaN input or inf*0)
                    if (a_is_nan || b_is_nan || (a_is_inf && b_is_zero) || (b_is_inf && a_is_zero)) begin
                        z_is_nan <= 1'b1;
                        counter <= 3'b100; // Jump to output stage
                    end 
                    // Handle infinity cases
                    else if (a_is_inf || b_is_inf) begin
                        z_is_inf <= 1'b1;
                        z_sign <= a_sign ^ b_sign;
                        counter <= 3'b100; // Jump to output stage
                    end
                    // Handle zero cases
                    else if (a_is_zero || b_is_zero) begin
                        z_is_zero <= 1'b1;
                        z_sign <= a_sign ^ b_sign;
                        counter <= 3'b100; // Jump to output stage
                    end
                    // Normal case - prepare for multiplication
                    else begin
                        // Calculate product sign
                        z_sign <= a_sign ^ b_sign;
                        
                        // Add exponents and subtract bias (127)
                        z_exponent <= a_exponent + b_exponent - 10'd127;
                        
                        // Multiply mantissas (24x24 bits)
                        product <= a_mantissa * b_mantissa;
                        
                        counter <= counter + 1;
                    end
                end
                
                3'b010: begin // Cycle 2: Normalize product and prepare for rounding
                    // The product is 48 bits (24x24) with 2 integer bits (01.xxxx or 1x.xxxx)
                    if (product[47]) begin // If product is 1x.xxxx...
                        z_mantissa <= product[46:23]; // Take bits [46:23] as mantissa
                        z_exponent <= z_exponent + 1; // Increment exponent
                        
                        // Rounding bits
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end else begin // Product is 01.xxxx...
                        z_mantissa <= product[45:22]; // Take bits [45:22] as mantissa
                        
                        // Rounding bits
                        guard_bit <= product[21];
                        round_bit <= product[20];
                        sticky <= |product[19:0];
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b011: begin // Cycle 3: Rounding and final adjustments
                    // Round to nearest even
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        
                        // Check for mantissa overflow (becomes 1.000...0)
                        if (&z_mantissa) begin
                            z_mantissa <= 24'b1000_0000_0000_0000_0000_0000;
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b100: begin // Cycle 4: Final output formatting
                    if (z_is_nan) begin
                        z <= {1'b0, 8'hFF, 23'h7FFFFF}; // Quiet NaN
                    end else if (z_is_inf) begin
                        z <= {z_sign, 8'hFF, 23'h0}; // Infinity
                    end else if (z_is_zero) begin
                        z <= {z_sign, 31'h0}; // Zero
                    end else begin
                        // Check for exponent overflow (>= 255)
                        if (z_exponent[9] || &z_exponent[7:0]) begin
                            z <= {z_sign, 8'hFF, 23'h0}; // Overflow to infinity
                        end
                        // Check for exponent underflow (<= 0)
                        else if (z_exponent[8]) begin
                            z <= {z_sign, 31'h0}; // Underflow to zero
                        end
                        // Normal case
                        else begin
                            z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                        end
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