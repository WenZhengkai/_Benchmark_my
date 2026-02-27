module dut (
    input wire clk,              // Clock signal
    input wire rst_n,            // Active-low reset signal
    input wire mul_en_in,        // Input enable signal
    input wire [7:0] mul_a,      // Multiplicand input
    input wire [7:0] mul_b,      // Multiplier input
    output wire mul_en_out,      // Output enable signal
    output wire [15:0] mul_out   // Product output
);

    // Internal registers for pipeline stages
    reg mul_en_stage1;
    reg mul_en_stage2;
    reg mul_en_stage3;
    reg [7:0] mul_a_reg;         // Register to store multiplicand
    reg [7:0] mul_b_reg;         // Register to store multiplier
    reg [15:0] partial_product [7:0]; // Partial products
    reg [15:0] sum_stage1;       // Partial sum after 1st stage
    reg [15:0] sum_stage2;       // Accumulated sum after 2nd stage
    reg [15:0] mul_out_reg;      // Final product register
    
    // Pipeline Stage 1: Latch inputs and calculate partial products
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            partial_product[0] <= 16'b0;
            partial_product[1] <= 16'b0;
            partial_product[2] <= 16'b0;
            partial_product[3] <= 16'b0;
            partial_product[4] <= 16'b0;
            partial_product[5] <= 16'b0;
            partial_product[6] <= 16'b0;
            partial_product[7] <= 16'b0;
            mul_en_stage1 <= 1'b0;
        end else if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;

            // Generate partial products by multiplying multiplicand
            // with individual bits of the multiplier
            partial_product[0] <= mul_b[0] ? {8'b0, mul_a} : 16'b0;
            partial_product[1] <= mul_b[1] ? ({7'b0, mul_a, 1'b0}) : 16'b0;
            partial_product[2] <= mul_b[2] ? ({6'b0, mul_a, 2'b0}) : 16'b0;
            partial_product[3] <= mul_b[3] ? ({5'b0, mul_a, 3'b0}) : 16'b0;
            partial_product[4] <= mul_b[4] ? ({4'b0, mul_a, 4'b0}) : 16'b0;
            partial_product[5] <= mul_b[5] ? ({3'b0, mul_a, 5'b0}) : 16'b0;
            partial_product[6] <= mul_b[6] ? ({2'b0, mul_a, 6'b0}) : 16'b0;
            partial_product[7] <= mul_b[7] ? ({1'b0, mul_a, 7'b0}) : 16'b0;

            mul_en_stage1 <= mul_en_in;
        end
    end

    // Pipeline Stage 2: Add partial products to form partial sum
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum_stage1 <= 16'b0;
            mul_en_stage2 <= 1'b0;
        end else if (mul_en_stage1) begin
            sum_stage1 <= partial_product[0] + partial_product[1] +
                          partial_product[2] + partial_product[3] +
                          partial_product[4] + partial_product[5] +
                          partial_product[6] + partial_product[7];
            mul_en_stage2 <= mul_en_stage1;
        end
    end

    // Pipeline Stage 3: Finalize product calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg <= 16'b0;
            mul_en_stage3 <= 1'b0;
        end else if (mul_en_stage2) begin
            mul_out_reg <= sum_stage1;
            mul_en_stage3 <= mul_en_stage2;
        end
    end

    // Output assignment
    assign mul_out = mul_out_reg;
    assign mul_en_out = mul_en_stage3;

endmodule
