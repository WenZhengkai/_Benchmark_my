module dut(
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

    // Define state encoding
    typedef enum reg [1:0] {
        A = 2'd0,
        B = 2'd1,
        C = 2'd2,
        D = 2'd3
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic for next state logic and outputs
    always @(*) begin
        // Default outputs
        g = 3'b000;
        
        case (state)
            A: begin
                if (r[0])
                    next_state = B;
                else if (r[1])
                    next_state = C;
                else if (r[2])
                    next_state = D;
                else
                    next_state = A;
            end

            B: begin
                g[0] = 1'b1;
                if (r[0])
                    next_state = B;
                else
                    next_state = A;
            end

            C: begin
                g[1] = 1'b1;
                if (r[1])
                    next_state = C;
                else
                    next_state = A;
            end

            D: begin
                g[2] = 1'b1;
                if (r[2])
                    next_state = D;
                else
                    next_state = A;
            end

            default: next_state = A;
        endcase
    end

endmodule
