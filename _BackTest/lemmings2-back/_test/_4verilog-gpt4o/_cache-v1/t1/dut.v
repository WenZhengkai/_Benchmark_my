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

    // Define the states for the FSM
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,  // Walking left
        WALK_RIGHT = 2'b01, // Walking right
        FALL_LEFT = 2'b10,  // Falling while previously walking left
        FALL_RIGHT = 2'b11  // Falling while previously walking right
    } state_t;

    // Current state and next state
    state_t current_state, next_state;

    // State transition logic (Combinational Always Block)
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (ground == 0) begin
                    next_state = FALL_LEFT;  // Start falling while moving left
                end else if (bump_left) begin
                    next_state = WALK_RIGHT; // Hit obstacle on left, switch to right
                end else begin
                    next_state = WALK_LEFT;  // Continue walking left
                end
            end
            WALK_RIGHT: begin
                if (ground == 0) begin
                    next_state = FALL_RIGHT; // Start falling while moving right
                end else if (bump_right) begin
                    next_state = WALK_LEFT; // Hit obstacle on right, switch to left
                end else begin
                    next_state = WALK_RIGHT; // Continue walking right
                end
            end
            FALL_LEFT: begin
                if (ground == 1) begin
                    next_state = WALK_LEFT; // Ground reappears, resume walking left
                end else begin
                    next_state = FALL_LEFT; // Continue falling while previously moving left
                end
            end
            FALL_RIGHT: begin
                if (ground == 1) begin
                    next_state = WALK_RIGHT; // Ground reappears, resume walking right
                end else begin
                    next_state = FALL_RIGHT; // Continue falling while previously moving right
                end
            end
            default: begin
                next_state = WALK_LEFT; // Default state in case of invalid state
            end
        endcase
    end

    // State Update Logic (Sequential Always Block)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Asynchronous reset to walking left
        end else begin
            current_state <= next_state; // Update state on clock edge
        end
    end

    // Output Logic (Combinational Always Block)
    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;  // Walking left
            end
            WALK_RIGHT: begin
                walk_right = 1; // Walking right
            end
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1;       // Falling
            end
        endcase
    end

endmodule
