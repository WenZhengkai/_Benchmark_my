module dut(
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

    state_t current_state, next_state;

    // Sequential part: State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational part: Next state logic and output logic
    always @(*) begin
        // Default values for the next state and output
        next_state = current_state;
        g = 3'b000;
        
        case (current_state)
            STATE_A: begin
                if (r[0]) begin
                    next_state = STATE_B;
                end else if (r[1]) begin
                    next_state = STATE_C;
                end else if (r[2]) begin
                    next_state = STATE_D;
                end
            end
            STATE_B: begin
                g = 3'b001; // Grant to device 0
                if (!r[0]) begin
                    next_state = STATE_A;
                end
            end
            STATE_C: begin
                g = 3'b010; // Grant to device 1
                if (!r[1]) begin
                    next_state = STATE_A;
                end
            end
            STATE_D: begin
                g = 3'b100; // Grant to device 2
                if (!r[2]) begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_A; // Default to State A on undefined state
            end
        endcase
    end

endmodule
