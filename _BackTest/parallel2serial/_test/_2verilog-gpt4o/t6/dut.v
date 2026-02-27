module dut (
    input wire clk,         // Clock signal
    input wire rst_n,       // Active-low reset signal
    input wire [3:0] d,     // 4-bit parallel data input
    output reg valid_out,   // Valid signal to indicate serial output validity
    output reg dout         // Serial output
);

    // Internal registers
    reg [3:0] data;         // Data register to hold the parallel input
    reg [1:0] cnt;          // 2-bit counter to track bit position (0 to 3)

    // Synchronous logic for reset and operations
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Active-low reset: Clear all registers
            cnt <= 2'b00;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            if (cnt == 2'b11) begin
                // End of 4-bit sequence reached
                data <= d;                // Load the parallel input into the data register
                cnt <= 2'b00;             // Reset the counter
                valid_out <= 1'b1;        // Set valid_out for the MSB of the new data
                dout <= d[3];             // Output the MSB of the input
            end else begin
                // Normal shifting
                cnt <= cnt + 2'b01;       // Increment the counter
                valid_out <= 1'b1;        // Set valid_out for ongoing serial output
                dout <= data[3];          // Output the MSB of the data register
                data <= {data[2:0], 1'b0}; // Shift the data register to the left
            end
        end
    end

endmodule
