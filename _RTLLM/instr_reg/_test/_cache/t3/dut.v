module instr_reg (
    input wire clk,         // Clock signal for synchronization
    input wire rst,         // Active low reset signal to initialize the register
    input wire [1:0] fetch, // Control signal indicating the source of the instruction
    input wire [7:0] data,  // 8-bit data input representing the instruction to be fetched
    
    output reg [2:0] ins,   // High 3 bits of the instruction, indicating the opcode or operation
    output reg [4:0] ad1,   // Low 5 bits of the instruction, representing the register address
    output reg [7:0] ad2    // The full 8-bit data from the second source
);

// Internal 8-bit registers to store instructions from different sources
reg [7:0] ins_p1;
reg [7:0] ins_p2;

// Process data on the rising edge of the clock or reset
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        // Initialize registers to zero on active low reset
        ins_p1 <= 8'b0;
        ins_p2 <= 8'b0;
    end else begin
        // Based on the fetch signal, store data in appropriate register
        case (fetch)
            2'b01: ins_p1 <= data; // Fetch instruction from the data input into ins_p1
            2'b10: ins_p2 <= data; // Fetch instruction from the data input into ins_p2
            default: begin
                // Retain previous values if neither condition is met
                ins_p1 <= ins_p1;
                ins_p2 <= ins_p2;
            end
        endcase
    end
end

// Assign outputs based on stored instruction registers
always @(*) begin
    ins = ins_p1[7:5]; // High 3 bits of ins_p1 for opcode
    ad1 = ins_p1[4:0]; // Low 5 bits of ins_p1 for register address
    ad2 = ins_p2;      // Full 8-bits of ins_p2
end

endmodule
