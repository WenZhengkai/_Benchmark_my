module dut (
    input               clk,        // Clock input
    input               rst_n,      // Active-low reset signal
    input   [7:0]       data_in,    // 8-bit input data
    input               valid_in,   // Input signal validity indicator
    output reg          valid_out,  // Output signal validity indicator
    output reg [9:0]    data_out    // 10-bit output data
);

    // Internal registers
    reg [9:0] sum;      // 10-bit register to store accumulation result
    reg [1:0] count;     // 2-bit counter to count the number of valid inputs received

    // Initialize outputs and internal registers on reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Active-low reset
            sum        <= 10'b0;  // Clear the sum
            count      <= 2'b0;   // Clear the counter
            valid_out  <= 1'b0;   // Clear valid_out
            data_out   <= 10'b0;  // Clear data_out
        end else begin
            // Normal operation
            if (valid_in) begin
                // Accumulate data when valid_in is 1
                sum   <= sum + data_in;
                count <= count + 1;

                if (count == 3) begin
                    // 4 valid inputs received, output the result
                    data_out   <= sum + data_in;  // Include the last data in the sum
                    valid_out  <= 1'b1;          // Set valid_out for 1 cycle
                    sum        <= 10'b0;         // Clear the sum for the next accumulation
                    count      <= 2'b0;          // Reset the counter
                end else begin
                    // Less than 4 inputs collected, keep valid_out low
                    valid_out <= 1'b0;
                end
            end else begin
                // When valid_in is low, make sure valid_out remains low
                valid_out <= 1'b0;
            end
        end
    end

endmodule
