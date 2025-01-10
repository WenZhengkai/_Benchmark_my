module LIFObuffer (
    input wire [3:0] dataIn,   // 4-bit input data
    input wire RW,             // Read/Write control signal
    input wire EN,             // Enable signal
    input wire Rst,            // Reset signal
    input wire Clk,            // Clock signal
    output reg EMPTY,          // Empty flag
    output reg FULL,           // Full flag
    output reg [3:0] dataOut   // 4-bit output data
);

    // Internal stack memory and stack pointer
    reg [3:0] stack_mem [0:3]; // 4-depth, 4-bit wide stack memory
    reg [2:0] SP;              // Stack pointer, range 0 to 4

    // Initialization
    integer i;
    initial begin
        SP = 4;  // Initializing stack pointer as empty
        for (i = 0; i < 4; i = i + 1) begin
            stack_mem[i] = 4'b0;  // Clear all stack memory
        end
        EMPTY = 1;
        FULL = 0;
    end

    // Synchronous logic with the clock
    always @(posedge Clk) begin
        if (Rst) begin
            // Reset Operation: clear stack and initialize
            SP <= 4;
            for (i = 0; i < 4; i = i + 1) begin
                stack_mem[i] <= 4'b0;
            end
            EMPTY <= 1;
            FULL <= 0;
        end else if (EN) begin
            // Buffer operations enabled
            if (RW == 0 && !FULL) begin
                // Write operation (push)
                SP <= SP - 1;
                stack_mem[SP - 1] <= dataIn;
            end else if (RW == 1 && !EMPTY) begin
                // Read operation (pop)
                dataOut <= stack_mem[SP];
                stack_mem[SP] <= 4'b0;
                SP <= SP + 1;
            end

            // Update EMPTY and FULL flags
            EMPTY <= (SP == 4);
            FULL <= (SP == 0);
        end
    end
endmodule
