module adder_pipe_64bit (
    input             clk,
    input             rst_n,
    input             i_en,
    input  [63:0]     adda,
    input  [63:0]     addb,
    output [64:0]     result,
    output            o_en
);
    reg [16:0] stage1_sum, stage2_sum, stage3_sum, stage4_sum;
    reg        carry1, carry2, carry3, carry4;
    reg        en_stage1, en_stage2, en_stage3, en_stage4;

    // Stage 1: Add lowest 16 bits
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage1_sum <= 17'd0;
            carry1     <= 1'b0;
            en_stage1  <= 1'b0;
        end else if (i_en) begin
            {carry1, stage1_sum} <= {1'b0, adda[15:0]} + {1'b0, addb[15:0]};
            en_stage1            <= 1'b1;
        end else begin
            en_stage1 <= 1'b0;
        end
    end

    // Stage 2: Add next 16 bits
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage2_sum <= 17'd0;
            carry2     <= 1'b0;
            en_stage2  <= 1'b0;
        end else if (en_stage1) begin
            {carry2, stage2_sum} <= {1'b0, adda[31:16]} + {1'b0, addb[31:16]} + carry1;
            en_stage2            <= 1'b1;
        end else begin
            en_stage2 <= 1'b0;
        end
    end

    // Stage 3: Add next 16 bits
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage3_sum <= 17'd0;
            carry3     <= 1'b0;
            en_stage3  <= 1'b0;
        end else if (en_stage2) begin
            {carry3, stage3_sum} <= {1'b0, adda[47:32]} + {1'b0, addb[47:32]} + carry2;
            en_stage3            <= 1'b1;
        end else begin
            en_stage3 <= 1'b0;
        end
    end

    // Stage 4: Add highest 16 bits
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage4_sum <= 17'd0;
            carry4     <= 1'b0;
            en_stage4  <= 1'b0;
        end else if (en_stage3) begin
            {carry4, stage4_sum} <= {1'b0, adda[63:48]} + {1'b0, addb[63:48]} + carry3;
            en_stage4            <= 1'b1;
        end else begin
            en_stage4 <= 1'b0;
        end
    end

    // Output result and enable signal
    assign result = {carry4, stage4_sum[15:0], stage3_sum[15:0], stage2_sum[15:0], stage1_sum[15:0]};
    assign o_en   = en_stage4;

endmodule
