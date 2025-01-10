module LIFObuffer (
    input wire [3:0] dataIn,  // 4-bit input data
    input wire RW,            // Read/Write control signal (1 for read, 0 for write)
    input wire EN,            // Enable signal
    input wire Rst,           // Active high reset signal
    input wire Clk,           // Clock signal
    output reg EMPTY,         // Empty flag
    output reg FULL,          // Full flag
    output reg [3:0] dataOut  // 4-bit output data
);

    reg [3:0] stack_mem [0:3]; // Stack memory array to store data
    reg [2:0] SP;               // Stack Pointer (3 bits to address 5 locations: 0 to 4)

    always @(posedge Clk) begin
        if (Rst) begin
            // When reset is high, clear the stack
            SP <= 3'b100; // Set SP to 4, indicating the stack is empty
            stack_mem[0] <= 4'b0000;
            stack_mem[1] <= 4'b0000;
            stack_mem[2] <= 4'b0000;
            stack_mem[3] <= 4'b0000;
            EMPTY <= 1; // Stack is empty
            FULL <= 0;  // Stack is not full
        end
        else if (EN) begin
            if (RW == 0 && !FULL) begin
                // Write operation
                SP <= SP - 1;
                stack_mem[SP - 1] <= dataIn;
            end
            else if (RW == 1 && !EMPTY) begin
                // Read operation
                dataOut <= stack_mem[SP];
                stack_mem[SP] <= 4'b0000;
                SP <= SP + 1;
            end

            // Update EMPTY and FULL flags
            if (SP == 3) begin
                EMPTY <= 1;
            end else begin
                EMPTY <= 0;
            end

            if (SP == 0) begin
                FULL <= 1;
            end else begin
                FULL <= 0;
            end
        end
    end

endmodule
