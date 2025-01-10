module parallel2serial (
    input wire clk,         // Clock signal
    input wire rst_n,       // Active low reset signal
    input wire [3:0] d,     // 4-bit parallel data input
    output reg valid_out,   // Valid signal for output data
    output reg dout         // Serial data output
);

reg [3:0] data;    // Register to hold the input data
reg [2:0] cnt;     // 3-bit counter, to count from 0 to 3

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Reset logic
        cnt <= 3'd0;
        valid_out <= 1'b0;
        dout <= 1'b0;
    end else begin
        if (cnt == 3'd0) begin
            // Load the parallel data into the register when count is zero
            data <= d;
            valid_out <= 1'b1; // Set valid_out to 1 to indicate output is valid
        end else begin
            valid_out <= 1'b0;
        end
        
        dout <= data[3];  // Output the MSB of the data register
        data <= data << 1;  // Shift data left by one bit

        if (cnt == 3'd3) begin
            cnt <= 3'd0;  // Reset counter after 4 cycles
        end else begin
            cnt <= cnt + 3'd1;  // Increment counter
        end
    end
end

endmodule
