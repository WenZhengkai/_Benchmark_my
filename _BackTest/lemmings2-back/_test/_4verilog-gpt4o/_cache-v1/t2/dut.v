module dut (
    input clk,
    input areset,       // Asynchronous reset
    input bump_left,    // Bump detect on the left
    input bump_right,   // Bump detect on the right
    input ground,       // Ground detection signal
    output reg walk_left, 
    output reg walk_right,
    output reg aaah
);
    // Declare states for the finite state machine
    typedef enum reg [1:0] {
        WALK_LEFT,       // Walking left
        WALK_RIGHT,      // Walking right
        FALL_LEFT,       // Falling while facing left
        FALL_RIGHT       // Falling while facing right
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // On reset, the Lemming starts walking left
            current_state <= WALK_LEFT;
        end else begin
            // Otherwise, transition to the next state
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT; // Start falling if no ground
                end else if (bump_left) begin
                    next_state = WALK_RIGHT; // Switch to walking right if bumped left
                end else begin
                    next_state = WALK_LEFT; // Continue walking left
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT; // Start falling if no ground
                end else if (bump_right) begin
                    next_state = WALK_LEFT; // Switch to walking left if bumped right
                end else begin
                    next_state = WALK_RIGHT; // Continue walking right
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    next_state = WALK_LEFT; // Resume walking left when ground reappears
                end else begin
                    next_state = FALL_LEFT; // Continue falling
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = WALK_RIGHT; // Resume walking right when ground reappears
                end else begin
                    next_state = FALL_RIGHT; // Continue falling
                end
            end
            default: begin
                next_state = WALK_LEFT; // Default to WALK_LEFT on invalid state
            end
        endcase
    end

    // Output logic
    always @(*) begin
        // Default values for all outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1; // Indicate walking left
            end
            WALK_RIGHT: begin
                walk_right = 1; // Indicate walking right
            end
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1; // Indicate falling
            end
        endcase
    end
endmodule
