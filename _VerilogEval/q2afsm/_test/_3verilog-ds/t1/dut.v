module dut (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// Define the states
typedef enum reg [1:0] {
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11
} state_t;

// Internal state register
state_t state, next_state;

// Synchronous reset and state transition logic
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= STATE_A; // Reset to state A
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (r[0])
                next_state = STATE_B;
            else if (r[1])
                next_state = STATE_C;
            else if (r[2])
                next_state = STATE_D;
            else
                next_state = STATE_A;
        end
        STATE_B: begin
            if (r[0])
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        STATE_C: begin
            if (r[1])
                next_state = STATE_C;
            else
                next_state = STATE_A;
        end
        STATE_D: begin
            if (r[2])
                next_state = STATE_D;
            else
                next_state = STATE_A;
        end
        default: next_state = STATE_A;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        STATE_A: g = 3'b000;
        STATE_B: g = 3'b001;
        STATE_C: g = 3'b010;
        STATE_D: g = 3'b100;
        default: g = 3'b000;
    endcase
end

endmodule
