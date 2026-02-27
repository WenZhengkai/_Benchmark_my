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
    // State encoding
    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b00,   // Walking left
        STATE_WALK_RIGHT = 2'b01,   // Walking right
        STATE_FALLING    = 2'b10    // Falling
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_WALK_LEFT;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Default next state is the same as the current state
        next_state = state;

        case (state)
            STATE_WALK_LEFT: begin
                if (!ground)               // Falling scenario
                    next_state = STATE_FALLING;
                else if (bump_left)        // Obstacle on the left
                    next_state = STATE_WALK_RIGHT;
            end

            STATE_WALK_RIGHT: begin
                if (!ground)               // Falling scenario
                    next_state = STATE_FALLING;
                else if (bump_right)       // Obstacle on the right
                    next_state = STATE_WALK_LEFT;
            end

            STATE_FALLING: begin
                if (ground)                // Ground reappears
                    next_state = (walk_left ? STATE_WALK_LEFT : STATE_WALK_RIGHT);
            end

            default: begin
                next_state = STATE_WALK_LEFT; // Default/fallback state
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left  <= 1'b1;  // Default to walking left on reset
            walk_right <= 1'b0;
            aaah       <= 1'b0;
        end else begin
            case (next_state)
                STATE_WALK_LEFT: begin
                    walk_left  <= 1'b1;
                    walk_right <= 1'b0;
                    aaah       <= 1'b0;
                end

                STATE_WALK_RIGHT: begin
                    walk_left  <= 1'b0;
                    walk_right <= 1'b1;
                    aaah       <= 1'b0;
                end

                STATE_FALLING: begin
                    walk_left  <= walk_left; // Maintain direction during fall
                    walk_right <= walk_right;
                    aaah       <= 1'b1;
                end
            endcase
        end
    end

endmodule
