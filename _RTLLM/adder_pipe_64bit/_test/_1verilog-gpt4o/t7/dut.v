module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

    // Pipeline registers for inputs and intermediate sums
    reg [64:0] stage1_sum, stage2_sum, stage3_sum;
    reg stage1_en, stage2_en, stage3_en, stage4_en;
    reg stage1_carry, stage2_carry, stage3_carry;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            // Reset all pipeline registers
            stage1_sum <= 65'b0;
            stage2_sum <= 65'b0;
            stage3_sum <= 65'b0;
            result <= 65'b0;

            stage1_en <= 1'b0;
            stage2_en <= 1'b0;
            stage3_en <= 1'b0;
            o_en <= 1'b0;

            stage1_carry <= 1'b0;
            stage2_carry <= 1'b0;
            stage3_carry <= 1'b0;
        end else begin
            // Stage 1: Compute 16-bit sum and carry
            {stage1_carry, stage1_sum[15:0]} <= {1'b0, adda[15:0]} + {1'b0, addb[15:0]};
            stage1_sum[64:16] <= 49'b0;  // Clear higher bits
            stage1_en <= i_en;

            // Stage 2: Compute 16-bit sum and carry with previous carry-in
            {stage2_carry, stage2_sum[31:16]} <= {1'b0, adda[31:16]} + {1'b0, addb[31:16]} + stage1_carry;
            stage2_sum[15:0] <= stage1_sum[15:0];
            stage2_sum[64:32] <= 33'b0;  // Clear higher bits
            stage2_en <= stage1_en;

            // Stage 3: Compute 16-bit sum and carry with previous carry-in
            {stage3_carry, stage3_sum[47:32]} <= {1'b0, adda[47:32]} + {1'b0, addb[47:32]} + stage2_carry;
            stage3_sum[31:0] <= stage2_sum[31:0];
            stage3_sum[64:48] <= 17'b0;  // Clear higher bits
            stage3_en <= stage2_en;

            // Stage 4: Compute final 16-bit sum and carry with previous carry-in
            {stage3_sum[64], stage3_sum[63:48]} <= {1'b0, adda[63:48]} + {1'b0, addb[63:48]} + stage3_carry;
            if (stage3_en) begin
                result <= stage3_sum;
            end
            o_en <= stage3_en;
        end
    end

endmodule
