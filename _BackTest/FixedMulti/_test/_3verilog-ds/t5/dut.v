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
                3'd0: begin
                    // Cycle 1: Input processing and special case detection
                    a_sign <= a[31];
                    b_sign <= b[31];
                    
                    // Extract exponents
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    
                    // Extract mantissas with implicit bit
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
                
                3'd1: begin
                    // Cycle 2: Handle special cases and prepare for multiplication
                    z_sign <= a_sign ^ b_sign;
                    
                    // Handle NaN cases
                    if (a_is_nan || b_is_nan) begin
                        z_is_nan <= 1'b1;
                        counter <= 3'd5; // Jump to output stage
                    end 
                    // Handle infinity cases
                    else if ((a_is_inf && b_is_zero) || (b_is_inf && a_is_zero)) begin
                        z_is_nan <= 1'b1; // inf * 0 = NaN
                        counter <= 3'd5; // Jump to output stage
                    end
                    else if (a_is_inf || b_is_inf) begin
                        z_is_inf <= 1'b1;
                        counter <= 3'd5; // Jump to output stage
                    end
                    // Handle zero cases
                    else if (a_is_zero || b_is_zero) begin
                        z_is_zero <= 1'b1;
                        counter <= 3'd5; // Jump to output stage
                    end
                    else begin
                        // Normal case: calculate exponent
                        z_exponent <= a_exponent + b_exponent - 10'd127;
                        counter <= counter + 1;
                    end
                end
                
                3'd2: begin
                    // Cycle 3: Perform multiplication of mantissas
                    product <= a_mantissa * b_mantissa;
                    counter <= counter + 1;
                end
                
                3'd3: begin
                    // Cycle 4: Normalize and prepare for rounding
                    // Check if product needs normalization (bit 47 is set)
                    if (product[47]) begin
                        z_mantissa <= product[47:24];
                        guard_bit <= product[23];
                        round_bit <= product[22];
                        sticky <= |product[21:0];
                        z_exponent <= z_exponent + 1;
                    end else begin
                        z_mantissa <= product[46:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                    end
                    counter <= counter + 1;
                end
                
                3'd4: begin
                    // Cycle 5: Rounding
                    // Round to nearest even
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Check for overflow in mantissa (carry out)
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= 24'h800000;
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    counter <= counter + 1;
                end
                
                3'd5: begin
                    // Cycle 6: Handle overflow/underflow and prepare output
                    // Check for exponent overflow
                    if (z_exponent[9] || (z_exponent >= 10'd255)) begin
                        z_is_inf <= 1'b1;
                        z_is_zero <= 1'b0;
                    end
                    // Check for exponent underflow
                    else if (z_exponent == 10'd0 || z_exponent[9]) begin
                        z_is_zero <= 1'b1;
                        z_is_inf <= 1'b0;
                    end
                    
                    // Prepare output
                    if (z_is_nan) begin
                        z <= {1'b0, 8'hFF, 23'h7FFFFF}; // Canonical NaN
                    end else if (z_is_inf) begin
                        z <= {z_sign, 8'hFF, 23'h0};
                    end else if (z_is_zero) begin
                        z <= {z_sign, 31'h0};
                    end else begin
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    
                    counter <= 3'd0; // Reset for next operation
                end
            endcase
        end
    end

endmodule