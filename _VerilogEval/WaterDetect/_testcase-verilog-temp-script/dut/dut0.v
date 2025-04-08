module dut(
    input wire clk,
    input wire reset,
    input wire [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State encoding
    typedef enum reg [1:0] {
        LOW = 2'b00,      // Below s[1]
        MID = 2'b01,      // Between s[2] and s[1]
        HIGH = 2'b10,     // Between s[3] and s[2]
        FULL = 2'b11      // Above s[3]
    } state_t;

    reg [1:0] current_state, next_state;
    reg last_sensors;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= LOW;
            last_sensors <= 3'b000;
        end else begin
            current_state <= next_state;
            last_sensors <= s;
        end
    end

    // Next state logic
    always @(*) begin
        case (s)
            3'b111: next_state = FULL; // Above s[3]
            3'b011: next_state = HIGH; // Between s[3] and s[2]
            3'b001: next_state = MID;  // Between s[2] and s[1]
            default: next_state = LOW; // Below s[1]
        endcase
    end

    // Output logic
    always @(*) begin
        // Default outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (current_state)
            FULL: begin
                // No flow
            end
            HIGH: begin
                fr1 = 1;
                // Increase flow if the previous level was lower
                if (last_sensors < s) begin
                    dfr = 1;
                end
            end
            MID: begin
                fr1 = 1;
                fr2 = 1;
                if (last_sensors < s) begin
                    dfr = 1;
                end
            end
            LOW: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
            end
        endcase
    end

endmodule
