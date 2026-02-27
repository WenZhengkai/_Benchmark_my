module dut (
    input        clk,         // Clock input
    input        rst_n,       // Active-low reset signal
    input  [7:0] data_in,     // 8-bit input data
    input        valid_in,    // Input signal indicating readiness for new data
    output reg   valid_out,   // Output signal set high for 1 cycle when 4 data are accumulated
    output reg [9:0] data_out // 10-bit accumulated result of 4 input data
);

    // Internal Registers
    reg [1:0]   count;        // Counter to keep track of the number of valid inputs (0 to 3)
    reg [9:0]   accumulator;  // Register to hold the accumulated sum of 4 data inputs

    // Sequential Logic: Synchronize with clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all internal signals and outputs
            count       <= 2'b0;
            accumulator <= 10'b0;
            data_out    <= 10'b0;
            valid_out   <= 1'b0;
        end else begin
            if (valid_in) begin
                // Add incoming data to accumulator
                accumulator <= accumulator + data_in;

                // Increment the count of valid inputs
                count <= count + 1;

                // When 4 valid inputs are accumulated
                if (count == 2'b11) begin
                    // Load the accumulated result to the output
                    data_out  <= accumulator + data_in;

                    // Set output valid signal (valid_out) high for one cycle
                    valid_out <= 1;

                    // Reset count and accumulator for the next set of data
                    count       <= 2'b0;
                    accumulator <= 10'b0;
                end else begin
                    // Keep valid_out low when accumulation is in progress
                    valid_out <= 1'b0;
                end
            end else begin
                // If valid_in is not high, no input is valid; keep all outputs stable
                valid_out <= 1'b0;
            end
        end
    end

endmodule
