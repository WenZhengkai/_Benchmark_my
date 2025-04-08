module dut(
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding for water levels
    typedef enum logic [1:0] {
        BELOW_S1 = 2'b00,   // Below s[1]
        BETWEEN_S1_S2 = 2'b01,  // Between s[2] and s[1]
        BETWEEN_S2_S3 = 2'b10,  // Between s[3] and s[2]
        ABOVE_S3 = 2'b11     // Above s[3]
    } state_t;

    state_t state, next_state;
    logic [3:1] prev_s;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BELOW_S1;
            prev_s <= 3'b000;
        end else begin
            state <= next_state;
            prev_s <= s;
        end
    end

    // Combinational logic for state determination and output logic
    always @(*) begin
        // Default outputs
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
        
        // Determine the next state based on current sensors
        case (s)
            3'b111: begin // Above s[3]
                next_state = ABOVE_S3;
            end
            3'b011: begin // Between s[3] and s[2]
                next_state = BETWEEN_S2_S3;
            end
            3'b001: begin // Between s[2] and s[1]
                next_state = BETWEEN_S1_S2;
            end
            default: begin // Below s[1]
                next_state = BELOW_S1;
            end
        endcase

        // Determine outputs based on current state and history
        case (state)
            ABOVE_S3: begin
                // No flow, all outputs remain zero
            end
            BETWEEN_S2_S3: begin
                fr1 = 1'b1;
                if (prev_s == 3'b001 || prev_s == 3'b000) begin
                    dfr = 1'b1;
                end
            end
            BETWEEN_S1_S2: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                if (prev_s == 3'b000) begin
                    dfr = 1'b1;
                end
            end
            BELOW_S1: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
                dfr = 1'b1;
            end
            default: begin
                // Default case if needed
            end
        endcase
    end
endmodule
