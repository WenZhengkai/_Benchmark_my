module dut (
    input clk,                // Clock input
    input rst_n,              // Active-low reset signal
    input [7:0] data_in,      // 8-bit input data
    input valid_in,           // Indicates readiness of valid input data
    output reg valid_out,     // Indicates when 4 inputs accumulation is ready
    output reg [9:0] data_out // 10-bit accumulated output
);
    // Internal registers
    reg [9:0] accumulator;    // 10-bit accumulator to store the running sum
    reg [1:0] count;          // 2-bit counter to keep track of number of inputs

    // Always block for sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers to their initial states
            accumulator <= 10'd0;
            count <= 2'b00;
            valid_out <= 1'b0;
            data_out <= 10'd0;
        end else begin
            if (valid_in) begin
                // Accumulate data and increment the counter
                accumulator <= accumulator + data_in;
                count <= count + 1;

                if (count == 2'b11) begin
                    // If 4 inputs received (count is 3 before increment):
                    data_out <= accumulator + data_in; // Update output with total sum
                    valid_out <= 1'b1;                 // Set valid_out for 1 cycle
                    accumulator <= 10'd0;             // Reset accumulator
                    count <= 2'b00;                   // Reset counter
                end else begin
                    valid_out <= 1'b0; // Keep valid_out low until 4 inputs are processed
                end
            end else begin
                // If valid_in is not set, ensure valid_out remains low
                valid_out <= 1'b0;
            end
        end
    end
endmodule
