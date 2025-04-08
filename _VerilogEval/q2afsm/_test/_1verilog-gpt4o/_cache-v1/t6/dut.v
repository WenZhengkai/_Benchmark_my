module dut (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,
    output reg [2:0] g
);

    // State Encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;  // Reset to state A on resetn
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
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
                if (!r[0])
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_C: begin
                if (!r[1])
                    next_state = STATE_A;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                if (!r[2])
                    next_state = STATE_A;
                else
                    next_state = STATE_D;
            end
            default: next_state = STATE_A;  // Default state
        endcase
    end

    // Output Logic
    always @(*) begin
        g = 3'b000;  // Default value for g
        case (current_state)
            STATE_B: g = 3'b001;  // g0 = 1 in State B
            STATE_C: g = 3'b010;  // g1 = 1 in State C
            STATE_D: g = 3'b100;  // g2 = 1 in State D
        endcase
    end

endmodule
