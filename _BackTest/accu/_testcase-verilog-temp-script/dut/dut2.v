module dut (
    input wire clk,                // Clock input for synchronization
    input wire rst_n,              // Active-low reset signal
    input wire [7:0] data_in,      // 8-bit input data
    input wire valid_in,           // Input signal indicating readiness for new data
    output reg valid_out,          // Output signal indicating when 4-input data accumulation is reached
    output reg [9:0] data_out      // 10-bit output data representing the accumulated sum
);

    // Internal signals
    reg [1:0] count;               // Counter to count the number of valid inputs (2 bits are enough for 4 values)
    reg [9:0] sum;                 // Accumulator to store the sum of 4 data inputs

    // Synchronous process
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic
            count <= 2'b0;         // Reset the count
            sum <= 10'b0;          // Reset the accumulator
            valid_out <= 1'b0;     // Reset valid_out
            data_out <= 10'b0;     // Reset data_out
        end else begin
            if (valid_in) begin
                // Accumulate input data and increment counter
                sum <= sum + data_in;
                count <= count + 1;

                if (count == 2'b11) begin
                    // Four valid inputs reached, output the accumulated sum
                    data_out <= sum + data_in; // Include the last input in the sum
                    valid_out <= 1'b1;         // Set valid_out for one cycle

                    // Reset for the next accumulation
                    count <= 2'b0;
                    sum <= 10'b0;
                end else begin
                    valid_out <= 1'b0;         // Clear valid_out if not outputting
                end
            end else begin
                valid_out <= 1'b0;             // Clear valid_out if valid_in is not set
            end
        end
    end

endmodule
