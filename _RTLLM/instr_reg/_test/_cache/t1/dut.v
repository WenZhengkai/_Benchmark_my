module instr_reg (
    input wire clk,          // Clock signal
    input wire rst,          // Active low reset signal
    input wire [1:0] fetch,  // Control signal for source selection
    input wire [7:0] data,   // 8-bit data input

    output reg [2:0] ins,    // High 3 bits of the instruction
    output reg [4:0] ad1,    // Low 5 bits of the instruction
    output reg [7:0] ad2     // Full 8-bit data from the second source
);

    // Instruction registers
    reg [7:0] ins_p1;
    reg [7:0] ins_p2;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // On reset, initialize the registers
            ins_p1 <= 8'b0;
            ins_p2 <= 8'b0;
        end else begin
            // Fetch new instruction based on control signal
            case (fetch)
                2'b01: ins_p1 <= data;  // Fetch from first source
                2'b10: ins_p2 <= data;  // Fetch from second source
                default: ;  // Retain previous values
            endcase
        end
    end

    always @(*) begin
        // Derive output signals based on stored instructions
        ins = ins_p1[7:5];
        ad1 = ins_p1[4:0];
        ad2 = ins_p2;
    end

endmodule
