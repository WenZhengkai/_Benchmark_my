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
    reg         [1:0]   mul_en_pipe;
    
    // Partial products
    wire        [15:0]  temp [0:7];
    
    // Partial sums
    reg         [15:0]  sum [0:3];
    reg         [15:0]  final_sum;
    
    // Pipeline control
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_pipe <= 2'b00;
        end else begin
            mul_en_pipe <= {mul_en_pipe[0], mul_en_in};
        end
    end
    
    assign mul_en_out = mul_en_pipe[1];
    
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
    
    // Partial product generation
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : pp_gen
            assign temp[i] = mul_b_reg[i] ? (mul_a_reg << i) : 16'b0;
        end
    endgenerate
    
    // First stage of partial sums (level 1)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum[0] <= 16'b0;
            sum[1] <= 16'b0;
        end else if (mul_en_pipe[0]) begin
            sum[0] <= temp[0] + temp[1];
            sum[1] <= temp[2] + temp[3];
        end
    end
    
    // Second stage of partial sums (level 2)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum[2] <= 16'b0;
            sum[3] <= 16'b0;
        end else if (mul_en_pipe[0]) begin
            sum[2] <= temp[4] + temp[5];
            sum[3] <= temp[6] + temp[7];
        end
    end
    
    // Final sum stage
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            final_sum <= 16'b0;
        end else if (mul_en_pipe[0]) begin
            final_sum <= sum[0] + sum[1] + sum[2] + sum[3];
        end
    end
    
    // Output assignment
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 16'b0;
        end else begin
            mul_out <= mul_en_pipe[1] ? final_sum : 16'b0;
        end
    end

endmodule