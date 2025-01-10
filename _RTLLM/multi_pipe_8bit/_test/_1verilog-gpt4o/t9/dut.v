module multi_pipe_8bit (
    input wire clk,
    input wire rst_n,
    input wire mul_en_in,
    input wire [7:0] mul_a,
    input wire [7:0] mul_b,
    output reg mul_en_out,
    output reg [15:0] mul_out
);

    reg [7:0] mul_a_reg, mul_b_reg;
    reg mul_en_pipeline [3:0];
    reg [15:0] partial_products [7:0];
    reg [15:0] partial_sums [3:0];
    
    integer i;
    
    // Pipelined control signal registration
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_pipeline[0] <= 1'b0;
            mul_en_pipeline[1] <= 1'b0;
            mul_en_pipeline[2] <= 1'b0;
            mul_en_pipeline[3] <= 1'b0;
            mul_en_out <= 1'b0;
        end else begin
            mul_en_pipeline[0] <= mul_en_in;
            mul_en_pipeline[1] <= mul_en_pipeline[0];
            mul_en_pipeline[2] <= mul_en_pipeline[1];
            mul_en_pipeline[3] <= mul_en_pipeline[2];
            mul_en_out <= mul_en_pipeline[3];
        end
    end

    // Input registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg <= 8'd0;
            mul_b_reg <= 8'd0;
        end else if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
        end
    end

    // Partial product generation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 8; i = i + 1)
                partial_products[i] <= 16'd0;
        end else if (mul_en_pipeline[0]) begin
            for (i = 0; i < 8; i = i + 1) begin
                partial_products[i] <= (mul_b_reg[i]) ? ({8'b0, mul_a_reg} << i) : 16'd0;
            end
        end
    end

    // Partial sum calculations
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            partial_sums[0] <= 16'd0;
            partial_sums[1] <= 16'd0;
            partial_sums[2] <= 16'd0;
            partial_sums[3] <= 16'd0;
            mul_out <= 16'd0;
        end else begin
            if (mul_en_pipeline[1]) begin
                partial_sums[0] <= partial_products[0] + partial_products[1] + partial_products[2] + partial_products[3];
                partial_sums[1] <= partial_products[4] + partial_products[5] + partial_products[6] + partial_products[7];
            end
            
            if (mul_en_pipeline[2]) begin
                partial_sums[2] <= partial_sums[0] + partial_sums[1];
            end

            if (mul_en_pipeline[3]) begin
                mul_out <= partial_sums[2];
            end
        end
    end
endmodule
