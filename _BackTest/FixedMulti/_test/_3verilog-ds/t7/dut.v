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
    reg a_is_zero, a_is_inf, a_is_nan;
    reg b_is_zero, b_is_inf, b_is_nan;
    reg z_is_zero, z_is_inf, z_is_nan;

    // Constants
    localparam [9:0] EXP_BIAS = 10'd127;
    localparam [9:0] EXP_MAX = 10'd255;
    localparam [9:0] EXP_MIN = 10'd0;

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
            a_is_zero <= 1'b0;
            a_is_inf <= 1'b0;
            a_is_nan <= 1'b0;
            b_is_zero <= 1'b0;
            b_is_inf <= 1'b0;
            b_is_nan <= 1'b0;
            z_is_zero <= 1'b0;
            z_is_inf <= 1'b0;
            z_is_nan <= 1'b0;
            z <= 32'b0;
        end else begin
            case (counter)
                3'd0: begin
                    // Cycle 0: Input processing and special case detection
                    a_sign <= a[31];
                    b_sign <= b[31];
                    z_sign <= a[31] ^ b[31]; // Result sign is XOR of input signs
                    
                    // Extract exponents
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    
                    // Extract mantissas and add implicit leading bit
                    a_mantissa <= (|a[30:23]) ? {1'b1, a[22:0]} : {1'b0, a[22:0]};
                    b_mantissa <= (|b[30:23]) ? {1'b1, b[22:0]} : {1'b0, b[22:0]};
                    
                    // Detect special cases
                    a_is_zero <= (a[30:0] == 31'b0);
                    b_is_zero <= (b[30:0] == 31'b0);
                    a_is_inf <= (a[30:23] == 8'hFF) && (a[22:0] == 23'b0);
                    b_is_inf <= (b[30:23] == 8'hFF) && (b[22:0] == 23'b0);
                    a_is_nan <= (a[30:23] == 8'hFF) && (a[22:0] != 23'b0);
                    b_is_nan <= (b[30:23] == 8'hFF) && (b[22:0] != 23'b0);
                    
                    counter <= counter + 1;
                end
                
                3'd1: begin
                    // Cycle 1: Handle special cases and prepare for multiplication
                    if (a_is_nan || b_is_nan) begin
                        // NaN propagation
                        z_is_nan <= 1'b1;
                        counter <= 3'd5; // Jump to final stage
                    end else if ((a_is_zero && b_is_inf) || (a_is_inf && b_is_zero)) begin
                        // 0 * inf = NaN
                        z_is_nan <= 1'b1;
                        counter <= 3'd5; // Jump to final stage
                    end else if (a_is_zero || b_is_zero) begin
                        // Multiplication by zero
                        z_is_zero <= 1'b1;
                        counter <= 3'd5; // Jump to final stage
                    end else if (a_is_inf || b_is_inf) begin
                        // Multiplication by infinity
                        z_is_inf <= 1'b1;
                        counter <= 3'd5; // Jump to final stage
                    end else begin
                        // Normal case: calculate exponent sum
                        z_exponent <= a_exponent + b_exponent - EXP_BIAS;
                        counter <= counter + 1;
                    end
                end
                
                3'd2: begin
                    // Cycle 2: Perform mantissa multiplication (first stage)
                    // Multiply the 24-bit mantissas (48-bit result)
                    product <= {26'b0, a_mantissa} * {26'b0, b_mantissa};
                    counter <= counter + 1;
                end
                
                3'd3: begin
                    // Cycle 3: Normalize and prepare for rounding
                    // The product is 48 bits (24x24 multiplication)
                    // We need to normalize it to 24 bits (including the leading 1)
                    
                    if (product[47]) begin
                        // Product is in [2,4), shift right once
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
                
                3'd4: begin
                    // Cycle 4: Rounding and final adjustment
                    // Round to nearest even (IEEE default)
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        // Check for mantissa overflow (carry into bit 24)
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= 24'h800000;
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    
                    // Check for exponent overflow/underflow
                    if (z_exponent >= EXP_MAX) begin
                        z_is_inf <= 1'b1;
                    end else if (z_exponent <= EXP_MIN) begin
                        z_is_zero <= 1'b1;
                    end
                    
                    counter <= counter + 1;
                end
                
                3'd5: begin
                    // Cycle 5: Final output assembly
                    if (z_is_nan) begin
                        // NaN output (quiet NaN with payload from inputs)
                        z <= {1'b0, 8'hFF, 23'h7FFFFF};
                    end else if (z_is_inf) begin
                        // Infinity output
                        z <= {z_sign, 8'hFF, 23'b0};
                    end else if (z_is_zero) begin
                        // Zero output
                        z <= {z_sign, 31'b0};
                    end else begin
                        // Normal output
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    
                    counter <= 3'd0; // Reset counter for next operation
                end
            endcase
        end
    end

endmodule