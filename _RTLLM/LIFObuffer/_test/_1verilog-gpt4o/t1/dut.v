module LIFObuffer (
    input wire [3:0] dataIn,   // 4-bit input data
    input wire RW,             // Read/Write control signal (1 for read, 0 for write)
    input wire EN,             // Enable signal
    input wire Rst,            // Active high reset signal
    input wire Clk,            // Clock signal
    output reg EMPTY,          // Flag indicating whether the buffer is empty
    output reg FULL,           // Flag indicating whether the buffer is full
    output reg [3:0] dataOut   // 4-bit output data
);

    // Internal stack memory and stack pointer
    reg [3:0] stack_mem [0:3]; // 4-depth, 4-bit wide stack memory
    reg [2:0] SP;              // Stack pointer, using 3 bits to cover 0-4 range

    // Initialize the module behavior
    always @(posedge Clk) begin
        if (Rst) begin
            // Reset operation
            SP <= 3'b100;      // Stack pointer set to 4 indicating empty
            stack_mem[0] <= 4'b0;
            stack_mem[1] <= 4'b0;
            stack_mem[2] <= 4'b0;
            stack_mem[3] <= 4'b0;
            EMPTY <= 1'b1;     // Buffer is empty
            FULL <= 1'b0;      // Buffer is not full
        end else if (EN) begin
            if (RW) begin
                // Read operation (pop)
                if (!EMPTY) begin
                    SP <= SP + 1;                    // Increment the stack pointer
                    dataOut <= stack_mem[SP];        // Pop data from the stack
                    stack_mem[SP] <= 4'b0;           // Clear the popped memory location

                    if (SP == 3'b011)                // After increment, check if stack is empty
                        EMPTY <= 1'b1;
                    FULL <= 1'b0;                    // Buffer is not full after a read
                end
            end else begin
                // Write operation (push)
                if (!FULL) begin
                    SP <= SP - 1;                    // Decrement the stack pointer
                    stack_mem[SP - 1] <= dataIn;     // Push data onto the stack

                    if (SP == 3'b000)                // After decrement, check if stack is full
                        FULL <= 1'b1;
                    EMPTY <= 1'b0;                   // Buffer is not empty after a write
                end
            end
        end
    end

endmodule