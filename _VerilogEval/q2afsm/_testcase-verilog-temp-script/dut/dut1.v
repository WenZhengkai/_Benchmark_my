module dut(
    input wire clk,
    input wire resetn,
    input wire [2:0] r,
    output reg [2:0] g
);

    // State declaration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Combinational logic for state transitions
    always @(*) begin
        case (current_state)
            A: begin
                if (r[0]) begin
                    next_state = B;
                end else if (r[1]) begin
                    next_state = C;
                end else if (r[2]) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end

            B: begin
                if (~r[0]) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end

            C: begin
                if (~r[1]) begin
                    next_state = A;
                end else begin
                    next_state = C;
                end
            end

            D: begin
                if (~r[2]) begin
                    next_state = A;
                end else begin
                    next_state = D;
                end
            end

            default: next_state = A;
        endcase
    end

    // Sequential logic for state updates
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic based on current state
    always @(*) begin
        g = 3'b000; // Default no grants
        case (current_state)
            B: g = 3'b001; // Grant to device 0
            C: g = 3'b010; // Grant to device 1
            D: g = 3'b100; // Grant to device 2
            default: g = 3'b000; // No grant
        endcase
    end

endmodule
