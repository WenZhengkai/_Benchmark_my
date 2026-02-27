module dut (
    input wire clk,               // Clock signal
    input wire rst_n,             // Active-low reset signal
    input wire mul_en_in,         // Input enable signal
    input wire [7:0] mul_a,       // Multiplicand (8 bits)
    input wire [7:0] mul_b,       // Multiplier (8 bits)
    output reg mul_en_out,        // Output enable signal
    output reg [15:0] mul_out     // Product output (16 bits)
);

    // Register declarations for input control and pipeline registers
    reg mul_en_in_reg [1:0];      // Pipeline stages for enable signal
    reg [7:0] mul_a_reg;          // Register to hold the multiplicand
    reg [7:0] mul_b_reg;          // Register to hold the multiplier
    reg [15:0] partial_sum [7:0]; // Partial sums for pipeline stages

    integer i; // Loop variable for initialization

    // Reset all pipeline registers on reset (active-low)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_in_reg[0] <= 0;
            mul_en_in_reg[1] <= 0;
            mul_en_out <= 0;
            mul_a_reg <= 0;
            mul_b_reg <= 0;
            for (i = 0; i < 8; i = i + 1)
                partial_sum[i] <= 0;
            mul_out <= 0;
        end else begin
            // Pipeline the enable signal
            mul_en_in_reg[0] <= mul_en_in;
            mul_en_in_reg[1] <= mul_en_in_reg[0];
            mul_en_out <= mul_en_in_reg[1];

            // Update input registers when enable is active
            if (mul_en_in) begin
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
            end

            // Generate partial products and calculate partial sums
            partial_sum[0] <= (mul_b_reg[0] ? {8'b0, mul_a_reg} : 16'b0);
            partial_sum[1] <= partial_sum[0] + (mul_b_reg[1] ? {7'b0, mul_a_reg, 1'b0} : 16'b0);
            partial_sum[2] <= partial_sum[1] + (mul_b_reg[2] ? {6'b0, mul_a_reg, 2'b0} : 16'b0);
            partial_sum[3] <= partial_sum[2] + (mul_b_reg[3] ? {5'b0, mul_a_reg, 3'b0} : 16'b0);
            partial_sum[4] <= partial_sum[3] + (mul_b_reg[4] ? {4'b0, mul_a_reg, 4'b0} : 16'b0);
            partial_sum[5] <= partial_sum[4] + (mul_b_reg[5] ? {3'b0, mul_a_reg, 5'b0} : 16'b0);
            partial_sum[6] <= partial_sum[5] + (mul_b_reg[6] ? {2'b0, mul_a_reg, 6'b0} : 16'b0);
            partial_sum[7] <= partial_sum[6] + (mul_b_reg[7] ? {1'b0, mul_a_reg, 7'b0} : 16'b0);
            
            // Update final output product
            mul_out <= partial_sum[7];
        end
    end

endmodule
