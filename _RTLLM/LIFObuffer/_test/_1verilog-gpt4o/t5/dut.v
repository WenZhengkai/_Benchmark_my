module LIFObuffer (
    input wire [3:0] dataIn,
    input wire RW,
    input wire EN,
    input wire Rst,
    input wire Clk,
    output reg EMPTY,
    output reg FULL,
    output reg [3:0] dataOut
);
  
    reg [3:0] stack_mem [0:3]; // 4-entry deep stack
    reg [2:0] SP;              // Stack Pointer (2-bits are enough for 4 entries)
  
    always @(posedge Clk) begin
        if (Rst) begin
            // Reset logic
            SP <= 3'b100; // Set stack pointer to 4 (indicates empty)
            EMPTY <= 1'b1; // Buffer is empty
            FULL <= 1'b0; // Buffer is not full
            dataOut <= 4'b0000;
            // Initialize memory
            stack_mem[0] <= 4'b0000;
            stack_mem[1] <= 4'b0000;
            stack_mem[2] <= 4'b0000;
            stack_mem[3] <= 4'b0000;
        end else if (EN) begin
            if (RW == 1'b0) begin
                // Write operation
                if (!FULL) begin
                    SP <= SP - 1;
                    stack_mem[SP - 1] <= dataIn;
                end
            end else if (RW == 1'b1) begin
                // Read operation
                if (!EMPTY) begin
                    dataOut <= stack_mem[SP];
                    SP <= SP + 1;
                    stack_mem[SP] <= 4'b0000; // Clear memory on pop
                end
            end

            // Update EMPTY and FULL flags
            EMPTY <= (SP == 3'b100) ? 1'b1 : 1'b0;
            FULL <= (SP == 3'b000) ? 1'b1 : 1'b0;
        end
    end
endmodule
