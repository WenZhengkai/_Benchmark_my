module instr_reg (
    input wire clk,                 // Clock signal
    input wire rst,                 // Active low reset
    input wire [1:0] fetch,         // Control signal indicating the source of the instruction
    input wire [7:0] data,          // 8-bit data input representing the instruction to be fetched
    output reg [2:0] ins,           // High 3 bits of the instruction, indicating the opcode or operation
    output reg [4:0] ad1,           // Low 5 bits of the instruction, representing the register address
    output reg [7:0] ad2            // The full 8-bit data from the second source
);

    // Internal registers to hold instructions based on fetch
    reg [7:0] ins_p1;               // Register for instructions from source 1 (register)
    reg [7:0] ins_p2;               // Register for instructions from source 2 (RAM/ROM)

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Active low reset: Initialize both registers to 0
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            case (fetch)
                2'b01: begin
                    // Fetch instruction from data into ins_p1
                    ins_p1 <= data;
                end
                2'b10: begin
                    // Fetch instruction from data into ins_p2
                    ins_p2 <= data;
                end
                default: begin
                    // Retain previous values if fetch is neither 2'b01 nor 2'b10
                    ins_p1 <= ins_p1;
                    ins_p2 <= ins_p2;
                end
            endcase
        end
    end

    // Assign outputs based on ins_p1 and ins_p2 registers
    always @(*) begin
        // Ins is the high 3 bits of ins_p1
        ins = ins_p1[7:5];
        
        // Ad1 is the low 5 bits of ins_p1
        ad1 = ins_p1[4:0];
        
        // Ad2 is the full 8-bit data of the ins_p2 register
        ad2 = ins_p2;
    end

endmodule
