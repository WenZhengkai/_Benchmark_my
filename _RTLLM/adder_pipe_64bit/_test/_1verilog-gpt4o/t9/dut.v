module adder_pipe_64bit (
    input clk,             // Clock input
    input rst_n,           // Active low reset signal
    input i_en,            // Enable signal for the addition operation
    input [63:0] adda,     // 64-bit input operand A
    input [63:0] addb,     // 64-bit input operand B
    output reg [64:0] result, // 65-bit output result
    output reg o_en        // Output enable signal
);

// Internal registers for pipelining
reg [15:0] a_reg [0:3], b_reg [0:3];
reg carry_reg [0:3];
reg [3:0] i_en_pipe;

// Intermediate pipeline stage results
reg [16:0] sum_stage1, sum_stage2, sum_stage3, sum_stage4;

// Sequential logic to implement pipeline stages
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Reset all pipeline registers
        a_reg[0] <= 16'b0; b_reg[0] <= 16'b0; carry_reg[0] <= 1'b0;
        a_reg[1] <= 16'b0; b_reg[1] <= 16'b0; carry_reg[1] <= 1'b0;
        a_reg[2] <= 16'b0; b_reg[2] <= 16'b0; carry_reg[2] <= 1'b0;
        a_reg[3] <= 16'b0; b_reg[3] <= 16'b0; carry_reg[3] <= 1'b0;
        i_en_pipe <= 4'b0;
        result <= 65'b0;
        o_en <= 1'b0;
    end else begin
        // Stage 1: Input latch and initial addition
        a_reg[0] <= adda[15:0];
        b_reg[0] <= addb[15:0];
        i_en_pipe[0] <= i_en;
        sum_stage1 <= {1'b0, a_reg[0]} + {1'b0, b_reg[0]} + carry_reg[0];
        
        // Stage 2: Process the next segment
        a_reg[1] <= adda[31:16];
        b_reg[1] <= addb[31:16];
        carry_reg[1] <= sum_stage1[16];
        i_en_pipe[1] <= i_en_pipe[0];
        sum_stage2 <= {1'b0, a_reg[1]} + {1'b0, b_reg[1]} + carry_reg[1];
        
        // Stage 3: Process the next segment
        a_reg[2] <= adda[47:32];
        b_reg[2] <= addb[47:32];
        carry_reg[2] <= sum_stage2[16];
        i_en_pipe[2] <= i_en_pipe[1];
        sum_stage3 <= {1'b0, a_reg[2]} + {1'b0, b_reg[2]} + carry_reg[2];
        
        // Stage 4: Process the final segment
        a_reg[3] <= adda[63:48];
        b_reg[3] <= addb[63:48];
        carry_reg[3] <= sum_stage3[16];
        i_en_pipe[3] <= i_en_pipe[2];
        sum_stage4 <= {1'b0, a_reg[3]} + {1'b0, b_reg[3]} + carry_reg[3];
        
        // Combine the results and produce output in the final stage
        result <= {sum_stage4[16], sum_stage4[15:0], sum_stage3[15:0], sum_stage2[15:0], sum_stage1[15:0]};
        o_en <= i_en_pipe[3];
    end
end

endmodule
