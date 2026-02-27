
module dut (
    input wire clk,           // Clock signal
    input wire rst_n,         // Active-low reset signal
    input wire mul_en_in,     // Input enable signal
    input wire [7:0] mul_a,   // Multiplicand input
    input wire [7:0] mul_b,   // Multiplier input
    output reg mul_en_out,    // Output enable signal
    output reg [15:0] mul_out // Product output
);

    // Pipeline Registers
    reg [7:0] mul_a_reg1, mul_b_reg1;  // Stage 1 inputs
    reg [7:0] mul_a_reg2;              // Stage 2 multiplicand
    reg [15:0] partial_product_reg1;   // Stage 2 partial product
    reg [15:0] partial_product_reg2;   // Stage 3 partial sum accumulator
    reg mul_en_out_reg1, mul_en_out_reg2; // Pipeline enable registers

    // Pipeline Stage 1: Input sampling
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg1 <= 8'b0;
            mul_b_reg1 <= 8'b0;
            mul_en_out_reg1 <= 1'b0;
        end else begin
            if (mul_en_in) begin
                mul_a_reg1 <= mul_a;
                mul_b_reg1 <= mul_b;
            end
            mul_en_out_reg1 <= mul_en_in;
        end
    end

    // Pipeline Stage 2: Partial product generation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg2 <= 8'b0;
            partial_product_reg1 <= 16'b0;
            mul_en_out_reg2 <= 1'b0;
        end else begin
            mul_a_reg2 <= mul_a_reg1;
            partial_product_reg1 <= mul_a_reg1 * {8'b0, mul_b_reg1[3:0]}; // Lowest 4 multiplier bits
            mul_en_out_reg2 <= mul_en_out_reg1;
        end
    end

    // Pipeline Stage 3: Final product accumulation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            partial_product_reg2 <= 16'b0;
            mul_out <= 16'b0;
            mul_en_out <= 1'b0;
        end else begin
            partial_product_reg2 <= partial_product_reg1 + (mul_a_reg2 * {8'b0, mul_b_reg1[7:4]}); // Higher 4 multiplier bits
            mul_out <= (mul_en_out_reg2) ? partial_product_reg2 : 16'b0;
            mul_en_out <= mul_en_out_reg2;
        end
    end

endmodule
