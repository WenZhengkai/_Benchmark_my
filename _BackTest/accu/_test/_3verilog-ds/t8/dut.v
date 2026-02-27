module dut (
    input               clk,
    input               rst_n,
    input       [7:0]   data_in,
    input               valid_in,
    output reg          valid_out,
    output reg  [9:0]   data_out
);

    reg [1:0]   count;          // Counter to track number of received inputs (0-3)
    reg [9:0]   accumulator;    // Accumulator for the sum (needs 10 bits to avoid overflow)
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            count       <= 2'b00;
            accumulator <= 10'b0;
            data_out   <= 10'b0;
            valid_out   <= 1'b0;
        end
        else begin
            // Default assignment for valid_out (only pulses for one cycle)
            valid_out <= 1'b0;
            
            if (valid_in) begin
                // When valid input arrives
                if (count == 2'b11) begin
                    // On 4th input (count=3), output the accumulated sum + new input
                    data_out   <= accumulator + data_in;
                    valid_out  <= 1'b1;        // Pulse valid_out
                    accumulator <= 10'b0;       // Reset accumulator
                    count      <= 2'b00;       // Reset counter
                end
                else begin
                    // For 1st-3rd inputs, accumulate and increment counter
                    accumulator <= accumulator + data_in;
                    count      <= count + 1'b1;
                end
            end
        end
    end

endmodule