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

    // Define the stack memory and the stack pointer.
    reg [3:0] stack_mem [0:3];
    reg [2:0] SP; // Stack pointer, 3 bits to represent values 0 to 4

    // Initialize the buffer on reset or on every clock cycle if EN is high
    always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            // Reset the stack pointer and flags, and clear the stack memory
            SP <= 3'b100; // SP = 4 indicating the stack is empty
            EMPTY <= 1'b1;
            FULL <= 1'b0;
            dataOut <= 4'b0;
            stack_mem[0] <= 4'b0;
            stack_mem[1] <= 4'b0;
            stack_mem[2] <= 4'b0;
            stack_mem[3] <= 4'b0;
        end else if (EN) begin
            if (RW == 1'b0) begin // Write operation
                if (~FULL) begin
                    SP <= SP - 1;
                    stack_mem[SP - 1] <= dataIn;
                end
            end else if (RW == 1'b1) begin // Read operation
                if (~EMPTY) begin
                    dataOut <= stack_mem[SP];
                    stack_mem[SP] <= 4'b0;
                    SP <= SP + 1;
                end
            end
            
            // Update EMPTY and FULL flags
            EMPTY <= (SP == 3'b100);
            FULL <= (SP == 3'b000);
        end
    end

endmodule
