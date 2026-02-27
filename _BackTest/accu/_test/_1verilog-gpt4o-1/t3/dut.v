module dut (
    input          clk,          // Clock input
    input          rst_n,        // Active-low reset
    input          valid_in,     // Valid input signal
    input  [7:0]   data_in,      // 8-bit input data
    output         valid_out,    // Valid output signal
    output [9:0]   data_out      // 10-bit accumulated output
);

    // Internal signals
    reg [9:0]      sum_reg;      // 10-bit register to hold the accumulated sum
    reg [1:0]      count;        // Counter to count the number of valid inputs (0 to 3)
    reg            valid_out_reg;// Register for valid_out signal

    // Assign output signals to internal registers
    assign data_out = sum_reg;
    assign valid_out = valid_out_reg;

    // Sequential always block for synchronous reset, accumulation, and output
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all signals to their initial states
            sum_reg <= 10'b0;
            count <= 2'b0;
            valid_out_reg <= 1'b0;
        end else begin
            // Default valid_out_reg to 0 each cycle (will only be set to 1 during output cycle)
            valid_out_reg <= 1'b0;

            if (valid_in) begin
                // Add the input data_in to the current sum
                sum_reg <= sum_reg + data_in;

                // Increment the count
                count <= count + 2'b1;

                // If 4 valid inputs have been accumulated
                if (count == 2'd3) begin
                    // Set valid_out to 1 for one cycle
                    valid_out_reg <= 1'b1;

                    // Prepare for the next accumulation
                    count <= 2'b0;      // Reset the count
                    sum_reg <= 10'b0;   // Reset the sum
                end
            end
        end
    end

endmodule
