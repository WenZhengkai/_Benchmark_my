module dut(
    input clk,                // Clock input
    input rst_n,              // Active-low reset signal
    input [7:0] data_in,      // 8-bit input data
    input valid_in,           // Input signal indicating readiness for new data
    output reg valid_out,     // Output signal indicating accumulation is ready
    output reg [9:0] data_out // 10-bit accumulated sum output
);

    // Internal signals
    reg [9:0] accumulator;    // Register to hold the accumulated sum
    reg [1:0] count;          // Counter to track the number of received data_in inputs
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all internal and output signals
            accumulator <= 10'b0;
            count <= 2'b0;
            valid_out <= 1'b0;
            data_out <= 10'b0;
        end else begin
            if (valid_in) begin
                // Accumulate data_in and increment the counter
                accumulator <= accumulator + data_in;
                count <= count + 1;

                // Check if 4 data inputs have been accumulated
                if (count == 2'b11) begin // 2'b11 equals a count of 3 (0, 1, 2, 3 = 4 inputs total)
                    data_out <= accumulator + data_in; // Final value includes the 4th input
                    valid_out <= 1'b1; // Set output valid for 1 cycle
                    accumulator <= 10'b0; // Reset the accumulator
                    count <= 2'b0; // Reset the counter
                end else begin
                    valid_out <= 1'b0; // Otherwise keep valid_out low
                end
            end else begin
                // If valid_in is not asserted, ensure outputs are idle
                valid_out <= 1'b0;
            end
        end
    end
endmodule
