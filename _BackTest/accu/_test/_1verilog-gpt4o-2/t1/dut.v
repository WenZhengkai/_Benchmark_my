module dut (
    input wire clk,                // Clock input
    input wire rst_n,              // Active-low reset
    input wire valid_in,           // Valid input signal
    input wire [7:0] data_in,      // 8-bit input data
    output reg valid_out,          // Valid output signal
    output reg [9:0] data_out      // 10-bit accumulated data output
);

    // Internal signals/variables
    reg [9:0] sum;                 // 10-bit sum register to store intermediate results
    reg [1:0] count;               // 2-bit counter to count the number of valid inputs received

    // Synchronous logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all signals when reset is active
            sum <= 10'b0;
            count <= 2'b0;
            data_out <= 10'b0;
            valid_out <= 1'b0;
        end else begin
            // Default valid_out to 0 every cycle unless conditions are met
            valid_out <= 1'b0;

            if (valid_in) begin
                // Accumulate data if valid_in is 1
                sum <= sum + data_in;
                count <= count + 1;

                if (count == 2'd3) begin
                    // When 4 data points have been received
                    data_out <= sum + data_in; // Provide the accumulated sum
                    valid_out <= 1'b1;        // Signal valid output
                    sum <= 10'b0;            // Reset sum for the next accumulation
                    count <= 2'b0;           // Reset count
                end
            end
        end
    end
endmodule
