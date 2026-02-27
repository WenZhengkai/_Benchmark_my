module dut (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

    // Define states
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State register
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        // Default values
        next_state = state;
        g = 3'b000;

        case (state)
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
                g[0] = 1'b1;
                if (!r[0]) begin
                    next_state = STATE_A;
                end
            end

            STATE_C: begin
                g[1] = 1'b1;
                if (!r[1]) begin
                    next_state = STATE_A;
                end
            end

            STATE_D: begin
                g[2] = 1'b1;
                if (!r[2]) begin
                    next_state = STATE_A;
                end
            end
        endcase
    end

endmodule
