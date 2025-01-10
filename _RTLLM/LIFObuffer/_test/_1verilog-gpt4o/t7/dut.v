module LIFObuffer (
    input [3:0] dataIn,   // 4-bit input data
    input RW,             // Read/Write control signal (1 for read, 0 for write)
    input EN,             // Enable signal
    input Rst,            // Active high reset signal
    input Clk,            // Clock signal
    output reg EMPTY,     // Flag indicating whether buffer is empty
    output reg FULL,      // Flag indicating whether buffer is full
    output reg [3:0] dataOut  // 4-bit output data
);

    reg [3:0] stack_mem [0:3];  // Stack memory to hold 4 entries of 4-bits each
    reg [1:0] SP;               // Stack pointer to track current position (2 bits to support 4 entries)

    // Procedure for operations at clock's rising edge
    always @(posedge Clk) begin
        if (Rst) begin
            // Reset the stack
            SP <= 2'b11;               // Stack pointer set to 4, indicating empty
            stack_mem[0] <= 4'b0000;
            stack_mem[1] <= 4'b0000;
            stack_mem[2] <= 4'b0000;
            stack_mem[3] <= 4'b0000;
            EMPTY <= 1'b1;
            FULL <= 1'b0;
        end else if (EN) begin
            if (RW == 1'b0) begin
                // Write operation (push)
                if (!FULL) begin
                    SP <= SP - 1;
                    stack_mem[SP] <= dataIn;
                end
            end else if (RW == 1'b1) begin
                // Read operation (pop)
                if (!EMPTY) begin
                    dataOut <= stack_mem[SP];
                    stack_mem[SP] <= 4'b0000;  // Clear the data (optional, for safety)
                    SP <= SP + 1;
                end
            end

            // Update EMPTY and FULL flags
            EMPTY <= (SP == 2'b11) ? 1'b1 : 1'b0;
            FULL <= (SP == 2'b00) ? 1'b1 : 1'b0;
        end
    end
    
endmodule
