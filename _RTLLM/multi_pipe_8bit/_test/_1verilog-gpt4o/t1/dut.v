module multi_pipe_8bit (
    input clk,                // Clock signal
    input rst_n,              // Active-low reset signal
    input mul_en_in,          // Input enable signal
    input [7:0] mul_a,        // Multiplicand
    input [7:0] mul_b,        // Multiplier
    output reg mul_en_out,    // Output enable signal
    output reg [15:0] mul_out // Product output
);

    // Input registers to store multiplicand and multiplier
    reg [7:0] mul_a_reg;
    reg [7:0] mul_b_reg;

    // Register to store the enable signal pipeline
    reg [1:0] mul_en_out_reg; 

    // Registers for partial sums
    reg [15:0] sum_stage1;
    reg [15:0] sum_stage2;
    reg [15:0] sum_stage3;
    reg [15:0] mul_out_reg; // Final output register

    // Pipeline step 0: Capture inputs and enable
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_a_reg <= 8'd0;
            mul_b_reg <= 8'd0;
            mul_en_out_reg <= 2'b00;
        end else if (mul_en_in) begin
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
            mul_en_out_reg <= {mul_en_out_reg[0], mul_en_in};
        end
    end

    // Generate partial products and calculate partial sums
    wire [15:0] temp [0:7];
    assign temp[0] = (mul_b_reg[0]) ? {8'd0, mul_a_reg} : 16'd0;
    assign temp[1] = (mul_b_reg[1]) ? {7'd0, mul_a_reg, 1'b0} : 16'd0;
    assign temp[2] = (mul_b_reg[2]) ? {6'd0, mul_a_reg, 2'b0} : 16'd0;
    assign temp[3] = (mul_b_reg[3]) ? {5'd0, mul_a_reg, 3'b0} : 16'd0;
    assign temp[4] = (mul_b_reg[4]) ? {4'd0, mul_a_reg, 4'b0} : 16'd0;
    assign temp[5] = (mul_b_reg[5]) ? {3'd0, mul_a_reg, 5'b0} : 16'd0;
    assign temp[6] = (mul_b_reg[6]) ? {2'd0, mul_a_reg, 6'b0} : 16'd0;
    assign temp[7] = (mul_b_reg[7]) ? {1'd0, mul_a_reg, 7'b0} : 16'd0;

    // Pipelining stages for partial sum calculation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sum_stage1 <= 16'd0;
            sum_stage2 <= 16'd0;
            sum_stage3 <= 16'd0;
            mul_out_reg <= 16'd0;
        end else if (mul_en_out_reg[1]) begin
            // Stage 1
            sum_stage1 <= temp[0] + temp[1] + temp[2] + temp[3];
            // Stage 2
            sum_stage2 <= sum_stage1 + temp[4];
            // Stage 3
            sum_stage3 <= sum_stage2 + temp[5];
            // Final stage to accumulate the product
            mul_out_reg <= sum_stage3 + temp[6] + temp[7];
        end
    end

    // Assign outputs
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 16'd0;
            mul_en_out <= 1'b0;
        end else begin
            mul_out <= (mul_en_out_reg[1]) ? mul_out_reg : 16'd0;
            mul_en_out <= mul_en_out_reg[1];
        end
    end

endmodule