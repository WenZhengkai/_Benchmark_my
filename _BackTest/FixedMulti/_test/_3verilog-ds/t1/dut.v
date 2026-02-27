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
    
    // Special case flags
    reg a_is_nan, b_is_nan, a_is_inf, b_is_inf, a_is_zero, b_is_zero;
    
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
            z <= 32'b0;
            
            a_is_nan <= 1'b0;
            b_is_nan <= 1'b0;
            a_is_inf <= 1'b0;
            b_is_inf <= 1'b0;
            a_is_zero <= 1'b0;
            b_is_zero <= 1'b0;
        end else begin
            case (counter)
                3'b000: begin // Cycle 0: Input processing and special case detection
                    // Extract sign bits
                    a_sign <= a[31];
                    b_sign <= b[31];
                    
                    // Extract exponents
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    
                    // Extract mantissas with implicit leading 1
                    a_mantissa <= (|a[30:23]) ? {1'b1, a[22:0]} : {1'b0, a[22:0]};
                    b_mantissa <= (|b[30:23]) ? {1'b1, b[22:0]} : {1'b0, b[22:0]};
                    
                    // Detect special cases
                    a_is_nan <= (&a[30:23]) && (|a[22:0]);
                    b_is_nan <= (&b[30:23]) && (|b[22:0]);
                    a_is_inf <= (&a[30:23]) && ~(|a[22:0]);
                    b_is_inf <= (&b[30:23]) && ~(|b[22:0]);
                    a_is_zero <= ~(|a[30:0]);
                    b_is_zero <= ~(|b[30:0]);
                    
                    counter <= counter + 1;
                end
                
                3'b001: begin // Cycle 1: Handle special cases and prepare multiplication
                    // Handle NaN cases (NaN input always results in NaN output)
                    if (a_is_nan || b_is_nan) begin
                        z_sign <= 1'b0;
                        z_exponent <= 10'hFF;
                        z_mantissa <= {1'b1, 22'b0}; // Quiet NaN
                        counter <= 3'b100; // Skip to output stage
                    end 
                    // Handle infinity cases
                    else if (a_is_inf || b_is_inf) begin
                        if (a_is_zero || b_is_zero) begin
                            // Infinity * Zero = NaN
                            z_sign <= 1'b0;
                            z_exponent <= 10'hFF;
                            z_mantissa <= {1'b1, 22'b0}; // Quiet NaN
                        end else begin
                            // Infinity * Number = Infinity
                            z_sign <= a_sign ^ b_sign;
                            z_exponent <= 10'hFF;
                            z_mantissa <= 24'b0;
                        end
                        counter <= 3'b100; // Skip to output stage
                    end
                    // Handle zero cases
                    else if (a_is_zero || b_is_zero) begin
                        z_sign <= a_sign ^ b_sign;
                        z_exponent <= 10'b0;
                        z_mantissa <= 24'b0;
                        counter <= 3'b100; // Skip to output stage
                    end
                    else begin
                        // Normal case: proceed with multiplication
                        counter <= counter + 1;
                    end
                end
                
                3'b010: begin // Cycle 2: Perform multiplication
                    // Multiply mantissas (24x24 bits)
                    product <= a_mantissa * b_mantissa;
                    
                    // Calculate exponent sum (with bias adjustment)
                    z_exponent <= a_exponent + b_exponent - 10'd127;
                    
                    // Calculate sign
                    z_sign <= a_sign ^ b_sign;
                    
                    counter <= counter + 1;
                end
                
                3'b011: begin // Cycle 3: Normalization and rounding
                    // Check if product needs normalization (product[47] is the MSB)
                    if (product[47]) begin
                        // Product is in [2,4), shift right by 1
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
                    
                    // Round to nearest even
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Check for mantissa overflow (only possible when rounding)
                        if (&z_mantissa) begin
                            z_mantissa <= {1'b1, 23'b0};
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b100: begin // Cycle 4: Handle overflow/underflow and generate output
                    // Check for exponent overflow
                    if (z_exponent[9] || (&z_exponent[7:0])) begin // Exponent >= 255 or negative
                        if (z_exponent[9]) begin // Underflow
                            // Flush to zero
                            z_sign <= z_sign;
                            z_exponent <= 10'b0;
                            z_mantissa <= 24'b0;
                        end else begin // Overflow
                            // Set to infinity
                            z_sign <= z_sign;
                            z_exponent <= 10'hFF;
                            z_mantissa <= 24'b0;
                        end
                    end
                    
                    // Assemble final output
                    z[31] <= z_sign;
                    z[30:23] <= z_exponent[7:0];
                    z[22:0] <= z_mantissa[22:0];
                    
                    counter <= 3'b0;
                end
                
                default: counter <= 3'b0;
            endcase
        end
    end

endmodule