module dut (
    input wire         clk,          // Clock signal
    input wire         rst_n,        // Active-low reset signal
    input wire         mul_en_in,    // Input enable signal
    input wire [7:0]   mul_a,        // Multiplicand
    input wire [7:0]   mul_b,        // Multiplier
    output wire        mul_en_out,   // Output enable signal
    output wire [15:0] mul_out       // 16-bit product output
);

    // Intermediate registers for pipelining
    reg           mul_en_out_reg;   // Enable output signal register
    reg [7:0]     mul_a_reg;        // Register for multiplicand
    reg [7:0]     mul_b_reg;        // Register for multiplier
    reg [15:0]    partial_sum [3:0]; // Registers for partial sums
    reg [15:0]    mul_out_reg;      // Register for the final product output

    // Wires for partial products
    wire [15:0]   temp [7:0];

    // Output enable signal derived from the pipeline
    assign mul_en_out = mul_en_out_reg;

    // Assign the final product output
    assign mul_out = mul_en_out ? mul_out_reg : 16'b0;

    // Generate partial products
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin: partial_product_gen
            assign temp[i] = mul_b_reg[i] ? (mul_a_reg << i) : 16'b0;
        end
    endgenerate

    // Sequential logic for pipelined processing
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all pipeline registers
            mul_en_out_reg <= 1'b0;
            mul_a_reg      <= 8'b0;
            mul_b_reg      <= 8'b0;
            partial_sum[0] <= 16'b0;
            partial_sum[1] <= 16'b0;
            partial_sum[2] <= 16'b0;
            partial_sum[3] <= 16'b0;
            mul_out_reg    <= 16'b0;
        end else begin
            // Stage 1: Capture inputs and enable signal
            if (mul_en_in) begin
                mul_en_out_reg <= mul_en_in;
                mul_a_reg      <= mul_a;
                mul_b_reg      <= mul_b;
            end else begin
                mul_en_out_reg <= 1'b0;
            end

            // Stage 2: Compute intermediate partial sums
            partial_sum[0] <= temp[0] + temp[1];
            partial_sum[1] <= temp[2] + temp[3];

            // Stage 3: Continue partial sum accumulation
            partial_sum[2] <= temp[4] + temp[5];
            partial_sum[3] <= temp[6] + temp[7];

            // Stage 4: Compute final product output
            mul_out_reg <= partial_sum[0] + partial_sum[1] + partial_sum[2] + partial_sum[3];
        end
    end

endmodule