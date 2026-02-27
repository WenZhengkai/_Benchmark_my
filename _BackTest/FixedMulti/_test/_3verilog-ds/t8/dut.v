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
    reg a_is_nan, a_is_inf, a_is_zero;
    reg b_is_nan, b_is_inf, b_is_zero;
    reg z_is_nan, z_is_inf, z_is_zero;
    
    // Pipeline registers
    reg [31:0] a_reg, b_reg;
    
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
            a_reg <= 32'b0;
            b_reg <= 32'b0;
            z <= 32'b0;
        end else begin
            // Pipeline stage 0: Register inputs and check special cases
            if (counter == 3'b000) begin
                a_reg <= a;
                b_reg <= b;
                
                // Check for special cases in input a
                a_is_nan <= &a[30:23] && (|a[22:0]); // Exponent all 1s, mantissa non-zero
                a_is_inf <= &a[30:23] && ~(|a[22:0]); // Exponent all 1s, mantissa zero
                a_is_zero <= ~(|a[30:0]); // All bits zero (including sign)
                
                // Check for special cases in input b
                b_is_nan <= &b[30:23] && (|b[22:0]);
                b_is_inf <= &b[30:23] && ~(|b[22:0]);
                b_is_zero <= ~(|b[30:0]);
                
                counter <= counter + 1;
            end
            
            // Pipeline stage 1: Extract components and prepare for multiplication
            else if (counter == 3'b001) begin
                // Extract sign bits
                a_sign <= a_reg[31];
                b_sign <= b_reg[31];
                
                // Extract exponents
                a_exponent <= {2'b0, a_reg[30:23]};
                b_exponent <= {2'b0, b_reg[30:23]};
                
                // Extract mantissas and add implicit leading 1 for normalized numbers
                a_mantissa <= (a_is_zero || a_is_inf || a_is_nan) ? {1'b0, a_reg[22:0]} : 
                              {1'b1, a_reg[22:0]};
                b_mantissa <= (b_is_zero || b_is_inf || b_is_nan) ? {1'b0, b_reg[22:0]} : 
                              {1'b1, b_reg[22:0]};
                
                counter <= counter + 1;
            end
            
            // Pipeline stage 2: Multiply mantissas and add exponents
            else if (counter == 3'b010) begin
                // Multiply mantissas (24x24 bits)
                product <= a_mantissa * b_mantissa;
                
                // Add exponents and subtract bias (127)
                z_exponent <= a_exponent + b_exponent - 10'd127;
                
                // Calculate sign of result
                z_sign <= a_sign ^ b_sign;
                
                counter <= counter + 1;
            end
            
            // Pipeline stage 3: Normalize product and prepare for rounding
            else if (counter == 3'b011) begin
                // Normalize the product
                if (product[47]) begin
                    // Product is in [2,4), shift right by 1
                    product <= product >> 1;
                    z_exponent <= z_exponent + 1;
                end
                
                // Extract guard, round, and sticky bits
                guard_bit <= product[22];
                round_bit <= product[21];
                sticky <= |product[20:0];
                
                counter <= counter + 1;
            end
            
            // Pipeline stage 4: Rounding and final exponent adjustment
            else if (counter == 3'b100) begin
                // Default mantissa (bits [46:24] after normalization)
                z_mantissa <= product[46:24];
                
                // Round to nearest even
                if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                    z_mantissa <= z_mantissa + 1;
                    
                    // Check for mantissa overflow (carry into bit 24)
                    if (&z_mantissa) begin
                        z_mantissa <= {1'b1, 23'b0};
                        z_exponent <= z_exponent + 1;
                    end
                end
                
                counter <= counter + 1;
            end
            
            // Pipeline stage 5: Handle special cases and generate final output
            else if (counter == 3'b101) begin
                // Check for NaN
                if (a_is_nan || b_is_nan) begin
                    z_is_nan <= 1'b1;
                end 
                // Check for infinity * zero
                else if ((a_is_inf && b_is_zero) || (a_is_zero && b_is_inf)) begin
                    z_is_nan <= 1'b1;
                end
                // Check for infinity cases
                else if (a_is_inf || b_is_inf) begin
                    z_is_inf <= 1'b1;
                end
                // Check for zero cases
                else if (a_is_zero || b_is_zero) begin
                    z_is_zero <= 1'b1;
                end
                // Check for exponent overflow
                else if (z_exponent[9] || (z_exponent[7:0] >= 8'hFF)) begin
                    z_is_inf <= 1'b1;
                end
                // Check for exponent underflow
                else if (z_exponent[8] || (z_exponent[7:0] == 8'h00)) begin
                    z_is_zero <= 1'b1;
                end
                
                counter <= counter + 1;
            end
            
            // Pipeline stage 6: Format final output
            else if (counter == 3'b110) begin
                if (z_is_nan) begin
                    z <= {1'b0, 8'hFF, 23'h7FFFFF}; // Quiet NaN
                end else if (z_is_inf) begin
                    z <= {z_sign, 8'hFF, 23'h000000};
                end else if (z_is_zero) begin
                    z <= {z_sign, 31'h00000000};
                end else begin
                    z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                end
                
                counter <= 3'b000; // Reset counter for next operation
            end
        end
    end

endmodule