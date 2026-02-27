module dut (
    input wire clk,              // Clock signal for synchronous operation
    input wire rst_n,            // Active-low reset signal
    input wire mul_en_in,        // Input enable signal
    input wire [7:0] mul_a,      // Multiplicand input (8 bits)
    input wire [7:0] mul_b,      // Multiplier input (8 bits)
    output reg mul_en_out,       // Output enable signal
    output reg [15:0] mul_out    // Product output (16 bits)
);

    // Pipeline Registers for inputs
    reg [7:0] mul_a_reg_1, mul_a_reg_2;
    reg [7:0] mul_b_reg_1, mul_b_reg_2;

    // Enable pipeline register
    reg mul_en_reg_1, mul_en_reg_2;

    // Partial Sum Registers
    reg [15:0] partial_sum_1, partial_sum_2;

    // Final Product Register
    reg [15:0] mul_out_reg;

    // Pipeline Stage 1: Capture input and generate partial product (stage 1)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_reg_1 <= 1'b0;
            mul_a_reg_1  <= 8'b0;
            mul_b_reg_1  <= 8'b0;
            partial_sum_1 <= 16'b0;
        end else if (mul_en_in) begin
            mul_en_reg_1 <= mul_en_in;
            mul_a_reg_1  <= mul_a;
            mul_b_reg_1  <= mul_b;
            partial_sum_1 <= mul_a * mul_b[3:0];  // First half of partial product using 4 LSB of mul_b
        end
    end

    // Pipeline Stage 2: Compute the next partial product and add to previous result
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_reg_2 <= 1'b0;
            mul_a_reg_2  <= 8'b0;
            mul_b_reg_2  <= 8'b0;
            partial_sum_2 <= 16'b0;
        end else if (mul_en_reg_1) begin
            mul_en_reg_2 <= mul_en_reg_1;
            mul_a_reg_2  <= mul_a_reg_1;
            mul_b_reg_2  <= mul_b_reg_1;
            // Accumulate sum of partial products
            partial_sum_2 <= partial_sum_1 + (mul_a_reg_1 * mul_b_reg_2[7:4] << 4);  // Upper 4 bits shifted appropriately
        end
    end

    // Pipeline Stage 3: Output final product
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_en_out <= 1'b0;
            mul_out_reg <= 16'b0;
        end else if (mul_en_reg_2) begin
            mul_en_out <= mul_en_reg_2;
            mul_out_reg <= partial_sum_2;
        end
    end

    // Assign final product to output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 16'b0;
        end else if (mul_en_out) begin
            mul_out <= mul_out_reg;
        end else begin
            mul_out <= 16'b0; // Hold output at zero if not enabled
        end
    end

endmodule
