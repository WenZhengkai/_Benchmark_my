module adder_pipe_64bit (
    input wire clk,
    input wire rst_n,
    input wire i_en,
    input wire [63:0] adda,
    input wire [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

    reg [15:0] p1_a, p1_b, p2_a, p2_b, p3_a, p3_b, p4_a, p4_b;
    reg [15:0] p1_sum, p2_sum, p3_sum, p4_sum;
    reg p1_carry, p2_carry, p3_carry, p4_carry;
    reg en_stage1, en_stage2, en_stage3, en_stage4;

    // Stage 1: Process bits [15:0]
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p1_a <= 16'b0;
            p1_b <= 16'b0;
            p1_sum <= 16'b0;
            p1_carry <= 1'b0;
            en_stage1 <= 1'b0;
        end else begin
            p1_a <= adda[15:0];
            p1_b <= addb[15:0];
            {p1_carry, p1_sum} <= p1_a + p1_b;
            en_stage1 <= i_en;
        end
    end

    // Stage 2: Process bits [31:16]
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p2_a <= 16'b0;
            p2_b <= 16'b0;
            p2_sum <= 16'b0;
            p2_carry <= 1'b0;
            en_stage2 <= 1'b0;
        end else begin
            p2_a <= adda[31:16];
            p2_b <= addb[31:16];
            {p2_carry, p2_sum} <= p2_a + p2_b + p1_carry;
            en_stage2 <= en_stage1;
        end
    end

    // Stage 3: Process bits [47:32]
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p3_a <= 16'b0;
            p3_b <= 16'b0;
            p3_sum <= 16'b0;
            p3_carry <= 1'b0;
            en_stage3 <= 1'b0;
        end else begin
            p3_a <= adda[47:32];
            p3_b <= addb[47:32];
            {p3_carry, p3_sum} <= p3_a + p3_b + p2_carry;
            en_stage3 <= en_stage2;
        end
    end

    // Stage 4: Process bits [63:48]
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p4_a <= 16'b0;
            p4_b <= 16'b0;
            p4_sum <= 16'b0;
            p4_carry <= 1'b0;
            en_stage4 <= 1'b0;
            result <= 65'b0;
            o_en <= 1'b0;
        end else begin
            p4_a <= adda[63:48];
            p4_b <= addb[63:48];
            {p4_carry, p4_sum} <= p4_a + p4_b + p3_carry;
            en_stage4 <= en_stage3;

            if (en_stage4) begin
                result <= {p4_carry, p4_sum, p3_sum, p2_sum, p1_sum};
                o_en <= 1'b1;
            end else begin
                o_en <= 1'b0;
            end
        end
    end

endmodule
