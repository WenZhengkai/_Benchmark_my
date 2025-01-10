module LIFObuffer (
    input [3:0] dataIn,
    input RW,
    input EN,
    input Rst,
    input Clk,
    output reg EMPTY,
    output reg FULL,
    output reg [3:0] dataOut
);

    reg [3:0] stack_mem [3:0]; // 4x4-bit stack memory
    reg [2:0] SP; // Stack pointer (3 bits to count from 0 to 4)

    always @(posedge Clk) begin
        if (Rst) begin
            // Reset the stack
            SP <= 3'b100; // Set stack pointer to 4 (empty)
            stack_mem[0] <= 4'b0000;
            stack_mem[1] <= 4'b0000;
            stack_mem[2] <= 4'b0000;
            stack_mem[3] <= 4'b0000;
            EMPTY <= 1'b1;
            FULL <= 1'b0;
        end else if (EN) begin
            if (RW == 1'b0) begin // Write operation
                if (!FULL) begin
                    SP <= SP - 1;
                    stack_mem[SP - 1] <= dataIn;
                    EMPTY <= 1'b0;
                    if (SP == 3'b001) FULL <= 1'b1;
                end
            end else if (RW == 1'b1) begin // Read operation
                if (!EMPTY) begin
                    dataOut <= stack_mem[SP];
                    stack_mem[SP] <= 4'b0000;
                    SP <= SP + 1;
                    FULL <= 1'b0;
                    if (SP == 3'b100) EMPTY <= 1'b1;
                end
            end
        end
    end

endmodule
