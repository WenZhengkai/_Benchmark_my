module instr_reg (
    input wire clk,
    input wire rst,
    input wire [1:0] fetch,
    input wire [7:0] data,
    output reg [2:0] ins,
    output reg [4:0] ad1,
    output reg [7:0] ad2
);

    // Internal registers to store instructions
    reg [7:0] ins_p1;
    reg [7:0] ins_p2;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Initialize registers to zero when reset is active (active low)
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            // Fetch instruction based on fetch control signal
            case (fetch)
                2'b01: ins_p1 <= data; // Fetch from register
                2'b10: ins_p2 <= data; // Fetch from RAM/ROM
                default: begin
                    // Retain previous values
                    ins_p1 <= ins_p1;
                    ins_p2 <= ins_p2;
                end
            endcase

            // Assign outputs based on fetched instructions
            ins <= ins_p1[7:5]; // Extract high 3 bits for opcode
            ad1 <= ins_p1[4:0]; // Extract low 5 bits for address
            ad2 <= ins_p2;      // Full 8-bit data from second source
        end
    end

endmodule
