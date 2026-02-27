module dut (
    input wire clk,       // Clock signal
    input wire rst_n,     // Active low reset
    input wire [3:0] d,   // 4-bit parallel data input
    output reg valid_out, // Valid signal for serial output
    output reg dout       // Serial output
);

    // Internal registers
    reg [3:0] data; // Register to hold the shifting data
    reg [1:0] cnt;  // 2-bit counter for the 4 states (0 to 3)

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset behavior
            cnt <= 2'b0;
            dout <= 1'b0;
            valid_out <= 1'b0;
            data <= 4'b0;
        end else begin
            // Normal operation
            if (cnt == 2'b11) begin
                // When processing the last bit
                data <= d;         // Load new 4-bit parallel data
                dout <= d[3];      // Output MSB of the new input data
                cnt <= 2'b0;       // Reset counter
                valid_out <= 1'b1; // Set valid output
            end else begin
                // For other cycles
                dout <= data[2];        // Shift bits (next MSB becomes dout)
                data <= {data[1:0], 1'b0}; // Shift data register left
                cnt <= cnt + 1'b1;      // Increment counter
                valid_out <= 1'b0;      // Output is not valid in intermediate cycles
            end
        end
    end

endmodule
