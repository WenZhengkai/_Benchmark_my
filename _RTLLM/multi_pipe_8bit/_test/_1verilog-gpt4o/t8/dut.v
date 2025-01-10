module multi_pipe_8bit (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

    // Pipeline registers for multiplicand and multiplier
    reg [7:0] mul_a_reg;
    reg [7:0] mul_b_reg;
    
    // Intermediate registers for partial products and sums
    reg [7:0] pp [0:7]; // Partial products
    reg [15:0] sum [0:7]; // Partial sums

    // Enable register to track pipeline stage
    reg mul_en_out_reg;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            mul_en_out_reg <= 1'b0;
            
            // Reset all pipeline stages
            mul_out <= 16'b0;
            mul_en_out <= 1'b0;
        end else if (mul_en_in) begin
            // Sample inputs into registers
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
            
            // Store flag for output enable
            mul_en_out_reg <= mul_en_in;
        end
    end
    
    // Generate partial products
    integer i;
    always @(*) begin
        for (i = 0; i < 8; i = i + 1) begin
            pp[i] = mul_a_reg & {8{mul_b_reg[i]}};
        end
    end

    // Sum up partial products using a simple shift and add operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset partial sums
            for (i = 0; i < 8; i = i + 1) begin
                sum[i] <= 16'b0;
            end
        end else begin
            // Shift and add partial products
            sum[0] <= {8'b0, pp[0]};
            sum[1] <= sum[0] + ({7'b0, pp[1], 1'b0});
            sum[2] <= sum[1] + ({6'b0, pp[2], 2'b0});
            sum[3] <= sum[2] + ({5'b0, pp[3], 3'b0});
            sum[4] <= sum[3] + ({4'b0, pp[4], 4'b0});
            sum[5] <= sum[4] + ({3'b0, pp[5], 5'b0});
            sum[6] <= sum[5] + ({2'b0, pp[6], 6'b0});
            sum[7] <= sum[6] + ({1'b0, pp[7], 7'b0});
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset output
            mul_out <= 16'b0;
            mul_en_out <= 1'b0;
        end else begin
            // Output final product
            mul_out <= sum[7];
            mul_en_out <= mul_en_out_reg;
        end
    end

endmodule
