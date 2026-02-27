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
    reg [15:0] sum_stage1 [3:0];  // Stage 1: 4 sums
    reg [15:0] sum_stage2 [1:0];  // Stage 2: 2 sums
    reg [15:0] sum_stage3;        // Stage 3: final sum

    // Output register
    reg [15:0] mul_out_reg;

    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : PARTIAL_PROD
            assign partial_products[i] = mul_b_reg[i] ? ({8'b0, mul_a_reg} << i) : 16'b0;
        end
    endgenerate

    // Pipeline processing
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            mul_en_out_reg <= 3'b0;
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            
            for (integer j = 0; j < 4; j = j + 1) begin
                sum_stage1[j] <= 16'b0;
            end
            
            for (integer k = 0; k < 2; k = k + 1) begin
                sum_stage2[k] <= 16'b0;
            end
            
            sum_stage3 <= 16'b0;
            mul_out_reg <= 16'b0;
        end
        else begin
            // Pipeline the enable signal
            mul_en_out_reg <= {mul_en_out_reg[1:0], mul_en_in};
            
            // Sample inputs when enabled
            if (mul_en_in) begin
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
            end
            
            // Stage 1: First level of additions (4 additions)
            sum_stage1[0] <= partial_products[0] + partial_products[1];
            sum_stage1[1] <= partial_products[2] + partial_products[3];
            sum_stage1[2] <= partial_products[4] + partial_products[5];
            sum_stage1[3] <= partial_products[6] + partial_products[7];
            
            // Stage 2: Second level of additions (2 additions)
            sum_stage2[0] <= sum_stage1[0] + sum_stage1[1];
            sum_stage2[1] <= sum_stage1[2] + sum_stage1[3];
            
            // Stage 3: Final addition
            sum_stage3 <= sum_stage2[0] + sum_stage2[1];
            
            // Output register
            if (mul_en_out_reg[2]) begin
                mul_out_reg <= sum_stage3;
            end
            else begin
                mul_out_reg <= 16'b0;
            end
        end
    end

    // Output assignments
    assign mul_en_out = mul_en_out_reg[2];
    assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

endmodule