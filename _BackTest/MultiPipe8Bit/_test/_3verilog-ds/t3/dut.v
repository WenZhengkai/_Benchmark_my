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
    wire [15:0] pp [7:0];  // 8 partial products (each 16 bits)
    
    // Pipeline registers for partial sums
    reg [15:0] sum_stage1 [3:0];  // Stage 1: 4 sums
    reg [15:0] sum_stage2 [1:0];  // Stage 2: 2 sums
    reg [15:0] sum_stage3;        // Stage 3: final sum
    
    // Output register
    reg [15:0] mul_out_reg;
    
    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : pp_gen
            assign pp[i] = mul_b_reg[i] ? ({8'b0, mul_a_reg} << i) : 16'b0;
        end
    endgenerate
    
    // Pipeline processing
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            mul_en_out_reg <= 3'b0;
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            
            // Reset partial sums
            sum_stage1[0] <= 16'b0;
            sum_stage1[1] <= 16'b0;
            sum_stage1[2] <= 16'b0;
            sum_stage1[3] <= 16'b0;
            
            sum_stage2[0] <= 16'b0;
            sum_stage2[1] <= 16'b0;
            
            sum_stage3 <= 16'b0;
            
            mul_out_reg <= 16'b0;
        end else begin
            // Pipeline the enable signal
            mul_en_out_reg <= {mul_en_out_reg[1:0], mul_en_in};
            
            // Sample inputs when enabled
            if (mul_en_in) begin
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
            end
            
            // Stage 1: Sum pairs of partial products
            sum_stage1[0] <= pp[0] + pp[1];
            sum_stage1[1] <= pp[2] + pp[3];
            sum_stage1[2] <= pp[4] + pp[5];
            sum_stage1[3] <= pp[6] + pp[7];
            
            // Stage 2: Sum results from stage 1
            sum_stage2[0] <= sum_stage1[0] + sum_stage1[1];
            sum_stage2[1] <= sum_stage1[2] + sum_stage1[3];
            
            // Stage 3: Final sum
            sum_stage3 <= sum_stage2[0] + sum_stage2[1];
            
            // Output register
            mul_out_reg <= sum_stage3;
        end
    end
    
    // Output assignments
    assign mul_en_out = mul_en_out_reg[2];  // Output enable is delayed by 3 cycles
    assign mul_out = mul_en_out_reg[2] ? mul_out_reg : 16'b0;
    
endmodule