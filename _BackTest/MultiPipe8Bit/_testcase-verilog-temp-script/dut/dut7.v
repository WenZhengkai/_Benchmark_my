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
    
    // Partial product generation wires
    wire [15:0] pp [7:0];
    
    // Pipeline stages for partial sums
    reg [15:0] sum_stage1 [3:0];
    reg [15:0] sum_stage2 [1:0];
    reg [15:0] sum_stage3;
    
    // Final product register
    reg [15:0] mul_out_reg;
    
    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : PARTIAL_PRODUCTS
            assign pp[i] = mul_b_reg[i] ? ({8'b0, mul_a_reg} << i) : 16'b0;
        end
    endgenerate
    
    // Pipeline the enable signal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out_reg <= 3'b0;
        end else begin
            mul_en_out_reg <= {mul_en_out_reg[1:0], mul_en_in};
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
    
    // Stage 1: First level of addition (4 additions)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum_stage1[0] <= 16'b0;
            sum_stage1[1] <= 16'b0;
            sum_stage1[2] <= 16'b0;
            sum_stage1[3] <= 16'b0;
        end else if (mul_en_out_reg[0]) begin
            sum_stage1[0] <= pp[0] + pp[1];
            sum_stage1[1] <= pp[2] + pp[3];
            sum_stage1[2] <= pp[4] + pp[5];
            sum_stage1[3] <= pp[6] + pp[7];
        end
    end
    
    // Stage 2: Second level of addition (2 additions)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum_stage2[0] <= 16'b0;
            sum_stage2[1] <= 16'b0;
        end else if (mul_en_out_reg[1]) begin
            sum_stage2[0] <= sum_stage1[0] + sum_stage1[1];
            sum_stage2[1] <= sum_stage1[2] + sum_stage1[3];
        end
    end
    
    // Stage 3: Final addition
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum_stage3 <= 16'b0;
        end else if (mul_en_out_reg[2]) begin
            sum_stage3 <= sum_stage2[0] + sum_stage2[1];
        end
    end
    
    // Output register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out_reg <= 16'b0;
        end else if (mul_en_out_reg[2]) begin
            mul_out_reg <= sum_stage3;
        end
    end
    
    // Output assignments
    assign mul_en_out = mul_en_out_reg[2];
    assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

endmodule