module dut (
    input clk,          // Clock signal
    input resetn,       // Active-low synchronous reset
    input [2:0] r,      // Request signals from devices (r[0], r[1], r[2])
    output reg [2:0] g  // Grant signals to devices (g[0], g[1], g[2])
);

    // Define states as an enumerated type
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // Declare state and next_state variables
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A; // Reset to state A
        end else begin
            state <= next_state; // Update state
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (r[0]) begin
                    next_state = STATE_B; // Transition to state B if r[0] is high
                end else if (!r[0] && r[1]) begin
                    next_state = STATE_C; // Transition to state C if r[1] is high
                end else if (!r[0] && !r[1] && r[2]) begin
                    next_state = STATE_D; // Transition to state D if r[2] is high
                end else begin
                    next_state = STATE_A; // Stay in state A if no requests
                end
            end
            STATE_B: begin
                if (r[0]) begin
                    next_state = STATE_B; // Stay in state B if r[0] is high
                end else begin
                    next_state = STATE_A; // Transition to state A if r[0] is low
                end
            end
            STATE_C: begin
                if (r[1]) begin
                    next_state = STATE_C; // Stay in state C if r[1] is high
                end else begin
                    next_state = STATE_A; // Transition to state A if r[1] is low
                end
            end
            STATE_D: begin
                if (r[2]) begin
                    next_state = STATE_D; // Stay in state D if r[2] is high
                end else begin
                    next_state = STATE_A; // Transition to state A if r[2] is low
                end
            end
            default: begin
                next_state = STATE_A; // Default to state A
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: begin
                g = 3'b000; // No grants in state A
            end
            STATE_B: begin
                g = 3'b001; // Grant to device 0 in state B
            end
            STATE_C: begin
                g = 3'b010; // Grant to device 1 in state C
            end
            STATE_D: begin
                g = 3'b100; // Grant to device 2 in state D
            end
            default: begin
                g = 3'b000; // Default to no grants
            end
        endcase
    end

endmodule
