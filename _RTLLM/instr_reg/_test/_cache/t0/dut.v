module instr_reg(
    input wire clk,               // Clock signal for synchronization
    input wire rst,               // Active low reset signal
    input wire [1:0] fetch,       // Control signal for instruction source
    input wire [7:0] data,        // 8-bit data input for instructions
    output wire [2:0] ins,        // High 3 bits of instruction (opcode)
    output wire [4:0] ad1,        // Low 5 bits of instruction (register address)
    output reg [7:0] ad2          // 8-bit data from second source
);

    // Two registers to store instructions from different sources
    reg [7:0] ins_p1;
    reg [7:0] ins_p2;

    // On each rising edge of the clock
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Initialize registers to zero if reset is active (active low)
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            // Determine the source of the instruction based on fetch signal
            case (fetch)
                2'b01: ins_p1 <= data;  // Load instruction from register source
                2'b10: ins_p2 <= data;  // Load instruction from RAM/ROM source
                default: begin
                    // Retain previous values if fetch is neither 01 nor 10
                    ins_p1 <= ins_p1;
                    ins_p2 <= ins_p2;
                end
            endcase
        end
    end

    // Output assignments
    assign ins = ins_p1[7:5];  // 3 most significant bits of ins_p1
    assign ad1 = ins_p1[4:0];  // 5 least significant bits of ins_p1
    assign ad2 = ins_p2;       // Full 8-bit content of ins_p2

endmodule
