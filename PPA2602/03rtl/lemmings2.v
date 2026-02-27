module dut (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    // State Definition
    typedef enum logic [1:0] {
        WALKING_LEFT  = 2'b00,
        WALKING_RIGHT = 2'b01,
        FALLING_LEFT  = 2'b10,
        FALLING_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic (Next State)
    always_comb begin
        case (current_state)
            WALKING_LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (bump_left)
                    next_state = WALKING_RIGHT;
                else
                    next_state = WALKING_LEFT;
            end
            WALKING_RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (bump_right)
                    next_state = WALKING_LEFT;
                else
                    next_state = WALKING_RIGHT;
            end
            FALLING_LEFT: begin
                if (ground)
                    next_state = WALKING_LEFT;
                else
                    next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground)
                    next_state = WALKING_RIGHT;
                else
                    next_state = FALLING_RIGHT;
            end
            default: next_state = WALKING_LEFT; // Default case for safety
        endcase
    end

    // State Flip-Flops
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALKING_LEFT; // Reset state is WALKING_LEFT
        else
            current_state <= next_state;
    end

    // Output Logic
    always_comb begin
        // Default values
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALKING_LEFT: begin
                walk_left = 1;
            end
            WALKING_RIGHT: begin
                walk_right = 1;
            end
            FALLING_LEFT,
            FALLING_RIGHT: begin
                aaah = 1;
            end
        endcase
    end

endmodule
