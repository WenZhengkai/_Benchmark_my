module dut (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    // Internal state variable to keep track of the previous water level
    reg [1:0] prev_level;

    // Local parameters for the state encoding
    localparam LEVEL_HIGH    = 3'b111;
    localparam LEVEL_MIDHIGH = 3'b011;
    localparam LEVEL_MIDLOW  = 3'b001;
    localparam LEVEL_LOW     = 3'b000;

    // State logic and output generation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the outputs to the condition where water is below s[1]
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
            prev_level <= LEVEL_LOW;
        end else begin
            case (s)
                LEVEL_HIGH: begin
                    // No flow rate inputs are asserted
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                    dfr <= 0;
                end

                LEVEL_MIDHIGH: begin
                    // fr1 is asserted
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                    // Check if the level increased for dfr
                    if (prev_level < LEVEL_MIDHIGH) begin
                        dfr <= 1; // Supplemental flow valve opened
                    end else begin
                        dfr <= 0;
                    end
                end

                LEVEL_MIDLOW: begin
                    // fr1 and fr2 are asserted
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                    // Check if the level increased for dfr
                    if (prev_level < LEVEL_MIDLOW) begin
                        dfr <= 1; // Supplemental flow valve opened
                    end else begin
                        dfr <= 0;
                    end
                end

                LEVEL_LOW: begin
                    // fr1, fr2, and fr3 are asserted
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    // No need to check previous level, always assert dfr here
                    dfr <= 1;
                end

                default: begin
                    // Default to an error state -- treat as below s[1]
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
            endcase

            // Update the previous level for the next cycle
            prev_level <= {s[3], s[2], s[1]};
        end
    end

endmodule
