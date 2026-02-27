module dut (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,
    output reg [2:0] g
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // State and Next State variables
    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A; // Active-low reset
        else
            current_state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        g = 3'b000;

        case (current_state)
            A: begin
                if (r[0])
                    next_state = B;
                else if (r[1])
                    next_state = C;
                else if (r[2])
                    next_state = D;
            end
            B: begin
                g = 3'b001; // grant device 0
                if (!r[0])
                    next_state = A;
            end
            C: begin
                g = 3'b010; // grant device 1
                if (!r[1])
                    next_state = A;
            end
            D: begin
                g = 3'b100; // grant device 2
                if (!r[2])
                    next_state = A;
            end
        endcase
    end

endmodule
