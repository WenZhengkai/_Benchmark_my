module dut (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,
    output reg [2:0] g
);

// Define the states
typedef enum reg [1:0] {
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11
} state_t;

// Declare state variable
state_t current_state, next_state;

// State transition logic
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
            if (r[0] == 1'b1) begin
                next_state = STATE_B;
            end else if (r[1] == 1'b1) begin
                next_state = STATE_C;
            end else if (r[2] == 1'b1) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (r[0] == 1'b1) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_C: begin
            if (r[1] == 1'b1) begin
                next_state = STATE_C;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_D: begin
            if (r[2] == 1'b1) begin
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
    case (current_state)
        STATE_A: begin
            g = 3'b000;
        end
        STATE_B: begin
            g = 3'b001;
        end
        STATE_C: begin
            g = 3'b010;
        end
        STATE_D: begin
            g = 3'b100;
        end
        default: begin
            g = 3'b000;
        end
    endcase
end

endmodule
