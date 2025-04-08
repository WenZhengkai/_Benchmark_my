module dut (
    input wire clk,
    input wire reset,
    input wire [3:1] s, // sensor inputs
    output reg fr3,     // flow rate control outputs
    output reg fr2,
    output reg fr1,
    output reg dfr      // supplemental flow valve
);

    // State encoding
    typedef enum logic [1:0] {
        LOW   = 2'b00,
        MID   = 2'b01,
        HIGH  = 2'b10,
        ABOVE = 2'b11
    } state_t;

    state_t current_state, next_state;
    state_t prev_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset state: all outputs asserted, similar to a low water level
            current_state <= LOW;
            prev_state <= LOW;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
        end else begin
            // Update the current state based on next state logic
            current_state <= next_state;
            prev_state <= current_state;
        end
    end

    always @(*) begin
        // Default values
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (current_state)
            ABOVE: begin
                if (!s[3]) begin
                    if (s[2]) 
                        next_state = HIGH;
                    else if (s[1])
                        next_state = MID;
                    else
                        next_state = LOW;
                end else begin
                    next_state = ABOVE;
                end
            end

            HIGH: begin
                fr1 = 1;
                if (prev_state == MID || prev_state == LOW) dfr = 1;

                if (s[3]) 
                    next_state = ABOVE;
                else if (!s[2]) 
                    next_state = MID;
                else 
                    next_state = HIGH;
            end

            MID: begin
                fr1 = 1;
                fr2 = 1;
                if (prev_state == LOW) dfr = 1;

                if (s[2])
                    next_state = HIGH;
                else if (!s[1])
                    next_state = LOW;
                else
                    next_state = MID;
            end

            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;

                if (s[1])
                    next_state = MID;
                else
                    next_state = LOW;
            end

            default: begin
                next_state = LOW;
            end
        endcase
    end
endmodule
