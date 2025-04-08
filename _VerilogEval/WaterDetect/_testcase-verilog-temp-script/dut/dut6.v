module dut (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

// Define the state encoding
typedef enum reg [1:0] {
    BELOW_S1       = 2'b00,
    BETWEEN_S1_S2  = 2'b01,
    BETWEEN_S2_S3  = 2'b10,
    ABOVE_S3       = 2'b11
} state_t;

// Current state and next state variables
state_t current_state, next_state;

// Sequential logic for state transitions and reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // When reset is active, set to BELOW_S1 (all outputs should be asserted)
        current_state <= BELOW_S1;
    end else begin
        // Update current state on clock edge
        current_state <= next_state;
    end
end

// Combinational logic for next state and output generation
always @(*) begin
    // Default output and next state values
    fr3 = 1'b0;
    fr2 = 1'b0;
    fr1 = 1'b0;
    dfr = 1'b0;
    next_state = current_state;
    
    case (current_state)
        BELOW_S1: begin
            // All outputs asserted
            fr3 = 1'b1;
            fr2 = 1'b1;
            fr1 = 1'b1;
            if (s[1]) begin
                next_state = BETWEEN_S1_S2; // Transition to next state if sensor 1 is asserted
            end
        end
        
        BETWEEN_S1_S2: begin
            // Nominal flow rate: fr1 and fr2
            fr1 = 1'b1;
            fr2 = 1'b1;
            if (s[2]) begin
                next_state = BETWEEN_S2_S3;
                dfr = 1'b1; // If transitioning from BELOW_S1, increase flow rate
            end else if (!s[1]) begin
                next_state = BELOW_S1;
            end
        end
        
        BETWEEN_S2_S3: begin
            // Nominal flow rate: fr1
            fr1 = 1'b1;
            if (s[3]) begin
                next_state = ABOVE_S3;
                dfr = 1'b1; // If transitioning from BELOW_S1, increase flow rate
            end else if (!s[2]) begin
                next_state = BETWEEN_S1_S2;
            end
        end
        
        ABOVE_S3: begin
            // No flow rate
            if (!s[3]) begin
                next_state = BETWEEN_S2_S3;
            end
        end
    endcase
end

endmodule
