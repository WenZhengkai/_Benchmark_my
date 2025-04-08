module dut (
    input        clk,
    input        resetn,
    input  [2:0] r,    // Request inputs from three devices
    output reg [2:0] g // Grant outputs for three devices
);

    // State encoding for better readability
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @ (posedge clk or negedge resetn) begin
        if (!resetn) 
            current_state <= STATE_A;
        else 
            current_state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        // Default grant outputs
        g = 3'b000;

        case (current_state)
            STATE_A: begin
                if (r[0]) 
                    next_state = STATE_B;
                else if (r[1]) 
                    next_state = STATE_C;
                else if (r[2]) 
                    next_state = STATE_D;
                else 
                    next_state = STATE_A;
            end

            STATE_B: begin
                g = 3'b001; // g[0] = 1
                if (r[0]) 
                    next_state = STATE_B;
                else 
                    next_state = STATE_A;
            end

            STATE_C: begin
                g = 3'b010; // g[1] = 1
                if (r[1]) 
                    next_state = STATE_C;
                else 
                    next_state = STATE_A;
            end

            STATE_D: begin
                g = 3'b100; // g[2] = 1
                if (r[2]) 
                    next_state = STATE_D;
                else 
                    next_state = STATE_A;
            end

            default: next_state = STATE_A;
        endcase
    end

endmodule
