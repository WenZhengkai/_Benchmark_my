module dut (
    input clk,
    input resetn,
    input [2:0] r,  // Request inputs from the three devices
    output reg [2:0] g  // Grant outputs to the three devices
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01, // Grant for device 0
        STATE_C = 2'b10, // Grant for device 1
        STATE_D = 2'b11  // Grant for device 2
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        g = 3'b000;

        case (current_state)
            STATE_A: begin
                if (r[0])
                    next_state = STATE_B;
                else if (r[1])
                    next_state = STATE_C;
                else if (r[2])
                    next_state = STATE_D;
            end

            STATE_B: begin
                g[0] = 1'b1;  // Grant device 0
                if (!r[0])
                    next_state = STATE_A;
            end

            STATE_C: begin
                g[1] = 1'b1;  // Grant device 1
                if (!r[1])
                    next_state = STATE_A;
            end

            STATE_D: begin
                g[2] = 1'b1;  // Grant device 2
                if (!r[2])
                    next_state = STATE_A;
            end
        endcase
    end

endmodule
