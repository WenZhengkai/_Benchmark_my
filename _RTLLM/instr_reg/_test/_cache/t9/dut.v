module instr_reg (
    input wire clk,              // Clock signal for synchronization
    input wire rst_n,            // Active low reset signal
    input wire [1:0] fetch,      // Control signal for instruction source
    input wire [7:0] data,       // 8-bit data input representing the instruction
    output reg [2:0] ins,        // High 3 bits of the instruction
    output reg [4:0] ad1,        // Low 5 bits of the instruction
    output reg [7:0] ad2         // Full 8-bit data from the second source
);

    // Internal registers to store instructions from different sources
    reg [7:0] ins_p1;            // Register for instructions from first source
    reg [7:0] ins_p2;            // Register for instructions from second source

    // Always block for sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset conditions
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            // Fetch instructions based on the fetch control signal
            case (fetch)
                2'b01: ins_p1 <= data;    // Fetch from the first source
                2'b10: ins_p2 <= data;    // Fetch from the second source
                default: begin
                    // Retain previous values if fetch does not match
                    ins_p1 <= ins_p1;
                    ins_p2 <= ins_p2;
                end
            endcase
        end
    end

    // Combinational logic for output assignment
    always @(*) begin
        // Output the high 3 bits of ins_p1 as ins
        ins = ins_p1[7:5];
        // Output the low 5 bits of ins_p1 as ad1
        ad1 = ins_p1[4:0];
        // Output ins_p2 as ad2
        ad2 = ins_p2;
    end

endmodule
