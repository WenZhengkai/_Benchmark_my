module instr_reg (
    input clk,             // Clock signal
    input rst,             // Active low reset signal
    input [1:0] fetch,     // Control signal for instruction source
    input [7:0] data,      // 8-bit data input

    output [2:0] ins,      // High 3 bits of the instruction
    output [4:0] ad1,      // Low 5 bits of the instruction
    output [7:0] ad2       // Full 8-bit data from the second source
);

    reg [7:0] ins_p1;      // Register for storing instruction from register
    reg [7:0] ins_p2;      // Register for storing instruction from RAM/ROM

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Initialize both registers to zero on reset
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            // Update registers based on the fetch signal
            case (fetch)
                2'b01: ins_p1 <= data;  // Fetch from data into ins_p1
                2'b10: ins_p2 <= data;  // Fetch from data into ins_p2
                default: begin
                    // Retain previous values if fetch is neither 01 nor 10
                    ins_p1 <= ins_p1;
                    ins_p2 <= ins_p2;
                end
            endcase
        end
    end

    // Output assignments
    assign ins = ins_p1[7:5]; // High 3 bits of ins_p1 for opcode/operation
    assign ad1 = ins_p1[4:0]; // Low 5 bits of ins_p1 for register address
    assign ad2 = ins_p2;      // Full 8-bit data from ins_p2

endmodule
