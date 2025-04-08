module dut (
    input clk,
    input reset,
    input [3:1] s,      // Sensor inputs
    output reg fr3,     // Flow rate outputs
    output reg fr2,
    output reg fr1,
    output reg dfr      // Supplemental flow valve
);
  
    // State encoding for the state machine
    typedef enum reg [1:0] {
        BELOW_S1 = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // On reset, set to BELOW_S1 state and assert all outputs
            current_state <= BELOW_S1;
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;  // All outputs should be asserted
        end else begin
            // State transition
            current_state <= next_state; 
        end
    end

    always @(*) begin
        // Default values for outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        // Determine the next state and output control based on sensor inputs and current state
        case (current_state)
            BELOW_S1: begin
                if (s[1]) begin
                    next_state = BETWEEN_S1_S2;
                end else begin
                    next_state = BELOW_S1;
                    fr3 = 1;
                    fr2 = 1;
                    fr1 = 1;
                end
                // dfr is 1 by default when transitioning from below
                dfr = 1;
            end
            BETWEEN_S1_S2: begin
                if (s[2]) begin
                    next_state = BETWEEN_S2_S3;
                end else if (!s[1]) begin
                    next_state = BELOW_S1;
                end else begin
                    next_state = BETWEEN_S1_S2;
                    fr2 = 1;
                    fr1 = 1;
                    if (current_state == BELOW_S1) dfr = 1; // Increased rate if moving up
                end
            end
            BETWEEN_S2_S3: begin
                if (s[3]) begin
                    next_state = ABOVE_S3;
                end else if (!s[2]) begin
                    next_state = BETWEEN_S1_S2;
                end else begin
                    next_state = BETWEEN_S2_S3;
                    fr1 = 1;
                    if (current_state == BETWEEN_S1_S2) dfr = 1; // Increased rate if moving up
                end
            end
            ABOVE_S3: begin
                if (!s[3]) begin
                    next_state = BETWEEN_S2_S3;
                end else begin
                    next_state = ABOVE_S3;
                end
                // No flow rate when above s[3]
            end
            default: begin
                next_state = BELOW_S1; // Default to safe state
            end
        endcase
    end
endmodule
