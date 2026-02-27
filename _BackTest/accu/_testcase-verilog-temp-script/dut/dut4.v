module dut (
    input clk,               // Clock input
    input rst_n,             // Active-low reset
    input [7:0] data_in,     // 8-bit input data
    input valid_in,          // Input signal indicating readiness for new data
    output reg valid_out,    // Output signal indicating 4 data accumulation complete
    output reg [9:0] data_out // 10-bit output data representing the accumulated sum
);
    // Internal signals
    reg [9:0] accumulator; // 10-bit accumulator to hold the sum 
    reg [1:0] count;       // Counter to keep track of how many valid inputs have been received

    // Synchronous logic
    always @(posedge clk or negedge rst_n) begin
        // Reset logic
        if (!rst_n) begin
            accumulator <= 10'd0;       // Clear accumulator
            count <= 2'd0;             // Clear counter
            data_out <= 10'd0;         // Clear output
            valid_out <= 1'b0;         // Clear valid output signal
        end else begin
            if (valid_in) begin
                // Add data_in to the accumulator and increment the count
                accumulator <= accumulator + data_in;
                count <= count + 1;

                // When 4 valid inputs have been accumulated
                if (count == 2'd3) begin
                    data_out <= accumulator + data_in; // Output the final accumulated result
                    valid_out <= 1'b1;                 // Set valid_out high for one cycle
                    accumulator <= 10'd0;              // Reset the accumulator
                    count <= 2'd0;                     // Reset the count
                end else begin
                    valid_out <= 1'b0; // Keep valid_out low until accumulation is complete
                end
            end else begin
                valid_out <= 1'b0; // Keep valid_out low if valid_in is not set
            end
        end
    end
endmodule
