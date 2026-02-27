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

    // Define states using an enumerated type
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL_LEFT = 2'b10,
        FALL_RIGHT = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transitions (sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT; // Reset to walking left
        end else begin
            state <= next_state; // Update to the next state
        end
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT; // Begin falling
                end else if (bump_left) begin
                    next_state = WALK_RIGHT; // Turn around
                end else begin
                    next_state = WALK_LEFT; // Keep walking left
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT; // Begin falling
                end else if (bump_right) begin
                    next_state = WALK_LEFT; // Turn around
                end else begin
                    next_state = WALK_RIGHT; // Keep walking right
                end
            end

            FALL_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT; // Land and resume walking left
                end else begin
                    next_state = FALL_LEFT; // Keep falling
                end
            end

            FALL_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT; // Land and resume walking right
                end else begin
                    next_state = FALL_RIGHT; // Keep falling
                end
            end

            default: begin
                next_state = WALK_LEFT; // Default state (should not happen)
            end
        endcase
    end

    // Output logic (depends only on the current state)
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (state)
            WALK_LEFT: begin
                walk_left = 1;
            end

            WALK_RIGHT: begin
                walk_right = 1;
            end
            
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1;
            end
        endcase
    end

endmodule
