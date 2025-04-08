module dut (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,  // 3-bit input for requests
    output reg [2:0] g   // 3-bit output for grants
);

    // Define state encodings
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State Transition Logic
    always @ (posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;  // Reset to state A
        else
            current_state <= next_state;
    end

    // Next State and Output Logic
    always @ (*) begin
        // Default values for next_state and outputs
        next_state = current_state;
        g = 3'b000;

        case (current_state)
            STATE_A: begin
                if (r[0])
                    next_state = STATE_B;  // Highest priority: device 0
                else if (r[1])
                    next_state = STATE_C;  // Next priority: device 1
                else if (r[2])
                    next_state = STATE_D;  // Lowest priority: device 2
                // else stay in STATE_A
            end

            STATE_B: begin
                g = 3'b001;  // g0=1, grant to device 0
                if (!r[0])
                    next_state = STATE_A;
                // else stay in STATE_B
            end

            STATE_C: begin
                g = 3'b010;  // g1=1, grant to device 1
                if (!r[1])
                    next_state = STATE_A;
                // else stay in STATE_C
            end

            STATE_D: begin
                g = 3'b100;  // g2=1, grant to device 2
                if (!r[2])
                    next_state = STATE_A;
                // else stay in STATE_D
            end

            default: begin
                next_state = STATE_A;  // Safety fallback
            end
        endcase
    end
endmodule
