module dut (
    input               clk,
    input               rst_n,
    input       [7:0]   data_in,
    input               valid_in,
    output reg          valid_out,
    output reg  [9:0]    data_out
);

    reg [1:0]   count;          // Counter to track number of received inputs (0-3)
    reg [9:0]   accumulator;    // Accumulator for the sum (needs 10 bits to avoid overflow)
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers
            count       <= 2'b00;
            accumulator <= 10'b0;
            data_out    <= 10'b0;
            valid_out   <= 1'b0;
        end
        else begin
            // Default value for valid_out (only pulses for one cycle)
            valid_out <= 1'b0;
            
            if (valid_in) begin
                // Accumulate the input data
                accumulator <= accumulator + data_in;
                
                // Increment the counter
                if (count == 2'b11) begin
                    // When we've received 4 inputs (count = 3)
                    count <= 2'b00;
                    
                    // Output the accumulated sum
                    data_out <= accumulator + data_in;
                    
                    // Pulse valid_out for one cycle
                    valid_out <= 1'b1;
                    
                    // Reset accumulator for next set of inputs
                    accumulator <= 10'b0;
                end
                else begin
                    count <= count + 1'b1;
                end
            end
        end
    end

endmodule