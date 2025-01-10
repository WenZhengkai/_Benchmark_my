module parallel2serial(
    input wire clk,         // Clock signal
    input wire rst_n,       // Active low reset
    input wire [3:0] d,     // 4-bit parallel input data
    output reg valid_out,   // Valid output signal
    output reg dout         // Serial data output
);

    // Data register to hold the parallel data
    reg [3:0] data;
    // Counter to track the current bit being sent
    reg [1:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset condition
            cnt <= 0;
            data <= 0;
            dout <= 0;
            valid_out <= 0;
        end else begin
            if (cnt == 0) begin
                // Load the new parallel data into the data register
                data <= d;
                dout <= d[3];  // Output the MSB first
                valid_out <= 1; // Signal that valid output is available
                cnt <= cnt + 1; // Increment the counter
            end else if (cnt < 4) begin
                dout <= data[2];  // Output the next bit
                data <= {data[2:0], 1'b0}; // Shift left, introducing a zero at LSB
                cnt <= cnt + 1; // Increment the counter
                if (cnt == 3)
                    valid_out <= 0; // Set valid_out to 0 on the last output
            end
        end
    end

endmodule
