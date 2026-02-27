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

    // Define the states for the finite state machine
    typedef enum reg [1:0] {
        WALK_LEFT = 2'b00,  // Walking left
        WALK_RIGHT = 2'b01, // Walking right
        FALL_LEFT = 2'b10,  // Falling (from walking left)
        FALL_RIGHT = 2'b11  // Falling (from walking right)
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;  // Reset to WALK_LEFT state
        end else begin
            current_state <= next_state; // Update to the next state
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT; // Falling because ground is gone
                end else if (bump_left) begin
                    next_state = WALK_RIGHT; // Switch to walk right
                end else begin
                    walk_left = 1; // Continue walking left
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT; // Falling because ground is gone
                end else if (bump_right) begin
                    next_state = WALK_LEFT; // Switch to walk left
                end else begin
                    walk_right = 1; // Continue walking right
                end
            end

            FALL_LEFT: begin
                aaah = 1; // Falling, so output is "aaah"
                if (ground) begin
                    next_state = WALK_LEFT; // Resume walking left when ground reappears
                end
            end

            FALL_RIGHT: begin
                aaah = 1; // Falling, so output is "aaah"
                if (ground) begin
                    next_state = WALK_RIGHT; // Resume walking right when ground reappears
                end
            end
        endcase
    end

endmodule
