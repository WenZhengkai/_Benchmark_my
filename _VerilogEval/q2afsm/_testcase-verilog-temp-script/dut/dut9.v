module dut (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;  // synchronous reset to state A
        else
            state <= next_state;
    end

    // Combinatorial logic for state transitions and output assignments
    always @(*) begin
        // Default output
        g = 3'b000;
        next_state = state;  // Default to no state change

        case (state)
            STATE_A: begin
                if (r[0]) 
                    next_state = STATE_B;
                else if (r[1])
                    next_state = STATE_C;
                else if (r[2])
                    next_state = STATE_D;
                // If no requests, remain in STATE_A
            end

            STATE_B: begin
                g[0] = 1;
                if (!r[0])
                    next_state = STATE_A;  // Return to A if request is no longer present
                // Otherwise, stay in STATE_B
            end

            STATE_C: begin
                g[1] = 1;
                if (!r[1])
                    next_state = STATE_A;  // Return to A if request is no longer present
                // Otherwise, stay in STATE_C
            end

            STATE_D: begin
                g[2] = 1;
                if (!r[2])
                    next_state = STATE_A;  // Return to A if request is no longer present
                // Otherwise, stay in STATE_D
            end
            
            default: 
                next_state = STATE_A;  // Default back to state A
        endcase
    end
endmodule
