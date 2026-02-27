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
                    
                    // Detect special cases
                    a_is_nan <= (&a[30:23]) && (|a[22:0]); // Exponent all 1s, mantissa non-zero
                    a_is_inf <= (&a[30:23]) && (~|a[22:0]); // Exponent all 1s, mantissa zero
                    a_is_zero <= (~|a[30:23]) && (~|a[22:0]); // Exponent all 0s, mantissa zero
                    
                    b_is_nan <= (&b[30:23]) && (|b[22:0]);
                    b_is_inf <= (&b[30:23]) && (~|b[22:0]);
                    b_is_zero <= (~|b[30:23]) && (~|b[22:0]);
                    
                    counter <= counter + 1;
                end
                
                3'b001: begin // Cycle 1: Handle special cases and prepare multiplication
                    // Handle NaN cases (NaN * anything = NaN)
                    if (a_is_nan || b_is_nan) begin
                        z_is_nan <= 1'b1;
                        counter <= 3'b111; // Jump to final stage
                    end 
                    // Handle infinity cases
                    else if ((a_is_inf && !b_is_zero) || (b_is_inf && !a_is_zero)) begin
                        z_is_inf <= 1'b1;
                        z_sign <= a_sign ^ b_sign;
                        counter <= 3'b111; // Jump to final stage
                    end
                    // Handle zero cases (0 * anything = 0, except 0 * inf = NaN)
                    else if (a_is_zero || b_is_zero) begin
                        if ((a_is_zero && b_is_inf) || (b_is_zero && a_is_inf)) begin
                            z_is_nan <= 1'b1;
                        end else begin
                            z_is_zero <= 1'b1;
                            z_sign <= a_sign ^ b_sign;
                        end
                        counter <= 3'b111; // Jump to final stage
                    end
                    // Normal case: prepare for multiplication
                    else begin
                        // Calculate product sign
                        z_sign <= a_sign ^ b_sign;
                        
                        // Add exponents and subtract bias (127)
                        z_exponent <= a_exponent + b_exponent - 10'd127;
                        
                        // Multiply mantissas (24x24 bits = 48 bits)
                        product <= a_mantissa * b_mantissa;
                        
                        counter <= counter + 1;
                    end
                end
                
                3'b010: begin // Cycle 2: Normalize product and calculate rounding bits
                    // The product is in bits [47:0] of the 50-bit register
                    // Normalize: shift left until MSB is 1 (or until exponent underflows)
                    if (product[47]) begin
                        // Already normalized (MSB is 1)
                        z_mantissa <= product[47:24]; // Take upper 24 bits (including implicit 1)
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                    end else begin
                        // Need to shift left
                        z_mantissa <= product[46:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                        z_exponent <= z_exponent - 1; // Adjust exponent for left shift
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b011: begin // Cycle 3: Rounding
                    // Round to nearest even (IEEE default)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Check for overflow in mantissa (carry out)
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= 24'h800000; // 1.000...0
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b100: begin // Cycle 4: Check for overflow/underflow and finalize
                    // Check for exponent overflow (>= 255)
                    if (z_exponent[9] || (z_exponent[8:0] >= 9'd255)) begin
                        z_is_inf <= 1'b1;
                        z_is_zero <= 1'b0;
                    end
                    // Check for exponent underflow (<= 0)
                    else if (z_exponent[8:0] == 9'b0) begin
                        z_is_zero <= 1'b1;
                        z_is_inf <= 1'b0;
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b101: begin // Cycle 5: Prepare output
                    if (z_is_nan) begin
                        z <= {1'b0, 8'hFF, 23'h7FFFFF}; // Quiet NaN
                    end else if (z_is_inf) begin
                        z <= {z_sign, 8'hFF, 23'h0}; // Infinity
                    end else if (z_is_zero) begin
                        z <= {z_sign, 31'h0}; // Zero
                    end else begin
                        // Normal case: assemble final result
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    
                    counter <= counter + 1;
                end
                
                3'b110: begin // Cycle 6: Output is ready
                    // Hold output for one cycle
                    counter <= counter + 1;
                end
                
                3'b111: begin // Cycle 7: Reset counter
                    counter <= 3'b0;
                end
            endcase
        end
    end

endmodule