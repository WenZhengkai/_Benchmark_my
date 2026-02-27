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

    // IEEE 754 special values
    parameter ZERO = 32'h00000000;
    parameter INF  = 32'h7F800000;
    parameter NaN  = 32'h7FC00000;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 3'b000;
            z <= 32'b0;
        end else begin
            case (counter)
                3'b000: begin // Input processing
                    a_mantissa <= {1'b1, a[22:0]};
                    b_mantissa <= {1'b1, b[22:0]};
                    a_exponent <= {2'b0, a[30:23]};
                    b_exponent <= {2'b0, b[30:23]};
                    a_sign <= a[31];
                    b_sign <= b[31];
                    counter <= counter + 1;
                end

                3'b001: begin // Special cases handling
                    if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 255 && b_mantissa != 0)) begin
                        z <= NaN; // NaN
                        counter <= 3'b111;
                    end else if ((a_exponent == 255) || (b_exponent == 255)) begin
                        z <= INF; // Infinity
                        z[31] <= a_sign ^ b_sign;
                        counter <= 3'b111;
                    end else if ((a_exponent == 0 && a_mantissa == 0) || (b_exponent == 0 && b_mantissa == 0)) begin
                        z <= ZERO; // Zero
                        z[31] <= a_sign ^ b_sign;
                        counter <= 3'b111;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                3'b010: begin // Multiplication
                    z_sign <= a_sign ^ b_sign;
                    z_exponent <= a_exponent + b_exponent - 127;
                    product <= a_mantissa * b_mantissa;
                    counter <= counter + 1;
                end

                3'b011: begin // Normalization
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

                3'b100: begin // Rounding
                    if ((guard_bit && round_bit) || (guard_bit && sticky) || (guard_bit && z_mantissa[0])) begin
                        z_mantissa <= z_mantissa + 1;
                        if (z_mantissa == 24'hFFFFFF) begin
                            z_exponent <= z_exponent + 1;
                        end
                    end
                    counter <= counter + 1;
                end

                3'b101: begin // Final formatting
                    if (z_exponent >= 255) begin
                        z <= {z_sign, 8'hFF, 23'b0}; // Overflow to infinity
                    end else if (z_exponent <= 0) begin
                        z <= {z_sign, 31'b0}; // Underflow to zero
                    end else begin
                        z <= {z_sign, z_exponent[7:0], z_mantissa[22:0]};
                    end
                    counter <= 3'b111;
                end

                3'b111: begin // Idle state
                    counter <= 3'b000;
                end

                default: counter <= 3'b000;
            endcase
        end
    end

endmodule