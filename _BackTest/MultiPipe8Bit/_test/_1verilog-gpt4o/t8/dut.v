module dut (
    input wire clk,                // Clock signal
    input wire rst_n,              // Active-low reset signal
    input wire mul_en_in,          // Input enable signal
    input wire [7:0] mul_a,        // Multiplicand (8 bits)
    input wire [7:0] mul_b,        // Multiplier (8 bits)
    output reg mul_en_out,         // Output enable signal
    output reg [15:0] mul_out      // Product output (16 bits)
);

    // Define pipeline registers for enable signal
    reg mul_en_reg1, mul_en_reg2, mul_en_reg3;

    // Define pipeline registers for inputs
    reg [7:0] mul_a_reg1, mul_a_reg2;
    reg [7:0] mul_b_reg1, mul_b_reg2;

    // Define pipeline registers for partial products and sums
    reg [15:0] partial_sum_stage1, partial_sum_stage2;

    // Combinational wires for partial product generation
    wire [15:0] temp_0 = mul_a_reg1 * {8'd0, mul_b_reg1[3:0]};
    wire [15:0] temp_1 = mul_a_reg2 * {8'd0, mul_b_reg2[7:4]} << 4;

    // Sequential logic to implement pipelining
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            mul_en_reg1 <= 1'b0;
            mul_en_reg2 <= 1'b0;
            mul_en_reg3 <= 1'b0;
            mul_a_reg1 <= 8'b0;
            mul_a_reg2 <= 8'b0;
            mul_b_reg1 <= 8'b0;
            mul_b_reg2 <= 8'b0;
            partial_sum_stage1 <= 16'b0;
            partial_sum_stage2 <= 16'b0;
            mul_out <= 16'b0;
            mul_en_out <= 1'b0;
        end else begin
            // Stage 1: Latch inputs and enable signal
            mul_en_reg1 <= mul_en_in;
            mul_a_reg1 <= mul_a;
            mul_b_reg1 <= mul_b;

            // Stage 2: Generate partial sum based on low 4 bits of multiplier
            mul_en_reg2 <= mul_en_reg1;
            mul_a_reg2 <= mul_a_reg1;
            mul_b_reg2 <= mul_b_reg1;
            partial_sum_stage1 <= temp_0;

            // Stage 3: Generate partial sum based on high 4 bits of multiplier
            mul_en_reg3 <= mul_en_reg2;
            partial_sum_stage2 <= partial_sum_stage1 + temp_1;

            // Stage 4: Finalize the output product
            mul_out <= partial_sum_stage2;
            mul_en_out <= mul_en_reg3;
        end
    end

endmodule