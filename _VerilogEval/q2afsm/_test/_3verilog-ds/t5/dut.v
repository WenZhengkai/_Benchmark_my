module dut (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// Define the states
typedef enum reg [1:0] {
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_D
} state_t;

// State register
state_t state, next_state;

// State transition and output logic
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A; // Reset to state A
        g <= 3'b000;      // Clear all grants
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    next_state = state; // Default to current state
    g = 3'b000;         // Default to no grants

    case (state)
        STATE_A: begin
            if (r[0]) begin
                next_state = STATE_B;
                g[0] = 1'b1;
            end else if (r[1]) begin
                next_state = STATE_C;
                g[1] = 1'b1;
            end else if (r[2]) begin
                next_state = STATE_D;
                g[2] = 1'b1;
            end
        end

        STATE_B: begin
            if (r[0]) begin
                next_state = STATE_B;
                g[0] = 1'b1;
            end else begin
                next_state = STATE_A;
            end
        end

        STATE_C: begin
            if (r[1]) begin
                next_state = STATE_C;
                g[1] = 1'b1;
            end else begin
                next_state = STATE_A;
            end
        end

        STATE_D: begin
            if (r[2]) begin
                next_state = STATE_D;
                g[2] = 1'b1;
            end else begin
                next_state = STATE_A;
            end
        end

        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
