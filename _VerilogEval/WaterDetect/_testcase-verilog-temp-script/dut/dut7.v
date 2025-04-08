module dut(
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding for the water levels
    typedef enum reg [1:0] {
        BELOW_S1 = 2'b00,
        BETWEEN_S1_S2 = 2'b01,
        BETWEEN_S2_S3 = 2'b10,
        ABOVE_S3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            ABOVE_S3: begin
                if (s == 3'b110) // Just s[3] and s[2] are sensed
                    next_state = BETWEEN_S2_S3;
                else if (s == 3'b100) // Only s[3] is sensed
                    next_state = BETWEEN_S1_S2;
                else if (s == 3'b000) // No sensors are sensed
                    next_state = BELOW_S1;
                else
                    next_state = ABOVE_S3;
            end
            
            BETWEEN_S2_S3: begin
                if (s == 3'b111) // All sensors are sensed
                    next_state = ABOVE_S3;
                else if (s == 3'b100) // Only s[3] is sensed
                    next_state = BETWEEN_S1_S2;
                else if (s == 3'b000) // No sensors are sensed
                    next_state = BELOW_S1;
                else
                    next_state = BETWEEN_S2_S3;
            end
            
            BETWEEN_S1_S2: begin
                if (s == 3'b111) // All sensors are sensed
                    next_state = ABOVE_S3;
                else if (s == 3'b110) // Just s[3] and s[2] are sensed
                    next_state = BETWEEN_S2_S3;
                else if (s == 3'b000) // No sensors are sensed
                    next_state = BELOW_S1;
                else
                    next_state = BETWEEN_S1_S2;
            end
            
            BELOW_S1: begin
                if (s == 3'b111) // All sensors are sensed
                    next_state = ABOVE_S3;
                else if (s == 3'b110) // Just s[3] and s[2] are sensed
                    next_state = BETWEEN_S2_S3;
                else if (s == 3'b100) // Only s[3] is sensed
                    next_state = BETWEEN_S1_S2;
                else
                    next_state = BELOW_S1;
            end
            
            default: next_state = BELOW_S1;
        endcase
    end

    // Output logic based on state
    always @(*) begin
        case (current_state)
            ABOVE_S3: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b0;
                dfr = 1'b0;
            end
            
            BETWEEN_S2_S3: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b1;
                dfr = (current_state == BELOW_S1) ? 1'b1 : 1'b0; // Supplemental flow valve opened if coming from below
            end
            
            BETWEEN_S1_S2: begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = (current_state == BELOW_S1) ? 1'b1 : 1'b0; // Supplemental flow valve opened if coming from below
            end
            
            BELOW_S1: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
            
            default: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= BELOW_S1;
        else
            current_state <= next_state;
    end

endmodule
