module parallel2serial (
    input clk,              // Clock signal used for synchronous operations
    input rst_n,            // Active-low reset signal
    input [3:0] d,          // 4-bit parallel data input
    output reg valid_out,   // Valid signal indicating availability of serial output
    output reg dout         // Serial output representing the converted data
);

    reg [3:0] data;         // Register to store the parallel data
    reg [1:0] cnt;          // 2-bit counter to keep track of which bit to output

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset state: Initialize counter, data, valid_out, and dout
            cnt <= 2'b00;
            data <= 4'b0000;
            valid_out <= 1'b0;
            dout <= 1'b0;
        end else begin
            // Check if the counter has reached the last bit
            if (cnt == 2'b11) begin
                // Assign the parallel input to the data register
                data <= d;
                // Reset counter to zero for next sequence
                cnt <= 2'b00;
                // Set dout to MSB of the input
                dout <= d[3];
                // Set the valid_out signal to indicate valid output
                valid_out <= 1'b1;
            end else begin
                // Shift the data left by one bit (MSB becomes LSB)
                data <= {data[2:0], 1'b0};
                // Increment the counter
                cnt <= cnt + 1;
                // Assign dout to the current MSB
                dout <= data[3];
                // Clear the valid_out signal
                valid_out <= 1'b0;
            end
        end
    end
endmodule
