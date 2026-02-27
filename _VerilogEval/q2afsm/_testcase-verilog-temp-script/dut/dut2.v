module dut (
    input clk,          // Clock signal
    input resetn,       // Active-low synchronous reset
    input [2:0] r,      // Request signals (r[0], r[1], r[2])
    output reg [2:0] g  // Grant signals (g[0], g[1], g[2])
);

// Define states
typedef enum reg [1:0] {
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11
} state_t;

// State register
state_t current_state, next_state;

// Synchronous reset and state transition
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        current_state <= STATE_A; // Reset to state A
    end else begin
        current_state <= next_state; // Update state
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        STATE_A: begin
            if (r[0]) begin
                next_state = STATE_B;
            end else if (r[1]) begin
                next_state = STATE_C;
            end else if (r[2]) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (r[0]) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_C: begin
            if (r[1]) begin
                next_state = STATE_C;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_D: begin
            if (r[2]) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_A;
            end
        end
        default: begin
            next_state = STATE_A; // Default to state A
        end
    endcase
end

// Output logic
always @(*) begin
    g = 3'b000; // Default to no grants
    case (current_state)
        STATE_B: g[0] = 1; // Grant to device 0
        STATE_C: g[1] = 1; // Grant to device 1
        STATE_D: g[2] = 1; // Grant to device 2
        default: g = 3'b000; // No grants in state A
    endcase
end

endmodule
