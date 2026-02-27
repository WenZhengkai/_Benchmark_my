module dut (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output wire mul_en_out,
    output wire [15:0] mul_out
);

    // Pipeline registers for enable signal
    reg [2:0] mul_en_out_reg;

    // Input registers
    reg [7:0] mul_a_reg;
    reg [7:0] mul_b_reg;

    // Partial products
    wire [15:0] partial_products [7:0];

    // Pipeline stages for partial sums
    reg [15:0] stage1_sum;
    reg [15:0] stage2_sum;
    reg [15:0] stage3_sum;

    // Final product register
    reg [15:0] mul_out_reg;

    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : pp_gen
            assign partial_products[i] = mul_b_reg[i] ? (mul_a_reg << i) : 16'b0;
        end
    endgenerate

    // Pipeline processing
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            mul_en_out_reg <= 3'b0;
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            stage1_sum <= 16'b0;
            stage2_sum <= 16'b0;
            stage3_sum <= 16'b0;
            mul_out_reg <= 16'b0;
        end else begin
            // Pipeline stage 0: Input sampling
            mul_en_out_reg <= {mul_en_out_reg[1:0], mul_en_in};
            if (mul_en_in) begin
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
            end

            // Pipeline stage 1: First level of addition
            stage1_sum <= partial_products[0] + partial_products[1] + 
                         partial_products[2] + partial_products[3];

            // Pipeline stage 2: Second level of addition
            stage2_sum <= stage1_sum + partial_products[4] + 
                         partial_products[5] + partial_products[6];

            // Pipeline stage 3: Final addition
            stage3_sum <= stage2_sum + partial_products[7];

            // Pipeline stage 4: Output register
            mul_out_reg <= stage3_sum;
        end
    end

    // Output assignments
    assign mul_en_out = mul_en_out_reg[2];  // Enable signal is delayed by 4 cycles
    assign mul_out = mul_en_out_reg[2] ? mul_out_reg : 16'b0;

endmodule