module multi_pipe_8bit (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

    // Intermediate registers to hold input values.
    reg [7:0] mul_a_reg;
    reg [7:0] mul_b_reg;
    reg mul_en_out_reg;

    // Partial products and sums
    wire [15:0] temp [0:7];
    reg  [15:0] sum [0:3];

    wire [15:0] partial_sum_0;
    wire [15:0] partial_sum_1;

    integer i;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            mul_en_out_reg <= 1'b0;
            mul_en_out <= 1'b0;
            mul_out <= 16'b0;
            
            for (i = 0; i < 4; i = i + 1) begin
                sum[i] <= 16'b0;
            end
        end else begin
            if (mul_en_in) begin
                // Storing multiplicand and multiplier in registers
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
                mul_en_out_reg <= mul_en_in;
            end
            
            // Processing pipeline
            // Partial Product Generation
            for (i = 0; i < 8; i = i + 1) begin
                temp[i] <= (mul_b_reg[i]) ? (mul_a_reg << i) : 16'b0;
            end

            // Partial Sum Calculation
            sum[0] <= temp[0] + temp[1];
            sum[1] <= temp[2] + temp[3];
            sum[2] <= temp[4] + temp[5];
            sum[3] <= temp[6] + temp[7];

            // Calculating final sum from partial sums
            partial_sum_0 <= sum[0] + sum[1];
            partial_sum_1 <= sum[2] + sum[3];

            // Final Product Calculation
            mul_out <= partial_sum_0 + partial_sum_1;

            // Output enable signal assignment
            mul_en_out <= mul_en_out_reg;
        end
    end

endmodule
