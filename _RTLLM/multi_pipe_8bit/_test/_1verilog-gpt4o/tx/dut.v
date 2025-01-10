module multi_pipe_8bit (
    input wire clk,              // Clock signal
    input wire rst_n,            // Active-low reset signal
    input wire mul_en_in,        // Input enable signal
    input wire [7:0] mul_a,      // Multiplicand
    input wire [7:0] mul_b,      // Multiplier
    output reg mul_en_out,       // Output enable signal
    output reg [15:0] mul_out    // Product output
);

    // Registers to store inputs when mul_en_in is active
    reg [7:0] mul_a_reg;
    reg [7:0] mul_b_reg;

    // Intermediate registers for partial products
    reg [15:0] sum [7:0];
    reg [15:0] mul_out_reg;

    reg mul_en_out_reg [1:0]; // Pipeline register for enable signal

    // Sequential logic - input register and enable pipeline
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset
            mul_a_reg <= 8'd0;
            mul_b_reg <= 8'd0;
            mul_out_reg <= 16'd0;
            mul_en_out_reg[0] <= 0;
            mul_en_out_reg[1] <= 0;
        end else if (mul_en_in) begin
            // Register inputs on enable signal
            mul_a_reg <= mul_a;
            mul_b_reg <= mul_b;
            mul_en_out_reg[0] <= mul_en_in;
            mul_en_out_reg[1] <= mul_en_out_reg[0];
        end
    end

    // Generate partial products and calculate the sum
    always @(*) begin
        integer i;
        // Initialize sums to zero
        for (i = 0; i < 8; i = i + 1) begin
            sum[i] = 16'd0;
        end
        
        // Generate partial products
        for (i = 0; i < 8; i = i + 1) begin
            // Shift multiplicand by i and conditionally add to sum
            if (mul_b_reg[i]) begin
                sum[i] = mul_a_reg << i; // Shift multiplicand by i
            end
        end

        // Add partial products to calculate final product
        mul_out_reg = sum[0] + sum[1] + sum[2] + sum[3] +
                      sum[4] + sum[5] + sum[6] + sum[7];
    end

    // Sequential logic - output and enable signal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mul_out <= 16'd0;
            mul_en_out <= 0;
        end else begin
            // Assign outputs based on enable signal pipeline stage
            mul_out <= (mul_en_out_reg[1]) ? mul_out_reg : 16'd0;
            mul_en_out <= mul_en_out_reg[1];
        end
    end

endmodule
