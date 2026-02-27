
module dut (
    input wire clk,               // Clock signal
    input wire rst_n,             // Active-low reset signal
    input wire mul_en_in,         // Input enable signal
    input wire [7:0] mul_a,       // Multiplicand (8 bits)
    input wire [7:0] mul_b,       // Multiplier (8 bits)
    output reg mul_en_out,        // Output enable signal
    output reg [15:0] mul_out     // Product output (16 bits)
);

    // Input enable pipeline register
    reg [1:0] mul_en_out_reg;

    // Input registers for storing multiplicand and multiplier
    reg [7:0] mul_a_reg1, mul_b_reg1;
    reg [7:0] mul_a_reg2, mul_b_reg2;

    // Partial product registers (pipeline stages)
    reg [15:0] partial_sum_stage1;
    reg [15:0] partial_sum_stage2;

    // Register for final product
    reg [15:0] mul_out_reg;

    // Pipelined enable signal logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out_reg <= 2'b00;
        end else begin
            mul_en_out_reg <= {mul_en_out_reg[0], mul_en_in};
        end
    end

    assign mul_en_out = mul_en_out_reg[1];

    // Stage 1: Latch inputs and compute initial partial products
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg1 <= 8'b0;
            mul_b_reg1 <= 8'b0;
            partial_sum_stage1 <= 16'b0;
        end else if (mul_en_in) begin
            mul_a_reg1 <= mul_a;
            mul_b_reg1 <= mul_b;

            // Generate initial partial products in Stage 1
            partial_sum_stage1 <= mul_a * mul_b[3:0]; // Lower 4 bits of mul_b
        end
    end

    // Stage 2: Compute next partial products
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg2 <= 8'b0;
            mul_b_reg2 <= 8'b0;
            partial_sum_stage2 <= 16'b0;
        end else if (mul_en_out_reg[0]) begin
            mul_a_reg2 <= mul_a_reg1;
            mul_b_reg2 <= mul_b_reg1;

            // Generate next partial products in Stage 2
            partial_sum_stage2 <= partial_sum_stage1 + (mul_a_reg1 * mul_b_reg1[7:4] << 4); // Upper 4 bits of mul_b
        end
    end

    // Stage 3: Compute final product
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg <= 16'b0;
        end else if (mul_en_out_reg[1]) begin
            mul_out_reg <= partial_sum_stage2;
        end
    end

    // Assign output product
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 16'b0;
        end else if (mul_en_out) begin
            mul_out <= mul_out_reg;
        end else begin
            mul_out <= 16'b0;
        end
    end

endmodule
