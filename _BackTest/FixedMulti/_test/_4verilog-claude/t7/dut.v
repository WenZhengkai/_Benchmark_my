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

    // Constants
    localparam BIAS = 10'd127;
    localparam MAX_EXPONENT = 10'd255;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 3'd0;
            z <= 32'd0;
        end else begin
            case (counter)
                3'd0: begin // Input processing
                    a_sign <= a[31];
                    b_sign <= b[31];
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    a_mantissa <= {1'b1, a[22:0]};
                    b_mantissa <= {1'b1, b[22:0]};
                    counter <= counter + 1;
                end

                3'd1: begin // Special cases handling
                    if ((a_exponent == MAX_EXPONENT && a_mantissa[22:0] != 0) ||
                        (b_exponent == MAX_EXPONENT && b_mantissa[22:0] != 0)) begin
                        // NaN
                        z <= {1'b1, {8{1'b1}}, 1'b1, {22{1'b0}}};
                        counter <= 3'd7;
                    end else if (a_exponent == MAX_EXPONENT || b_exponent == MAX_EXPONENT) begin
                        // Infinity
                        z_sign <= a_sign ^ b_sign;
                        z_exponent <= MAX_EXPONENT;
                        z_mantissa <= 24'd0;
                        counter <= 3'd6;
                    end else if (a_exponent == 0 || b_exponent == 0) begin
                        // Zero
                        z <= 32'd0;
                        counter <= 3'd7;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                3'd2: begin // Multiplication
                    z_sign <= a_sign ^ b_sign;
                    z_exponent <= a_exponent + b_exponent - BIAS;
                    product <= a_mantissa * b_mantissa;
                    counter <= counter + 1;
                end

                3'd3: begin // Normalization
                    if (product[49] == 1'b1) begin
                        z_mantissa <= product[49:26];
                        guard_bit <= product[25];
                        round_bit <= product[24];
                        sticky <= |product[23:0];
                        z_exponent <= z_exponent + 1;
                    end else begin
                        z_mantissa <= product[48:25];
                        guard_bit <= product[24];
                        round_bit <= product[23];
                        sticky <= |product[22:0];
                    end
                    counter <= counter + 1;
                end

                3'd4: begin // Rounding
                    if ((guard_bit && round_bit) || (guard_bit && sticky) || (guard_bit && z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        if (z_mantissa == 24'hffffff) begin
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    counter <= counter + 1;
                end

                3'd5: begin // Overflow/Underflow check
                    if (z_exponent >= MAX_EXPONENT) begin
                        z_exponent <= MAX_EXPONENT;
                        z_mantissa <= 24'd0;
                    end else if (z_exponent[9] == 1'b1) begin
                        z_exponent <= 8'd0;
                        z_mantissa <= 24'd0;
                    end
                    counter <= counter + 1;
                end

                3'd6: begin // Result assembly
                    z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    counter <= counter + 1;
                end

                3'd7: begin // Idle state
                    counter <= counter;
                end
            endcase
        end
    end

endmodule