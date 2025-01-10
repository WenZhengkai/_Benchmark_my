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

    // Initialize the buffer
    initial begin
        SP = 3'b100; // Stack pointer set to 4 (empty)
        EMPTY = 1;
        FULL = 0;
    end

    always @(posedge Clk) begin
        if (Rst) begin
            // Reset the buffer
            SP <= 3'b100;
            EMPTY <= 1;
            FULL <= 0;
            stack_mem[0] <= 4'b0000;
            stack_mem[1] <= 4'b0000;
            stack_mem[2] <= 4'b0000;
            stack_mem[3] <= 4'b0000;
        end else if (EN) begin
            if (RW == 0 && !FULL) begin
                // Write operation
                SP <= SP - 1;
                stack_mem[SP - 1] <= dataIn;
                if (SP == 3'b001) FULL <= 1;
                EMPTY <= 0;
            end else if (RW == 1 && !EMPTY) begin
                // Read operation
                dataOut <= stack_mem[SP];
                stack_mem[SP] <= 4'b0000;
                SP <= SP + 1;
                if (SP == 3'b100) EMPTY <= 1;
                FULL <= 0;
            end
        end

        // Update EMPTY and FULL flags
        if (SP == 3'b100) EMPTY <= 1;
        else EMPTY <= 0;

        if (SP == 3'b000) FULL <= 1;
        else FULL <= 0;
    end

endmodule
