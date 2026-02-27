module dut(
    input  wire       clk,        // Clock signal
    input  wire       rst_n,      // Active-low reset
    input  wire [3:0] d,          // 4-bit parallel data input
    output reg        valid_out,  // Valid signal indicating serial output is available
    output reg        dout        // Serial output
);

    // Internal registers
    reg [3:0] data; // Register to hold the current data being serialized
    reg [1:0] cnt;  // 2-bit counter (for tracking 4 states: 0, 1, 2, 3)

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic
            data <= 4'b0000;        // Clear data register
            dout <= 1'b0;           // Clear serial output
            cnt <= 2'b00;           // Reset counter
            valid_out <= 1'b0;      // Clear valid signal
        end else begin
            if (cnt == 2'b11) begin
                // If counter reaches 3 (last bit of current data), process next parallel input
                data <= d;          // Load the new parallel input into the data register
                dout <= d[3];       // Output the MSB of the new data
                cnt <= 2'b00;       // Reset counter
                valid_out <= 1'b1;  // Set valid signal
            end else begin
                // During serialization process
                dout <= data[3];             // Output the current MSB of the data register
                data <= {data[2:0], 1'b0};   // Shift the data register left by 1
                cnt <= cnt + 1'b1;           // Increment counter
                valid_out <= 1'b0;           // Clear valid signal during intermediate bits
            end
        end
    end

endmodule
