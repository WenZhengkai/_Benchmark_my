
module dut (
    input wire clk,            // Clock signal
    input wire rst_n,          // Active-low reset
    input wire mul_en_in,      // Input enable signal
    input wire [7:0] mul_a,    // Multiplicand (8 bits)
    input wire [7:0] mul_b,    // Multiplier (8 bits)
    output reg mul_en_out,     // Output enable signal
    output reg [15:0] mul_out  // Product (16 bits)
);

    // Pipeline stage registers
    reg [7:0] mul_a_reg1, mul_a_reg2, mul_a_reg3;
    reg [7:0] mul_b_reg1, mul_b_reg2, mul_b_reg3;
    reg [15:0] partial_sum1, partial_sum2, partial_sum3; // Partial sums
    reg mul_en_reg1, mul_en_reg2, mul_en_reg3;

    // Stage 1 - Register inputs and initialize first partial product
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg1 <= 8'd0;
            mul_b_reg1 <= 8'd0;
            partial_sum1 <= 16'd0;
            mul_en_reg1 <= 1'b0;
        end else if (mul_en_in) begin
            mul_a_reg1 <= mul_a;
            mul_b_reg1 <= mul_b;
            partial_sum1 <= mul_a * mul_b[3:0]; // Calculate partial product for low 4 bits
            mul_en_reg1 <= mul_en_in;
        end else begin
            mul_en_reg1 <= 1'b0;
        end
    end

    // Stage 2 - Process next set of partial products
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg2 <= 8'd0;
            mul_b_reg2 <= 8'd0;
            partial_sum2 <= 16'd0;
            mul_en_reg2 <= 1'b0;
        end else if (mul_en_reg1) begin
            mul_a_reg2 <= mul_a_reg1;
            mul_b_reg2 <= mul_b_reg1;
            partial_sum2 <= partial_sum1 + (mul_a_reg1 * {4'b0, mul_b_reg1[7:4]} << 4); // Add shifted high partial product
            mul_en_reg2 <= mul_en_reg1;
        end else begin
            mul_en_reg2 <= 1'b0;
        end
    end

    // Stage 3 - Final accumulation and output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg3 <= 8'd0;
            mul_b_reg3 <= 8'd0;
            partial_sum3 <= 16'd0;
            mul_en_reg3 <= 1'b0;
        end else if (mul_en_reg2) begin
            mul_a_reg3 <= mul_a_reg2;
            mul_b_reg3 <= mul_b_reg2;
            partial_sum3 <= partial_sum2; // No additional work here for this small design
            mul_en_reg3 <= mul_en_reg2;
        end else begin
            mul_en_reg3 <= 1'b0;
        end
    end

    // Output assignment
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out <= 1'b0;
            mul_out <= 16'd0;
        end else if (mul_en_reg3) begin
            mul_en_out <= 1'b1;
            mul_out <= partial_sum3; // Assign final accumulated product
        end else begin
            mul_out <= 16'd0;
            mul_en_out <= 1'b0;
        end
    end

endmodule
