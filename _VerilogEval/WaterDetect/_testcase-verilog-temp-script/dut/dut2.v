module dut (
    input clk,
    input reset,
    input [3:1] s, // Sensor input
    output reg fr3, // Flow rate outputs
    output reg fr2,
    output reg fr1,
    output reg dfr  // Differential flow rate
);

    // States for water levels
    typedef enum logic [1:0] {
        BELOW_S1     = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3     = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    state_t previous_state;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BELOW_S1;
            previous_state <= BELOW_S1;
        end else begin
            current_state <= next_state;
            previous_state <= current_state;
        end
    end

    // Next state logic based on sensors
    always @(*) begin
        case (s)
            3'b000: next_state = BELOW_S1; // No sensors asserted
            3'b001: next_state = BETWEEN_S1_S2; // s[1] asserted
            3'b011: next_state = BETWEEN_S2_S3; // s[1], s[2] asserted
            3'b111: next_state = ABOVE_S3; // s[1], s[2], s[3] asserted
            default: next_state = BELOW_S1; // Shouldn't occur
        endcase
    end

    // Output logic based on current state and previous state
    always @(*) begin
        // Default to not asserting any flow outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (current_state)
            BELOW_S1: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                if (previous_state != BELOW_S1) dfr = 1;
            end
            BETWEEN_S1_S2: begin
                fr2 = 1;
                fr1 = 1;
                if (previous_state == BELOW_S1) dfr = 1;
            end
            BETWEEN_S2_S3: begin
                fr1 = 1;
                if (previous_state == BELOW_S2 || previous_state == BETWEEN_S1_S2) dfr = 1;
            end
            ABOVE_S3: begin
                // No flow rates asserted
            end
            default: begin
                // Shouldn't occur, maintain safe default
            end
        endcase
    end

endmodule
