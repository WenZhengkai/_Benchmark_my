module adder_pipe_64bit (
    input clk,               // Clock input
    input rst_n,             // Active low reset signal
    input i_en,              // Input enable signal
    input [63:0] adda,       // 64-bit input operand A
    input [63:0] addb,       // 64-bit input operand B
    output [64:0] result,    // 65-bit result (64-bit sum + carry out)
    output reg o_en          // Output enable signal
);

    // Pipeline registers for input operands
    reg [63:0] adda_reg [3:0];
    reg [63:0] addb_reg [3:0];
    reg i_en_reg [3:0];
    
    // Pipeline registers for intermediate sums and carry
    reg [15:0] sum_reg [3:0];
    reg carry_reg [3:0]; 
    
    // Propagated carrys
    wire [3:0] carry;
    
    // Intermediate sums
    wire [15:0] sum[3:0];
    
    // Stage 1 (0-15 bits)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            adda_reg[0] <= 64'b0;
            addb_reg[0] <= 64'b0;
            i_en_reg[0] <= 1'b0;
            sum_reg[0] <= 16'b0;
            carry_reg[0] <= 1'b0;
        end else if (i_en) begin
            adda_reg[0] <= adda;
            addb_reg[0] <= addb;
            i_en_reg[0] <= i_en;
            {carry_reg[0], sum_reg[0]} <= adda[15:0] + addb[15:0];
        end
    end

    // Stage 2 (16-31 bits)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            adda_reg[1] <= 64'b0;
            addb_reg[1] <= 64'b0;
            i_en_reg[1] <= 1'b0;
            sum_reg[1] <= 16'b0;
            carry_reg[1] <= 1'b0;
        end else begin
            adda_reg[1] <= adda_reg[0];
            addb_reg[1] <= addb_reg[0];
            i_en_reg[1] <= i_en_reg[0];
            {carry_reg[1], sum_reg[1]} <= adda_reg[0][31:16] + addb_reg[0][31:16] + carry_reg[0];
        end
    end
    
    // Stage 3 (32-47 bits)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            adda_reg[2] <= 64'b0;
            addb_reg[2] <= 64'b0;
            i_en_reg[2] <= 1'b0;
            sum_reg[2] <= 16'b0;
            carry_reg[2] <= 1'b0;
        end else begin
            adda_reg[2] <= adda_reg[1];
            addb_reg[2] <= addb_reg[1];
            i_en_reg[2] <= i_en_reg[1];
            {carry_reg[2], sum_reg[2]} <= adda_reg[1][47:32] + addb_reg[1][47:32] + carry_reg[1];
        end
    end
    
    // Stage 4 (48-63 bits)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            adda_reg[3] <= 64'b0;
            addb_reg[3] <= 64'b0;
            i_en_reg[3] <= 1'b0;
            sum_reg[3] <= 16'b0;
            carry_reg[3] <= 1'b0;
        end else begin
            adda_reg[3] <= adda_reg[2];
            addb_reg[3] <= addb_reg[2];
            i_en_reg[3] <= i_en_reg[2];
            {carry_reg[3], sum_reg[3]} <= adda_reg[2][63:48] + addb_reg[2][63:48] + carry_reg[2];
        end
    end
    
    // Constructing final result and output enable signal
    assign result = {carry_reg[3], sum_reg[3], sum_reg[2], sum_reg[1], sum_reg[0]};
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_en <= 1'b0;
        end else begin
            o_en <= i_en_reg[3];
        end
    end

endmodule
