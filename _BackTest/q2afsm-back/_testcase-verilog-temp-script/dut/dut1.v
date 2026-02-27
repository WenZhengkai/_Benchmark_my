module dut (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// Define states
typedef enum {
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_D
} state_t;

// State registers
state_t current_state, next_state;

// State transition logic
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        current_state <= STATE_A;
    end else begin
        current_state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    // Default outputs
    g = 3'b000;
    next_state = current_state;
    
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
        
        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
