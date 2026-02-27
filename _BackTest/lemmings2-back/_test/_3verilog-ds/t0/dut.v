module dut (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    // Define states
    typedef enum logic [1:0] {
        LEFT,
        RIGHT,
        FALL_LEFT,
        FALL_RIGHT
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic
    always_comb begin
        case (current_state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end
                else if (bump_left) begin
                    next_state = RIGHT;
                end
                else begin
                    next_state = LEFT;
                end
            end
            
            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end
                else if (bump_right) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = RIGHT;
                end
            end
            
            FALL_LEFT: begin
                if (ground) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = FALL_LEFT;
                end
            end
            
            FALL_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT;
                end
                else begin
                    next_state = FALL_RIGHT;
                end
            end
            
            default: next_state = LEFT;
        endcase
    end
    
    // State register with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= LEFT;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    // Output logic (Moore machine - outputs depend only on current state)
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
    assign aaah = (current_state == FALL_LEFT || current_state == FALL_RIGHT);
    
endmodule