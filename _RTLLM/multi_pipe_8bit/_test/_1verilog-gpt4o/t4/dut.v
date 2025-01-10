module multi_pipe_8bit(
    input clk,
    input rst_n,
    input mul_en_in,
    input [7:0] mul_a,
    input [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

    reg [7:0] mul_a_reg, mul_b_reg;
    reg [15:0] partial_sum [0:7];
    reg [7:0] mul_en_out_reg;

    integer i;

    // On reset, initialize all registers.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            for (i = 0; i < 8; i = i + 1) begin
                partial_sum[i] <= 16'b0;
            end
            mul_en_out_reg <= 8'b0;
            mul_out <= 16'b0;
        end else begin
            // Input Control
            if (mul_en_in) begin
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
            end

            // Pipeline stages - Partial Product Generation and Addition
            partial_sum[0] <= (mul_b_reg[0] ? {8'b0, mul_a_reg} : 0);
            for (i = 1; i < 8; i = i + 1) begin
                partial_sum[i] <= partial_sum[i-1] + (mul_b_reg[i] ? {8'b0, mul_a_reg} << i : 0);
            end

            // Store enable signal state
            mul_en_out_reg <= {mul_en_out_reg[6:0], mul_en_in};
            
            // Update the output enable
            mul_en_out <= mul_en_out_reg[7];

            // Final Product Calculation
            if (mul_en_out_reg[7]) begin
                mul_out <= partial_sum[7];
            end else begin
                mul_out <= 16'b0;
            end
        end
    end

endmodule
