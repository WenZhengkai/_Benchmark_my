module dut(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    // Define the state encoding for the FSM
    typedef enum logic [1:0] {
        LEFT = 2'b00,   // Walking left
        RIGHT = 2'b01,  // Walking right
        FALL_LEFT = 2'b10,  // Falling, was walking left
        FALL_RIGHT = 2'b11  // Falling, was walking right
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Synchronous block: Transition to the next state or reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= LEFT; // Reset to walking left
        end else begin
            current_state <= next_state; // Go to the next state
        end
    end

    // Combinational block: Determine the next state
    always @(*) begin
        case (current_state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT; // Start falling
                end else if (bump_left) begin
                    next_state = RIGHT; // Change direction to right
                end else begin
                    next_state = LEFT; // Continue walking left
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT; // Start falling
                end else if (bump_right) begin
                    next_state = LEFT; // Change direction to left
                end else begin
                    next_state = RIGHT; // Continue walking right
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = LEFT; // Land and resume walking left
                end else begin
                    next_state = FALL_LEFT; // Continue falling
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT; // Land and resume walking right
                end else begin
                    next_state = FALL_RIGHT; // Continue falling
                end
            end
            default: begin
                next_state = LEFT; // Default to walking left (shouldn't happen)
            end
        endcase
    end

    // Combinational block: Determine the outputs based on the current state
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            LEFT: begin
                walk_left = 1;
            end
            RIGHT: begin
                walk_right = 1;
            end
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1; // dut scream while falling
            end
        endcase
    end

endmodule
