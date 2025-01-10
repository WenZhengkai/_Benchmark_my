module multi_pipe_8bit (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

    // Pipeline registers
    reg [7:0] mul_a_reg1, mul_b_reg1;
    reg [15:0] partial_sum_reg1, partial_sum_reg2;
    reg mul_en_reg1, mul_en_reg2;

    // Temporary wires for partial product computation
    wire [15:0] partial_product [0:7];

    // Compute partial products
    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin : pp_gen
            assign partial_product[i] = mul_b[i] ? (mul_a << i) : 16'b0;
        end
    endgenerate

    // Stage 1: Capture inputs and compute initial partial sum
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg1 <= 8'b0;
            mul_b_reg1 <= 8'b0;
            partial_sum_reg1 <= 16'b0;
            mul_en_reg1 <= 1'b0;
        end else if (mul_en_in) begin
            mul_a_reg1 <= mul_a;
            mul_b_reg1 <= mul_b;
            partial_sum_reg1 <= partial_product[0] + partial_product[1] +
                                partial_product[2] + partial_product[3]; // sum first 4 partial products
            mul_en_reg1 <= mul_en_in;
        end
    end

    // Stage 2: Compute additional partial sums
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            partial_sum_reg2 <= 16'b0;
            mul_en_reg2 <= 1'b0;
        end else if (mul_en_reg1) begin
            partial_sum_reg2 <= partial_product[4] + partial_product[5] +
                                partial_product[6] + partial_product[7] +
                                partial_sum_reg1; // add remaining 4
            mul_en_reg2 <= mul_en_reg1;
        end
    end

    // Stage 3: Final summation and output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 16'b0;
            mul_en_out <= 1'b0;
        end else begin
            mul_out <= mul_en_reg2 ? partial_sum_reg2 : 16'b0;
            mul_en_out <= mul_en_reg2;
        end
    end

endmodule
