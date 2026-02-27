
module dut (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

    // Input enable signal pipelining
    reg [2:0] mul_en_out_reg;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            mul_en_out_reg <= 3'b000;
        else
            mul_en_out_reg <= {mul_en_out_reg[1:0], mul_en_in};
    end
    assign mul_en_out = mul_en_out_reg[2];

    // Input registers for multiplicand and multiplier
    reg [7:0] mul_a_reg [0:2]; // Pipeline for mul_a
    reg [7:0] mul_b_reg [0:2]; // Pipeline for mul_b

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg[0] <= 8'b0;
            mul_b_reg[0] <= 8'b0;
            mul_a_reg[1] <= 8'b0;
            mul_b_reg[1] <= 8'b0;
            mul_a_reg[2] <= 8'b0;
            mul_b_reg[2] <= 8'b0;
        end else if (mul_en_in) begin
            mul_a_reg[0] <= mul_a;
            mul_b_reg[0] <= mul_b;
            mul_a_reg[1] <= mul_a_reg[0];
            mul_b_reg[1] <= mul_b_reg[0];
            mul_a_reg[2] <= mul_a_reg[1];
            mul_b_reg[2] <= mul_b_reg[1];
        end
    end

    // Partial products
    wire [15:0] temp [7:0];
    assign temp[0] = mul_b_reg[2][0] ? {8'b0, mul_a_reg[2]} : 16'b0;
    assign temp[1] = mul_b_reg[2][1] ? {7'b0, mul_a_reg[2], 1'b0} : 16'b0;
    assign temp[2] = mul_b_reg[2][2] ? {6'b0, mul_a_reg[2], 2'b0} : 16'b0;
    assign temp[3] = mul_b_reg[2][3] ? {5'b0, mul_a_reg[2], 3'b0} : 16'b0;
    assign temp[4] = mul_b_reg[2][4] ? {4'b0, mul_a_reg[2], 4'b0} : 16'b0;
    assign temp[5] = mul_b_reg[2][5] ? {3'b0, mul_a_reg[2], 5'b0} : 16'b0;
    assign temp[6] = mul_b_reg[2][6] ? {2'b0, mul_a_reg[2], 6'b0} : 16'b0;
    assign temp[7] = mul_b_reg[2][7] ? {1'b0, mul_a_reg[2], 7'b0} : 16'b0;

    // Partial sum calculation (pipelining)
    reg [15:0] sum1, sum2, sum3;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum1 <= 16'b0;
            sum2 <= 16'b0;
            sum3 <= 16'b0;
        end else begin
            sum1 <= temp[0] + temp[1] + temp[2] + temp[3];
            sum2 <= temp[4] + temp[5] + temp[6] + temp[7];
            sum3 <= sum1 + sum2;
        end
    end

    // Final product calculation
    reg [15:0] mul_out_reg;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            mul_out_reg <= 16'b0;
        else if (mul_en_out_reg[2])
            mul_out_reg <= sum3;
        else
            mul_out_reg <= 16'b0;
    end

    // Assign output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            mul_out <= 16'b0;
        else if (mul_en_out)
            mul_out <= mul_out_reg;
        else
            mul_out <= 16'b0;
    end

endmodule
