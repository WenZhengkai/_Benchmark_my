module dut (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding for the levels
    typedef enum logic [1:0] {
        ABOVE_S3   = 2'd0,
        BETWEEN_S3_S2 = 2'd1,
        BETWEEN_S2_S1 = 2'd2,
        BELOW_S1   = 2'd3
    } state_t;

    state_t current_state, next_state;

    // Logic to determine the next state and outputs
    always_comb begin
        // Default assignments for outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;
        next_state = current_state;

        case (current_state)
            ABOVE_S3: begin
                // No sensors change, NOP
                // Outputs: none
                if (~s[3] && s[2]) begin
                    next_state = BETWEEN_S3_S2;
                end
            end

            BETWEEN_S3_S2: begin
                // Outputs: fr1
                fr1 = 1;
                if (s[3]) begin
                    next_state = ABOVE_S3;
                end else if (~s[2] && s[1]) begin
                    next_state = BETWEEN_S2_S1;
                end
            end

            BETWEEN_S2_S1: begin
                // Outputs: fr1, fr2
                fr1 = 1;
                fr2 = 1;
                if (s[2]) begin
                    next_state = BETWEEN_S3_S2;
                end else if (~s[1]) begin
                    next_state = BELOW_S1;
                end
            end

            BELOW_S1: begin
                // Outputs: fr1, fr2, fr3, dfr
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
                if (s[1]) begin
                    next_state = BETWEEN_S2_S1;
                end
            end

            default: begin
                next_state = BELOW_S1;
            end
        endcase
    end

    // State transition based on clock and reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BELOW_S1;
        end else begin
            current_state <= next_state;
        end
    end

endmodule
