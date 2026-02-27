module dut (
    input wire clk,            // Clock signal
    input wire rst_n,          // Active-low reset signal
    input wire [3:0] d,        // 4-bit parallel data input
    output reg valid_out,      // Valid signal indicating the availability of serial output
    output reg dout            // Serial output representing the converted data
);

    // Internal Registers
    reg [3:0] data;            // Data register to hold and shift the input parallel data
    reg [1:0] cnt;             // 2-bit counter to track output cycles (0 to 3)

    // Sequential Logic - Synchronous reset and operations
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers to their initial state
            cnt <= 2'b00;      // Initialize counter to 0
            data <= 4'b0000;   // Clear data register
            dout <= 1'b0;      // Clear serial output
            valid_out <= 1'b0; // Clear valid signal
        end else begin
            if (cnt == 2'b11) begin
                // If counter reaches 3 (last output bit in the sequence)
                data <= d;       // Load new parallel data into data register
                dout <= d[3];    // Output MSB of the new parallel input
                cnt <= 2'b00;    // Reset counter to 0
                valid_out <= 1'b1; // Set valid signal to indicate new serial output
            end else begin
                // For other cycles, continue shifting data to generate serial output
                dout <= data[3];   // Output the MSB of the current data register
                data <= {data[2:0], 1'b0}; // Shift data register left by 1 bit
                cnt <= cnt + 1;    // Increment the counter
                valid_out <= 1'b0; // Keep valid_out low
            end
        end
    end

endmodule
