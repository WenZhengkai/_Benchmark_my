module adder_pipe_64bit(
    input clk,
    input rst_n,
    input i_en,
    input [63:0] adda,
    input [63:0] addb,
    output reg [64:0] result,
    output reg o_en
    );

    // Intermediate registers for pipeline stages
    reg [15:0] a_reg0, b_reg0;
    reg [15:0] a_reg1, b_reg1;
    reg [15:0] a_reg2, b_reg2;
    reg [15:0] a_reg3, b_reg3;
    
    reg [16:0] sum0, sum1, sum2, sum3;
    reg carry0, carry1, carry2, carry3;
    
    reg [3:0] en_pipeline; // Pipeline enable shift register

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Initialize registers
            a_reg0 <= 0; b_reg0 <= 0;
            a_reg1 <= 0; b_reg1 <= 0;
            a_reg2 <= 0; b_reg2 <= 0;
            a_reg3 <= 0; b_reg3 <= 0;
            
            sum0 <= 0; carry0 <= 0;
            sum1 <= 0; carry1 <= 0;
            sum2 <= 0; carry2 <= 0;
            sum3 <= 0; carry3 <= 0;
            
            en_pipeline <= 0;
            result <= 0;
            o_en <= 0;
        end else begin
            // Shift enable pipeline register
            en_pipeline <= {en_pipeline[2:0], i_en};
            
            // Stage 0
            a_reg0 <= adda[15:0];
            b_reg0 <= addb[15:0];
            {carry0, sum0} <= {1'b0, a_reg0} + {1'b0, b_reg0};
            
            // Stage 1
            a_reg1 <= adda[31:16];
            b_reg1 <= addb[31:16];
            {carry1, sum1} <= {1'b0, a_reg1} + {1'b0, b_reg1} + carry0;
            
            // Stage 2
            a_reg2 <= adda[47:32];
            b_reg2 <= addb[47:32];
            {carry2, sum2} <= {1'b0, a_reg2} + {1'b0, b_reg2} + carry1;
            
            // Stage 3
            a_reg3 <= adda[63:48];
            b_reg3 <= addb[63:48];
            {carry3, sum3} <= {1'b0, a_reg3} + {1'b0, b_reg3} + carry2;
            
            // Output logic
            result <= {carry3, sum3[15:0], sum2[15:0], sum1[15:0], sum0[15:0]};
            o_en <= en_pipeline[3]; // o_en is asserted when the last stage result is ready
        end
    end
endmodule
