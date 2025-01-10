module adder_pipe_64bit(
    input wire clk,
    input wire rst_n,
    input wire i_en,
    input wire [63:0] adda,
    input wire [63:0] addb,
    output reg [64:0] result,
    output reg o_en
);

    // Internal pipeline registers
    reg [15:0] adda_reg1, addb_reg1, sum_reg1;
    reg [15:0] adda_reg2, addb_reg2, sum_reg2;
    reg [15:0] adda_reg3, addb_reg3, sum_reg3;
    reg [15:0] adda_reg4, addb_reg4, sum_reg4;

    reg c_in1, c_in2, c_in3, c_in4;
    reg c_out1, c_out2, c_out3;
    
    reg i_en_pipeline [3:0];
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all internal registers and output
            {adda_reg1, addb_reg1, sum_reg1} <= 0;
            {adda_reg2, addb_reg2, sum_reg2} <= 0;
            {adda_reg3, addb_reg3, sum_reg3} <= 0;
            {adda_reg4, addb_reg4, sum_reg4} <= 0;
            {c_in1, c_in2, c_in3, c_in4} <= 0;
            {c_out1, c_out2, c_out3} <= 0;
            i_en_pipeline <= 0;
            o_en <= 0;
            result <= 0;
        end else begin
            // Stage 1
            if (i_en) begin
                adda_reg1 <= adda[15:0];
                addb_reg1 <= addb[15:0];
                sum_reg1 <= adda[15:0] + addb[15:0];
                c_in1 <= 0;
                c_out1 <= (adda[15:0] + addb[15:0]) > 16'hFFFF;
            end
            i_en_pipeline[0] <= i_en;
            
            // Stage 2
            if (i_en_pipeline[0]) begin
                adda_reg2 <= adda[31:16];
                addb_reg2 <= addb[31:16];
                sum_reg2 <= adda[31:16] + addb[31:16] + c_out1;
                c_in2 <= c_out1;
                c_out2 <= (adda[31:16] + addb[31:16] + c_out1) > 16'hFFFF;
            end
            i_en_pipeline[1] <= i_en_pipeline[0];
            
            // Stage 3
            if (i_en_pipeline[1]) begin
                adda_reg3 <= adda[47:32];
                addb_reg3 <= addb[47:32];
                sum_reg3 <= adda[47:32] + addb[47:32] + c_out2;
                c_in3 <= c_out2;
                c_out3 <= (adda[47:32] + addb[47:32] + c_out2) > 16'hFFFF;
            end
            i_en_pipeline[2] <= i_en_pipeline[1];
            
            // Stage 4
            if (i_en_pipeline[2]) begin
                adda_reg4 <= adda[63:48];
                addb_reg4 <= addb[63:48];
                sum_reg4 <= adda[63:48] + addb[63:48] + c_out3;
                c_in4 <= c_out3;
                o_en <= i_en_pipeline[2];
                result <= {sum_reg4[15:0] + c_out3, sum_reg3, sum_reg2, sum_reg1};
            end
            i_en_pipeline[3] <= i_en_pipeline[2];
        end
    end

endmodule
