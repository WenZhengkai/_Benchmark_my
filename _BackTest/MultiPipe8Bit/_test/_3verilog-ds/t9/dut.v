module dut (
    input               clk,
    input               rst_n,
    input               mul_en_in,
    input       [7:0]   mul_a,
    input       [7:0]   mul_b,
    output reg          mul_en_out,
    output reg  [15:0]  mul_out
);

    // Pipeline registers
    reg         [7:0]   mul_a_reg;
    reg         [7:0]   mul_b_reg;
    reg         [1:0]   mul_en_pipeline;
    
    // Partial products
    wire        [15:0]  partial_products [7:0];
    
    // Pipeline stages for partial sums
    reg         [15:0]  stage1_sum;
    reg         [15:0]  stage2_sum;
    reg         [15:0]  stage3_sum;
    
    // Final product register
    reg         [15:0]  mul_out_reg;

    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : pp_gen
            assign partial_products[i] = mul_b_reg[i] ? (mul_a_reg << i) : 16'b0;
        end
    endgenerate

    // Pipeline enable signal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_pipeline <= 2'b00;
        end else begin
            mul_en_pipeline <= {mul_en_pipeline[0], mul_en_in};
        end
    end

    // Input registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
        end else if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end
    end

    // Pipeline stage 1: Sum first level of partial products
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage1_sum <= 16'b0;
        end else if (mul_en_pipeline[0]) begin
            stage1_sum <= partial_products[0] + partial_products[1] + 
                          partial_products[2] + partial_products[3];
        end
    end

    // Pipeline stage 2: Sum second level of partial products
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage2_sum <= 16'b0;
        end else if (mul_en_pipeline[0]) begin
            stage2_sum <= partial_products[4] + partial_products[5] + 
                          partial_products[6] + partial_products[7];
        end
    end

    // Pipeline stage 3: Sum intermediate results
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            stage3_sum <= 16'b0;
        end else if (mul_en_pipeline[1]) begin
            stage3_sum <= stage1_sum + stage2_sum;
        end
    end

    // Final output register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg <= 16'b0;
        end else if (mul_en_pipeline[1]) begin
            mul_out_reg <= stage3_sum;
        end
    end

    // Output assignments
    always @(*) begin
        mul_en_out = mul_en_pipeline[1];
        mul_out = mul_en_out ? mul_out_reg : 16'b0;
    end

endmodule