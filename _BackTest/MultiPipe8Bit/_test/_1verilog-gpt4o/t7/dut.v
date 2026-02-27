
module dut (
    input           clk,           // Clock signal
    input           rst_n,         // Active-low reset signal
    input           mul_en_in,     // Input enable signal
    input  [7:0]    mul_a,         // 8-bit multiplicand
    input  [7:0]    mul_b,         // 8-bit multiplier
    output reg      mul_en_out,    // Output enable signal
    output reg [15:0] mul_out      // 16-bit product output
);

    // Pipeline Registers
    reg [7:0] mul_a_reg1, mul_b_reg1; // Input registers for stage 1
    reg mul_en_reg1;
    reg [15:0] partial_product0, partial_product1, partial_product2, partial_product3;
    
    reg [15:0] partial_sum01, partial_sum23; // Intermediate registers
    reg mul_en_reg2;
    
    reg [15:0] mul_out_reg3; // Register for final output product
    reg mul_en_reg3;

    // Stage 1: Sample Inputs
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg1 <= 8'b0;
            mul_b_reg1 <= 8'b0;
            mul_en_reg1 <= 1'b0;
        end else if (mul_en_in) begin
            mul_a_reg1 <= mul_a;
            mul_b_reg1 <= mul_b;
            mul_en_reg1 <= 1'b1;
        end else begin
            mul_en_reg1 <= 1'b0;
        end
    end

    // Stage 2: Partial Product Generation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            partial_product0 <= 16'b0;
            partial_product1 <= 16'b0;
            partial_product2 <= 16'b0;
            partial_product3 <= 16'b0;
            mul_en_reg2 <= 1'b0;
        end else if (mul_en_reg1) begin
            partial_product0 <= mul_a_reg1[3:0] * mul_b_reg1[3:0];   // Lower 4x4 multiplier
            partial_product1 <= mul_a_reg1[7:4] * mul_b_reg1[3:0];   // Upper 4x4 (higher multiplicand)
            partial_product2 <= mul_a_reg1[3:0] * mul_b_reg1[7:4];   // 4x4 (higher multiplier)
            partial_product3 <= mul_a_reg1[7:4] * mul_b_reg1[7:4];   // Upper 4x4 multiplier
            mul_en_reg2 <= 1'b1;
        end else begin
            mul_en_reg2 <= 1'b0;
        end
    end

    // Stage 3: Partial Sum Calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            partial_sum01 <= 16'b0;
            partial_sum23 <= 16'b0;
            mul_en_reg3 <= 1'b0;
        end else if (mul_en_reg2) begin
            partial_sum01 <= partial_product0 + (partial_product1 << 4); // Align and sum lower products
            partial_sum23 <= partial_product2 + (partial_product3 << 4); // Align and sum higher products
            mul_en_reg3 <= 1'b1;
        end else begin
            mul_en_reg3 <= 1'b0;
        end
    end

    // Stage 4: Final Product Calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg3 <= 16'b0;
            mul_en_out <= 1'b0;
        end else if (mul_en_reg3) begin
            mul_out_reg3 <= partial_sum01 + (partial_sum23 << 8); // Combine partial sums
            mul_en_out <= 1'b1;
        end else begin
            mul_en_out <= 1'b0;
        end
    end

    // Assign output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 16'b0;
        end else if (mul_en_out) begin
            mul_out <= mul_out_reg3;
        end else begin
            mul_out <= 16'b0;
        end
    end

endmodule
