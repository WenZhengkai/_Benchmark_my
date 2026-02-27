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
    wire [15:0] temp [7:0];
    
    // Partial sum registers
    reg [15:0] sum [3:0];
    
    // Final product register
    reg [15:0] mul_out_reg;
    
    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : PARTIAL_PRODUCTS
            assign temp[i] = mul_b_reg[i] ? (mul_a_reg << i) : 16'b0;
        end
    endgenerate
    
    // Pipeline processing
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            mul_en_out_reg <= 3'b0;
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            sum[0] <= 16'b0;
            sum[1] <= 16'b0;
            sum[2] <= 16'b0;
            sum[3] <= 16'b0;
            mul_out_reg <= 16'b0;
        end
        else begin
            // Pipeline stage 1: Input sampling
            mul_en_out_reg[0] <= mul_en_in;
            if (mul_en_in) begin
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
            end
            
            // Pipeline stage 2: First level of partial sums (4 additions)
            mul_en_out_reg[1] <= mul_en_out_reg[0];
            sum[0] <= temp[0] + temp[1];
            sum[1] <= temp[2] + temp[3];
            sum[2] <= temp[4] + temp[5];
            sum[3] <= temp[6] + temp[7];
            
            // Pipeline stage 3: Second level of partial sums (2 additions)
            mul_en_out_reg[2] <= mul_en_out_reg[1];
            sum[0] <= sum[0] + sum[1];
            sum[1] <= sum[2] + sum[3];
            
            // Pipeline stage 4: Final sum
            mul_en_out_reg[2] <= mul_en_out_reg[1];
            mul_out_reg <= sum[0] + sum[1];
        end
    end
    
    // Output assignments
    assign mul_en_out = mul_en_out_reg[2];
    assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

endmodule