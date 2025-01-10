module multi_pipe_8bit (
    input wire clk,                  // Clock signal
    input wire rst_n,                // Active-low reset
    input wire mul_en_in,            // Input enable signal
    input wire [7:0] mul_a,          // Multiplicand (8 bits)
    input wire [7:0] mul_b,          // Multiplier (8 bits)
    output reg mul_en_out,           // Output enable signal
    output reg [15:0] mul_out        // Product output (16 bits)
);

    // Registers for enabling signals and inputs
    reg [1:0] mul_en_out_reg;        // Pipeline stages for input enable
    reg [7:0] mul_a_reg, mul_b_reg;  // Registers for multiplicand and multiplier

    // Wires for partial products
    wire [15:0] temp[7:0];  // Intermediate wires for partial products

    // Registers for partial sums
    reg [15:0] partial_sum[3:0];  // Registers for partial sums

    // Combinational logic for partial products
    assign temp[0] = (mul_b_reg[0]) ? {8'b0, mul_a_reg} : 16'b0;
    assign temp[1] = (mul_b_reg[1]) ? {7'b0, mul_a_reg, 1'b0} : 16'b0;
    assign temp[2] = (mul_b_reg[2]) ? {6'b0, mul_a_reg, 2'b0} : 16'b0;
    assign temp[3] = (mul_b_reg[3]) ? {5'b0, mul_a_reg, 3'b0} : 16'b0;
    assign temp[4] = (mul_b_reg[4]) ? {4'b0, mul_a_reg, 4'b0} : 16'b0;
    assign temp[5] = (mul_b_reg[5]) ? {3'b0, mul_a_reg, 5'b0} : 16'b0;
    assign temp[6] = (mul_b_reg[6]) ? {2'b0, mul_a_reg, 6'b0} : 16'b0;
    assign temp[7] = (mul_b_reg[7]) ? {1'b0, mul_a_reg, 7'b0} : 16'b0;

    // Pipeline register update on clock edge
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out_reg <= 2'b0;
            mul_a_reg <= 8'b0;
            mul_b_reg <= 8'b0;
            partial_sum[0] <= 16'b0;
            partial_sum[1] <= 16'b0;
            partial_sum[2] <= 16'b0;
            partial_sum[3] <= 16'b0;
            mul_out <= 16'b0;
        end else begin
            // Update pipeline enable signals
            mul_en_out_reg <= {mul_en_out_reg[0], mul_en_in};

            if (mul_en_in) begin
                // Capture inputs when enabled
                mul_a_reg <= mul_a;
                mul_b_reg <= mul_b;
            end

            // Compute partial sums
            partial_sum[0] <= temp[0] + temp[1];
            partial_sum[1] <= temp[2] + temp[3];
            partial_sum[2] <= temp[4] + temp[5];
            partial_sum[3] <= temp[6] + temp[7];

            // Compute final sum
            mul_out <= partial_sum[0] + partial_sum[1] + partial_sum[2] + partial_sum[3];
        end
    end

    // Output enable derived from enable pipeline
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out <= 1'b0;
        end else begin
            // Final output enable signal based on pipeline
            mul_en_out <= mul_en_out_reg[1];
        end
    end

endmodule
