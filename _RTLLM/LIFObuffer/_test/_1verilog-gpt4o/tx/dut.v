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

    reg [3:0] stack_mem [3:0]; // Stack memory array
    reg [2:0] SP;              // Stack pointer (0 to 4)

    // Always block for synchronous operations on rising edge of Clk
    always @(posedge Clk) begin
        if (Rst) begin
            // Reset the buffer
            SP <= 3'b100;  // Set SP to 4, indicating an empty buffer
            stack_mem[0] <= 4'b0000;
            stack_mem[1] <= 4'b0000;
            stack_mem[2] <= 4'b0000;
            stack_mem[3] <= 4'b0000;
            EMPTY <= 1'b1;
            FULL <= 1'b0;
        end else if (EN) begin
            if (RW == 1'b0 && !FULL) begin
                // Write operation: push data onto the stack
                if (SP > 3'b000) begin
                    SP <= SP - 1;
                    stack_mem[SP - 1] <= dataIn;
                end
            end else if (RW == 1'b1 && !EMPTY) begin
                // Read operation: pop data from the stack
                if (SP < 3'b100) begin
                    dataOut <= stack_mem[SP];
                    stack_mem[SP] <= 4'b0000;
                    SP <= SP + 1;
                end
            end

            // Update FULL and EMPTY flags
            EMPTY <= (SP == 3'b100);
            FULL <= (SP == 3'b000);
        end
    end

endmodule
