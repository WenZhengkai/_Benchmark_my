module dut (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// Define states
typedef enum logic [1:0] {
    A = 2'b00,
    B = 2'b01,
    C = 2'b10,
    D = 2'b11
} state_t;

// State registers
state_t current_state, next_state;

// Synchronous state transition
always @(posedge clk) begin
    if (!resetn) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    // Default values
    next_state = current_state;
    g = 3'b000;
    
    case (current_state)
        A: begin
            if (r[0]) begin
                next_state = B;
            end else if (!r[0] && r[1]) begin
                next_state = C;
            end else if (!r[0] && !r[1] && r[2]) begin
                next_state = D;
            end
        end
        
        B: begin
            g[0] = 1'b1;
            if (!r[0]) begin
                next_state = A;
            end
        end
        
        C: begin
            g[1] = 1'b1;
            if (!r[1]) begin
                next_state = A;
            end
        end
        
        D: begin
            g[2] = 1'b1;
            if (!r[2]) begin
                next_state = A;
            end
        end
        
        default: begin
            next_state = A;
        end
    endcase
end

endmodule
