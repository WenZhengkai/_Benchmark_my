module instr_reg (
    input wire clk,          // Clock signal for synchronization
    input wire rst,          // Active low reset signal
    input wire [1:0] fetch,  // Control signal indicating the source of the instruction
    input wire [7:0] data,   // 8-bit data input representing the instruction to be fetched
    output reg [2:0] ins,    // High 3 bits of the instruction (opcode/operation)
    output reg [4:0] ad1,    // Low 5 bits of the instruction (register address)
    output reg [7:0] ad2     // Full 8-bit data from the second source
);

    // Internal registers to store instructions
    reg [7:0] ins_p1;
    reg [7:0] ins_p2;

    // Always block to handle synchronous reset and data capture
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Initialize registers to zero on reset
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            // Capture instructions based on fetch control signal
            case (fetch)
                2'b01: ins_p1 <= data;
                2'b10: ins_p2 <= data;
                default: begin
                    // Retain previous values if neither condition is met
                    ins_p1 <= ins_p1;
                    ins_p2 <= ins_p2;
                end
            endcase
        end
    end

    // Combinational logic to derive outputs from stored instructions
    always @(*) begin
        ins = ins_p1[7:5];  // High 3 bits from ins_p1
        ad1 = ins_p1[4:0];  // Low 5 bits from ins_p1
        ad2 = ins_p2;       // Full 8 bits from ins_p2
    end

endmodule
