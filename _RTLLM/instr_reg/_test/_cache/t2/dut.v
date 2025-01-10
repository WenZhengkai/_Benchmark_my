module instr_reg (
    input wire clk,                  // Clock signal for synchronization
    input wire rst,                  // Active low reset signal to initialize the register
    input wire [1:0] fetch,          // Control signal indicating the source of the instruction
    input wire [7:0] data,           // 8-bit data input representing the instruction to be fetched
    output wire [2:0] ins,           // High 3 bits of the instruction (opcode)
    output wire [4:0] ad1,           // Low 5 bits of the instruction (register address)
    output wire [7:0] ad2            // Full 8-bit data from the second source
);

    reg [7:0] ins_p1;                // Register to store instruction fetched with fetch = 2'b01
    reg [7:0] ins_p2;                // Register to store instruction fetched with fetch = 2'b10

    // Sequential logic for storing instructions
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Reset condition - initialize both registers to zero
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            case(fetch)
                2'b01: begin
                    // Fetch instruction from data into ins_p1
                    ins_p1 <= data;
                end
                2'b10: begin
                    // Fetch instruction from data into ins_p2
                    ins_p2 <= data;
                end
                default: begin
                    // If no valid fetch signal, retain previous values
                    ins_p1 <= ins_p1;
                    ins_p2 <= ins_p2;
                end
            endcase
        end
    end

    // Combinational logic to derive outputs from stored instructions
    assign ins = ins_p1[7:5];  // Extract high 3 bits of ins_p1 for opcode
    assign ad1 = ins_p1[4:0];  // Extract low 5 bits of ins_p1 for register address
    assign ad2 = ins_p2;       // Output full 8 bits of ins_p2

endmodule
