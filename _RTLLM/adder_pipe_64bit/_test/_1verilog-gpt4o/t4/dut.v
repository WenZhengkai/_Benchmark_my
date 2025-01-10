module adder_pipe_64bit(
    input wire clk,
    input wire rst_n,
    input wire i_en,
    input wire [63:0] adda,
    input wire [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

    // Intermediate pipeline registers for operands, sum bits and carry
    reg [15:0] p_add_a [3:0];
    reg [15:0] p_add_b [3:0];
    reg [3:0] p_en;
    reg [4:0] carries;  // Additional bit for carry out
    reg [15:0] sum [3:0];  // Partial sums

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all pipeline registers
            result <= 65'd0;
            o_en <= 1'b0;
            for (i = 0; i < 4; i = i + 1) begin
                p_add_a[i] <= 16'd0;
                p_add_b[i] <= 16'd0;
                sum[i] <= 16'd0;
                p_en[i] <= 1'b0;
                carries[i] <= 1'b0;
            end
            carries[4] <= 1'b0;
        end else begin
            // Pipeline stage 1
            p_add_a[0] <= adda[15:0];
            p_add_b[0] <= addb[15:0];
            p_en[0] <= i_en;

            // Pipeline processing
            for (i = 0; i < 3; i = i + 1) begin
                if (p_en[i]) begin
                    {carries[i+1], sum[i]} <= p_add_a[i] + p_add_b[i] + carries[i];
                end

                // Move to next stage
                p_add_a[i+1] <= adda[16*i+31:16*i+16];
                p_add_b[i+1] <= addb[16*i+31:16*i+16];
                p_en[i+1] <= p_en[i];
            end

            // Final pipeline stage
            if (p_en[3]) begin
                {carries[4], sum[3]} <= p_add_a[3] + p_add_b[3] + carries[3];
            end

            // Output result and enable signal
            if (p_en[3]) begin
                result <= {carries[4], sum[3], sum[2], sum[1], sum[0]};
                o_en <= 1'b1;
            end else begin
                o_en <= 1'b0;
            end
        end
    end

endmodule
