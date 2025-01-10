module adder_pipe_64bit(
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

    reg [15:0] part_a_0, part_a_1, part_a_2, part_a_3;
    reg [15:0] part_b_0, part_b_1, part_b_2, part_b_3;
    reg [16:0] sum_0, sum_1, sum_2, sum_3;
    reg carry_0, carry_1, carry_2;
    reg [3:0] en_pipeline;  // Used to track enabled stages

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            part_a_0 <= 16'b0;
            part_a_1 <= 16'b0;
            part_a_2 <= 16'b0;
            part_a_3 <= 16'b0;
            part_b_0 <= 16'b0;
            part_b_1 <= 16'b0;
            part_b_2 <= 16'b0;
            part_b_3 <= 16'b0;
            sum_0 <= 17'b0;
            sum_1 <= 17'b0;
            sum_2 <= 17'b0;
            sum_3 <= 17'b0;
            carry_0 <= 1'b0;
            carry_1 <= 1'b0;
            carry_2 <= 1'b0;
            result <= 65'b0;
            o_en <= 1'b0;
            en_pipeline <= 4'b0;
        end else begin
            // Stage 0: Load inputs
            if (i_en) begin
                part_a_0 <= adda[15:0];
                part_b_0 <= addb[15:0];
                part_a_1 <= adda[31:16];
                part_b_1 <= addb[31:16];
                part_a_2 <= adda[47:32];
                part_b_2 <= addb[47:32];
                part_a_3 <= adda[63:48];
                part_b_3 <= addb[63:48];
                en_pipeline[0] <= 1'b1;
            end

            // Stage 1: Calculate first 16-bit sum and carry
            if (en_pipeline[0]) begin
                sum_0 <= part_a_0 + part_b_0;
                carry_0 <= (part_a_0 + part_b_0) > 16'hFFFF;
                en_pipeline[1] <= 1'b1;
            end else begin
                en_pipeline[1] <= 1'b0;
            end

            // Stage 2: Calculate second 16-bit sum with carry
            if (en_pipeline[1]) begin
                sum_1 <= part_a_1 + part_b_1 + carry_0;
                carry_1 <= (part_a_1 + part_b_1 + carry_0) > 16'hFFFF;
                en_pipeline[2] <= 1'b1;
            end else begin
                en_pipeline[2] <= 1'b0;
            end

            // Stage 3: Calculate third 16-bit sum with carry
            if (en_pipeline[2]) begin
                sum_2 <= part_a_2 + part_b_2 + carry_1;
                carry_2 <= (part_a_2 + part_b_2 + carry_1) > 16'hFFFF;
                en_pipeline[3] <= 1'b1;
            end else begin
                en_pipeline[3] <= 1'b0;
            end

            // Stage 4: Calculate fourth 16-bit sum with carry and final result update
            if (en_pipeline[3]) begin
                sum_3 <= part_a_3 + part_b_3 + carry_2;
                result <= {1'b0, sum_3, sum_2[15:0], sum_1[15:0], sum_0[15:0]};
                result[64] <= (part_a_3 + part_b_3 + carry_2) > 16'hFFFF; // Final carry out
                o_en <= 1'b1;
            end else begin
                o_en <= 1'b0;
            end
        end
    end
endmodule