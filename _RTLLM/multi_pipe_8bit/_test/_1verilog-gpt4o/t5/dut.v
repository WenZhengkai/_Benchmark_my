module multi_pipe_8bit (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

    // Pipeline stages
    reg [7:0] a_reg_stage1, b_reg_stage1;
    reg [15:0] partial_sum_stage2;
    reg en_reg_stage1, en_reg_stage2;

    // Partial products
    reg [15:0] temp [7:0];

    // Partial sums
    reg [15:0] sum_stage1, sum_final;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all pipeline stages and outputs
            mul_en_out <= 0;
            a_reg_stage1 <= 0;
            b_reg_stage1 <= 0;
            partial_sum_stage2 <= 0;
            mul_out <= 0;
            en_reg_stage1 <= 0;
            en_reg_stage2 <= 0;
        end else begin
            // Stage 1: Register inputs
            en_reg_stage1 <= mul_en_in;
            if (mul_en_in) begin
                a_reg_stage1 <= mul_a;
                b_reg_stage1 <= mul_b;

                // Generate partial products
                temp[0] <= b_reg_stage1[0] ? {8'b0, a_reg_stage1} : 16'b0;
                temp[1] <= b_reg_stage1[1] ? {7'b0, a_reg_stage1, 1'b0} : 16'b0;
                temp[2] <= b_reg_stage1[2] ? {6'b0, a_reg_stage1, 2'b0} : 16'b0;
                temp[3] <= b_reg_stage1[3] ? {5'b0, a_reg_stage1, 3'b0} : 16'b0;
                temp[4] <= b_reg_stage1[4] ? {4'b0, a_reg_stage1, 4'b0} : 16'b0;
                temp[5] <= b_reg_stage1[5] ? {3'b0, a_reg_stage1, 5'b0} : 16'b0;
                temp[6] <= b_reg_stage1[6] ? {2'b0, a_reg_stage1, 6'b0} : 16'b0;
                temp[7] <= b_reg_stage1[7] ? {1'b0, a_reg_stage1, 7'b0} : 16'b0;

                // Calculate partial sum for next stage
                sum_stage1 <= temp[0] + temp[1] + temp[2] + temp[3];
            end

            // Stage 2: Calculate final sum
            en_reg_stage2 <= en_reg_stage1;
            if (en_reg_stage1) begin
                partial_sum_stage2 <= temp[4] + temp[5] + temp[6] + temp[7];
                // Accumulate to form the final sum
                sum_final <= sum_stage1 + partial_sum_stage2;
            end

            // Stage 3: Produce final output
            if (en_reg_stage2) begin
                mul_en_out <= 1;
                mul_out <= sum_final;
            end else begin
                mul_en_out <= 0;
                mul_out <= 0;
            end
        end
    end

endmodule
