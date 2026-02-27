module dut (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,  // requesting devices
    output reg [2:0] g   // grant signals
);

    // Define state encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and output logic
    always @(*) begin
        // Default values
        next_state = current_state;
        g = 3'b000;
        
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
                g = 3'b001; // Grant signal for device 0
                if (!r[0])
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end

            STATE_C: begin
                g = 3'b010; // Grant signal for device 1
                if (!r[1])
                    next_state = STATE_A;
                else
                    next_state = STATE_C;
            end

            STATE_D: begin
                g = 3'b100; // Grant signal for device 2
                if (!r[2])
                    next_state = STATE_A;
                else
                    next_state = STATE_D;
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end
endmodule
