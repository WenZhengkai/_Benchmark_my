module dut (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

    // Define states
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State register
    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (r[0]) begin
                    next_state = STATE_B;
                end else if (r[1]) begin
                    next_state = STATE_C;
                end else if (r[2]) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (r[0]) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_C: begin
                if (r[1]) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_D: begin
                if (r[2]) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default output
        case (current_state)
            STATE_B: g[0] = 1'b1;
            STATE_C: g[1] = 1'b1;
            STATE_D: g[2] = 1'b1;
            default: g = 3'b000;
        endcase
    end

endmodule
