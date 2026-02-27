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
    reg a_is_zero, a_is_inf, a_is_nan;
    reg b_is_zero, b_is_inf, b_is_nan;
    reg special_case;

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
            a_is_zero <= 1'b0;
            a_is_inf <= 1'b0;
            a_is_nan <= 1'b0;
            b_is_zero <= 1'b0;
            b_is_inf <= 1'b0;
            b_is_nan <= 1'b0;
            special_case <= 1'b0;
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
                    a_is_zero <= (a[30:0] == 31'b0); // Zero (including denormals)
                    a_is_inf <= (a[30:23] == 8'hFF) && (a[22:0] == 23'b0); // Infinity
                    a_is_nan <= (a[30:23] == 8'hFF) && (a[22:0] != 23'b0); // NaN
                    
                    b_is_zero <= (b[30:0] == 31'b0); // Zero (including denormals)
                    b_is_inf <= (b[30:23] == 8'hFF) && (b[22:0] == 23'b0); // Infinity
                    b_is_nan <= (b[30:23] == 8'hFF) && (b[22:0] != 23'b0); // NaN
                    
                    special_case <= (a_is_nan || b_is_nan || 
                                    (a_is_zero && b_is_inf) || 
                                    (a_is_inf && b_is_zero));
                    
                    counter <= 3'b001;
                end
                
                3'b001: begin // Cycle 1: Multiply mantissas
                    if (special_case) begin
                        // Handle special cases (NaN, Inf * 0, etc.)
                        z_sign <= a_sign ^ b_sign;
                        if (a_is_nan || b_is_nan) begin
                            // NaN result
                            z_exponent <= 10'h3FF;
                            z_mantissa <= {1'b1, 22'b0, a_is_nan ? a[21:0] != 22'b0 : b[21:0] != 22'b0};
                        end else if ((a_is_zero && b_is_inf) || (a_is_inf && b_is_zero)) begin
                            // 0 * Inf or Inf * 0 = NaN
                            z_exponent <= 10'h3FF;
                            z_mantissa <= {1'b1, 23'b0};
                        end else if (a_is_inf || b_is_inf) begin
                            // Inf * number = Inf
                            z_exponent <= 10'h3FF;
                            z_mantissa <= 24'b0;
                        end else begin // a_is_zero || b_is_zero
                            // 0 * number = 0
                            z_exponent <= 10'b0;
                            z_mantissa <= 24'b0;
                        end
                        counter <= 3'b100; // Skip to output stage
                    end else begin
                        // Normal multiplication path
                        product <= {26'b0, a_mantissa} * {26'b0, b_mantissa};
                        z_exponent <= a_exponent + b_exponent - 10'd127; // Subtract bias
                        z_sign <= a_sign ^ b_sign;
                        counter <= 3'b010;
                    end
                end
                
                3'b010: begin // Cycle 2: Normalize product and prepare for rounding
                    // Check if product needs normalization (product[47] is the implicit leading 1)
                    if (product[47]) begin
                        // Product is in [2,4), shift right and increment exponent
                        z_mantissa <= product[46:23];
                        guard_bit <= product[22];
                        round_bit <= product[21];
                        sticky <= |product[20:0];
                        z_exponent <= z_exponent + 1'b1;
                    end else begin
                        // Product is in [1,2), shift left
                        z_mantissa <= product[45:22];
                        guard_bit <= product[21];
                        round_bit <= product[20];
                        sticky <= |product[19:0];
                    end
                    counter <= 3'b011;
                end
                
                3'b011: begin // Cycle 3: Rounding
                    // Round to nearest even
                    if (guard_bit && (round_bit || sticky || z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1'b1;
                        // Check for overflow in mantissa (due to rounding)
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_mantissa <= 24'h800000;
                            z_exponent <= z_exponent + 1'b1;
                        end
                    end
                    counter <= 3'b100;
                end
                
                3'b100: begin // Cycle 4: Final adjustments and output
                    // Check for exponent overflow/underflow
                    if (z_exponent[9] || (z_exponent >= 10'h0FF)) begin // Overflow
                        z_exponent <= 10'h0FF;
                        z_mantissa <= 23'b0; // Infinity
                    end else if (z_exponent == 10'b0) begin // Underflow
                        z_exponent <= 10'b0;
                        z_mantissa <= 23'b0; // Zero
                    end
                    
                    // Assemble final result
                    if (z_mantissa == 24'b0) begin
                        // Zero result
                        z <= {z_sign, 31'b0};
                    end else if (z_exponent == 10'h0FF) begin
                        // Infinity
                        z <= {z_sign, 8'hFF, 23'b0};
                    end else begin
                        // Normal result
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    
                    counter <= 3'b000; // Ready for next operation
                end
                
                default: counter <= 3'b000;
            endcase
        end
    end

endmodule