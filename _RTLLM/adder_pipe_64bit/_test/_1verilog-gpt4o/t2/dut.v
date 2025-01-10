module adder_pipe_64bit (
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

    // Pipeline registers
    reg [15:0] part_a[3:0];
    reg [15:0] part_b[3:0];
    reg [16:0] part_sum[1:0][3:0];
    reg carry[1:0][3:0];
    reg en_stage[3:0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers and output
            part_a[0] <= 16'b0;
            part_a[1] <= 16'b0;
            part_a[2] <= 16'b0;
            part_a[3] <= 16'b0;
            part_b[0] <= 16'b0;
            part_b[1] <= 16'b0;
            part_b[2] <= 16'b0;
            part_b[3] <= 16'b0;
            part_sum[0][0] <= 17'b0;
            part_sum[0][1] <= 17'b0;
            part_sum[0][2] <= 17'b0;
            part_sum[0][3] <= 17'b0;
            part_sum[1][0] <= 17'b0;
            part_sum[1][1] <= 17'b0;
            part_sum[1][2] <= 17'b0;
            part_sum[1][3] <= 17'b0;
            carry[0][0] <= 1'b0;
            carry[0][1] <= 1'b0;
            carry[0][2] <= 1'b0;
            carry[0][3] <= 1'b0;
            carry[1][0] <= 1'b0;
            carry[1][1] <= 1'b0;
            carry[1][2] <= 1'b0;
            carry[1][3] <= 1'b0;
            en_stage[0] <= 1'b0;
            en_stage[1] <= 1'b0;
            en_stage[2] <= 1'b0;
            en_stage[3] <= 1'b0;
            o_en <= 1'b0;
            result <= 65'b0;
        end else if (i_en) begin
            // Stage 0: Divide the inputs into parts
            part_a[0] <= adda[15:0];
            part_a[1] <= adda[31:16];
            part_a[2] <= adda[47:32];
            part_a[3] <= adda[63:48];
            part_b[0] <= addb[15:0];
            part_b[1] <= addb[31:16];
            part_b[2] <= addb[47:32];
            part_b[3] <= addb[63:48];
            en_stage[0] <= i_en;

            // Stage 1: Compute the first 16 bits sum and carry
            if (en_stage[0]) begin
                {carry[0][0], part_sum[0][0]} <= part_a[0] + part_b[0];
                en_stage[1] <= en_stage[0];
            end

            // Stage 2: Compute the next 16 bits sum and propagate carry
            if (en_stage[1]) begin
                {carry[0][1], part_sum[0][1]} <= part_a[1] + part_b[1] + carry[0][0];
                en_stage[2] <= en_stage[1];
            end

            // Stage 3: Compute the next 16 bits sum and propagate carry
            if (en_stage[2]) begin
                {carry[0][2], part_sum[0][2]} <= part_a[2] + part_b[2] + carry[0][1];
                en_stage[3] <= en_stage[2];
            end

            // Stage 4: Compute the last 16 bits sum and propagate carry
            if (en_stage[3]) begin
                {carry[0][3], part_sum[0][3]} <= part_a[3] + part_b[3] + carry[0][2];

                // Concatenate results and output
                result <= {carry[0][3], part_sum[0][3][15:0], part_sum[0][2][15:0],
                           part_sum[0][1][15:0], part_sum[0][0][15:0]};
                o_en <= en_stage[3];
                
                // Reset enable stage
                en_stage[3] <= 1'b0;
            end
        end else begin
            // Disable operation when i_en is low
            o_en <= 1'b0;
        end
    end

endmodule
